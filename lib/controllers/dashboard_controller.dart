import 'package:cfc/hive/cfc_hives.dart';
import 'package:cfc/models/cfc_models.dart';
import 'package:cfc/screens/cfc_screens.dart';
import 'package:cfc/services/cfc_firebase_auth.dart';
import 'package:cfc/services/cfc_firebase_firestore.dart';
import 'package:cfc/utils/cfc_utils.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final AdvancedDrawerController advancedDrawerController = AdvancedDrawerController();
  final CFCPopProfileHive _popProfileHive = CFCPopProfileHive();
  Rx<PopProfile> popProfile = PopProfile.emptyValues().obs;
  final CFCFirebaseFireStore _fireStore = CFCFirebaseFireStore();
  final RxList<CourseDetails> topTenCourses = <CourseDetails>[].obs;
  RxList<MyCourseDetails> myCourseDetails = <MyCourseDetails>[].obs;

  RxBool isLoadingMyCourses = false.obs;

  RxInt totalCourses = 0.obs;

  RxBool isHiveLoaded = false.obs;

  @override
  void onInit() {
    initial();
    super.onInit();
  }

  Future<void> initial() async {
    await getPopProfileHive();
    if (popProfile.value.isPopProfileCreated) {
      getTopTenCourses();
      getMyCourses();
      getTotalCourseCount();
    }
  }

  void afterPopProfileCreate() {
    getTopTenCourses();
    getTotalCourseCount();
  }

  Future<void> getTotalCourseCount() async {
    var documentSnapshot = await _fireStore.getTotalCourseCount();
    var data = documentSnapshot.data();
    if (data != null) {
      totalCourses.value = data['totalCourseCount'];
    }
  }

  Future<void> getTopTenCourses() async {
    var documentSnapshot = await _fireStore.getTopTenCourses();
    topTenCourses.clear();
    for (var element in documentSnapshot) {
      topTenCourses.add(CourseDetails.fromMap(element.data()! as Map<String, dynamic>));
    }
  }

  Future<void> getPopProfileHive() async {
    await Future.delayed(const Duration(seconds: 0));
    PopProfile? profile = _popProfileHive.getPopProfile();
    if (profile != null) {
      popProfile.value = profile;
      isHiveLoaded.value = true;
    } else {
      logout();
      CFCHelper.showError(message: 'Your session has been closed.');
    }
  }

  Future<void> updatePopProfileInHive(PopProfile profile) async {
    await _popProfileHive.setPopProfile(profile);
    popProfile.value = profile;
  }

  void logout() {
    CFCFirebaseAuth().signOut();
    _popProfileHive.deletePopProfile();
    Get.offAll(() => const SignIn());
    Get.deleteAll();
  }

  void afterCourseComplete() {
    getMyCourses();
  }

  Future<void> getMyCourses() async {
    try {
      isLoadingMyCourses.value = true;
      myCourseDetails.clear();
      var documentSnapshot = await CFCFirebaseFireStore().getCourses(createdBy: popProfile.value.createdBy);
      for (var element in documentSnapshot) {
        myCourseDetails.add(MyCourseDetails.fromMap(element.data() as Map<String, dynamic>));
      }
      isLoadingMyCourses.value = false;
    } catch (e) {
      isLoadingMyCourses.value = false;
      CFCHelper.showError(message: 'Failed to fetch my courses details.');
    }
  }

  @override
  void onClose() {
    advancedDrawerController.dispose();
    super.onClose();
  }
}
