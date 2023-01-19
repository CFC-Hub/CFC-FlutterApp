import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cfc/models/cfc_models.dart';
import 'package:cfc/screens/cfc_screens.dart';
import 'package:cfc/services/cfc_api_client.dart';
import 'package:cfc/services/cfc_firebase_firestore.dart';
import 'package:cfc/utils/cfc_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:walletconnect_secure_storage/walletconnect_secure_storage.dart';
import 'package:web3dart/web3dart.dart';

class ConnectMetaMaskController extends GetxController {
  final sessionStorage = WalletConnectSecureStorage();
  final CFCApiClient _cfcApiClient = CFCApiClient();
  String _uri = '';
  Rx<String?> signature = Rx<String?>(null);
  final Rx<SessionStatus?> sessionStatus = Rx<SessionStatus?>(null);
  RxBool isLoading = false.obs;
  RxBool isCreatePopProfile = true.obs;
  RxBool isCreatePopProfileError = false.obs;
  RxBool isAppNotFound = false.obs;

  final Web3Client ethClient = Web3Client('http://51.138.184.126:8545', Client());

  WalletConnect? _connector;

  String getNetworkName(chainId) {
    switch (chainId) {
      case 1:
        return 'Ethereum Mainnet';
      case 3:
        return 'Ropsten Testnet';
      case 4:
        return 'Rinkeby Testnet';
      case 5:
        return 'Goreli Testnet';
      case 42:
        return 'Kovan Testnet';
      case 137:
        return 'Polygon Mainnet';
      case 80001:
        return 'Mumbai Testnet';
      case 1337:
        return 'CFC';
      default:
        return 'Unknown Chain';
    }
  }

  Future<void> initWalletConnect() async {
    final session = await sessionStorage.getSession();
    _connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      session: session,
      sessionStorage: sessionStorage,
      clientMeta: const PeerMeta(
        name: 'CFC',
        description: 'An app for CFC.',
        url: 'https://walletconnect.org',
        icons: [CFCConstant.appLogoUrl],
      ),
    );
    if (session != null) {
      if (session.chainId != 1337) {
        _connector!.killSession().then((value) {
          createMetamaskSession();
        });
      } else if (!_connector!.connected) {
        createMetamaskSession();
      } else {
        String uri = "wc:${session.handshakeTopic}@${session.version}?bridge=${session.bridge}&key=${session.key}";
        _uri = uri;
        sessionStatus.value = SessionStatus(chainId: session.chainId, accounts: session.accounts);
      }
    } else {
      createMetamaskSession();
    }
  }

  Future<void> createMetamaskSession() async {
    if (!_connector!.connected) {
      try {
        sessionStatus.value = await _connector?.createSession(
          chainId: 1337,
          onDisplayUri: (uri) async {
            await sessionStorage.store(_connector!.session);
            await sessionStorage.getSession();
            _uri = uri;
            try {
              await launchUrlString(uri, mode: LaunchMode.externalApplication);
            } on PlatformException catch (error) {
              if (error.code == 'ACTIVITY_NOT_FOUND') {
                isAppNotFound.value = true;
              } else {
                CFCHelper.showError(message: 'Failed to connect metamask.');
              }
            }
          },
        );
      } on FlutterError catch (error, stack) {
        CFCHelper.showError(message: 'Failed to connect metamask.');
        debugPrintStack(label: error.message.toString(), stackTrace: stack);
      } catch (error, stack) {
        CFCHelper.showError(message: 'Failed to connect metamask.');
        debugPrintStack(label: error.toString(), stackTrace: stack);
      }
    }
  }

  /// Loading abi and contract from http
  Future<DeployedContract> loadContract({required NftType nftType}) async {
    Map<String, dynamic> response = {};
    String contractName = '';
    if (nftType == NftType.createPopNFT) {
      response = await _cfcApiClient.getPopNFT();
      contractName = 'PopNFT';
    } else {
      response = await _cfcApiClient.getLearningNFT();
      contractName = 'LearningNFT';
    }
    String abi = jsonEncode(response['abi']);
    String contractAddress = response['network']['1337']['address'];
    final contract =
        DeployedContract(ContractAbi.fromJson(abi, contractName), EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  Future<String> sendTransaction({
    required DeployedContract contract,
    required String functionName,
    required List<dynamic> parameters,
    required String accountAddress,
    required String contractAddress,
  }) async {
    final ethFunction = contract.function(functionName);
    Transaction transaction =
        Transaction.callContract(contract: contract, function: ethFunction, parameters: parameters);
    EthereumWalletConnectProvider provider = EthereumWalletConnectProvider(_connector!);
    try {
      await launchUrlString(_uri, mode: LaunchMode.externalApplication);
    } on PlatformException catch (error) {
      isLoading.value = false;
      if (error.code == 'ACTIVITY_NOT_FOUND') {
        isAppNotFound.value = true;
      } else {
        CFCHelper.showError(message: 'Failed to connect metamask.');
        isCreatePopProfileError.value = true;
      }
    }

    var signature = await provider.sendTransaction(
      from: accountAddress,
      to: contractAddress,
      data: transaction.data,
      gas: 9999999, // default
    );

    return signature;
  }

  /// create NFT
  Future<void> createNFT(
      {required NftType nftType,
      required String firstName,
      required String lastName,
      required String contentId}) async {
    isLoading.value = true;
    isCreatePopProfileError.value = false;
    try {
      DeployedContract contract = await loadContract(nftType: nftType);
      String contractAddress = contract.address.hex;
      int nftId = await getNftIdLastCount();
      String functionName = '';
      List parameters = [];
      if (nftType == NftType.createPopNFT) {
        functionName = 'createPopNFT';
        parameters = [firstName, lastName, BigInt.from(nftId)];
      } else {
        int submittedTimestamp = DateTime.now().millisecondsSinceEpoch;
        functionName = 'createLearningNFT';
        parameters = [BigInt.from(nftId), firstName, lastName, contentId, BigInt.from(submittedTimestamp)];
      }
      var signature = await sendTransaction(
          contract: contract,
          functionName: functionName,
          parameters: parameters,
          accountAddress: sessionStatus.value!.accounts[0],
          contractAddress: contractAddress);
      this.signature.value = signature;

      isLoading.value = false;
      Get.back(
          result: NftDetails(
              nftId: nftId.toString(),
              accountAddress: sessionStatus.value!.accounts[0],
              contractAddress: contractAddress,
              signature: signature));
    } catch (e, s) {
      isLoading.value = false;
      isCreatePopProfileError.value = true;
      CFCHelper.showError(message: 'Metamask not connecting. Please try again.');
      debugPrintStack(label: e.toString(), stackTrace: s);
    }
  }

  Future<int> getNftIdLastCount() async {
    int? id;
    var firestore = CFCFirebaseFireStore();
    var document = await firestore.getNftIdLastCount();
    var data = document.data();
    if (data != null) {
      id = data['nftIdLastCount'] + 1;
      Map<String, int> updatedNftId = {'nftIdLastCount': id!};
      await firestore.setNftIdLastCount(nft: updatedNftId);
    }
    return id!;
  }
}
