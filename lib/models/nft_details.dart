class NftDetails {
  NftDetails({
    required this.nftId,
    required this.accountAddress,
    required this.contractAddress,
    required this.signature,
  });

  final String nftId;
  final String accountAddress;
  final String contractAddress;
  final String signature;
}
