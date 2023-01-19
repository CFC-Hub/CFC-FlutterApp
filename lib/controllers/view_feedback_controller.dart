import 'package:cfc/models/cfc_models.dart';
import 'package:cfc/services/cfc_firebase_firestore.dart';
import 'package:get/get.dart';

class ViewFeedbackController extends GetxController {
  ViewFeedbackController(this.myCoursesDetails);

  Rx<FeedbackDetails?> feedbackDetails = Rx<FeedbackDetails?>(null);
  MyCourseDetails myCoursesDetails;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getFeedbackDetails();
    super.onInit();
  }

  Future<void> getFeedbackDetails() async {
    try {
      isLoading.value = true;
      var docSnapshot = await CFCFirebaseFireStore().getFeedbackUsingId(feedbackId: myCoursesDetails.feedbackId);
      if (docSnapshot.data() != null) {
        feedbackDetails.value = FeedbackDetails.fromMap(docSnapshot.data()!);
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }
}
