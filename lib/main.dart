import 'package:cfc/firebase_options.dart';
import 'package:cfc/hive/cfc_hives.dart';
import 'package:cfc/hive/cfc_secure_key.dart';
import 'package:cfc/models/cfc_models.dart';
import 'package:cfc/screens/cfc_screens.dart';
import 'package:cfc/services/cfc_firebase_auth.dart';
import 'package:cfc/services/cfc_firebase_instance.dart';
import 'package:cfc/utils/cfc_utils.dart';
import 'package:cfc/widgets/cfc_widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: CFCConstant.environmentFileName);
  await initialFirebase();
  await setSystemChromeFeatures();
  await initialHive();
  initialGetXControllers();
  runApp(const CFCApp());
}

Future<void> initialFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

Future<void> initialHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter<PopProfile>(PopProfileAdapter());
  Hive.registerAdapter<DeviceInfo>(DeviceInfoAdapter());
  Hive.registerAdapter<Questions>(QuestionsAdapter());
  List<int> key = await CFCSecureKey().getPopProfileBoxSecureKey();
  await Hive.openBox<PopProfile>(CFCHiveBoxNames.popProfileBox, encryptionCipher: HiveAesCipher(key));
}

class CFCApp extends StatelessWidget {
  const CFCApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: CFCConstant.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: CFCAppColors.appPrimaryMaterialColor,
        appBarTheme: CFCWidgetHelper.appBarTheme,
        scaffoldBackgroundColor: CFCAppColors.primaryBackground,
      ),
      home: CFCFirebaseAuth().getCurrentUser != null ? const Dashboard() : const StartInfo(),
    );
  }
}

Future<void> setSystemChromeFeatures() async {
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    statusBarColor: Colors.transparent, // transparent status bar
    systemNavigationBarColor: Colors.transparent, // navigation bar color
    statusBarIconBrightness: Brightness.light, // status bar icons' color
    systemNavigationBarIconBrightness: Brightness.light, //navigation bar icons' color
  ));
}

void initialGetXControllers() {
  Get.put(CFCFirebaseInstance(), permanent: true);
}
