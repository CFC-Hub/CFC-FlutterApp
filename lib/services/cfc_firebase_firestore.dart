import 'package:cfc/models/cfc_models.dart';
import 'package:cfc/services/cfc_firebase_instance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CFCFirebaseFireStore {
  final CFCFirebaseInstance _firebaseService = Get.find<CFCFirebaseInstance>();
  late final FirebaseFirestore _database = _firebaseService.database;

  CFCFirebaseFireStore() {
    _database.settings = const Settings(persistenceEnabled: true);
  }

  Future<void> setPopProfile({required PopProfile popProfile}) async {
    await _database.collection('popProfile').doc(popProfile.createdBy).set(popProfile.toMap());
  }

  Future<void> updatePopProfile({required PopProfile popProfile}) async {
    await _database.collection('popProfile').doc(popProfile.createdBy).update(popProfile.toMap());
  }

  Future<List<QueryDocumentSnapshot<Object?>>> getPopProfileUsingEmail({required String emailAddress}) async {
    QuerySnapshot querySnapshot =
        await _database.collection('popProfile').where('emailAddress', isEqualTo: emailAddress).limit(1).get();
    return querySnapshot.docs;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getPopProfileUsingId({required String createdBy}) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await _database.collection('popProfile').doc(createdBy).get();
    return documentSnapshot;
  }

  Future<void> setMyWallet({required MyWalletDetails myWallet}) async {
    await _database.collection('myWallet').doc(myWallet.id).set(myWallet.toMap());
  }

  Future<List<QueryDocumentSnapshot<Object?>>> getMyWallet({required String createdBy}) async {
    QuerySnapshot querySnapshot = await _database.collection('myWallet').where('createdBy', isEqualTo: createdBy).get();
    return querySnapshot.docs;
  }

  Future<List<QueryDocumentSnapshot<Object?>>> getAllCourses() async {
    QuerySnapshot querySnapshot = await _database.collection('courses').get();
    return querySnapshot.docs;
  }

  Future<List<QueryDocumentSnapshot<Object?>>> getTopTenCourses() async {
    QuerySnapshot querySnapshot = await _database.collection('courses').limit(10).get();
    return querySnapshot.docs;
  }

  Future<void> setFeedback({required FeedbackDetails feedback}) async {
    await _database.collection('feedback').doc(feedback.id).set(feedback.toMap());
  }

  Future<void> setQuiz({required QuizDetails quiz}) async {
    await _database.collection('quiz').doc(quiz.id).set(quiz.toMap());
  }

  Future<void> setMyCourse({required MyCourseDetails myCourseDetails}) async {
    await _database.collection('myCourses').doc(myCourseDetails.id).set(myCourseDetails.toMap());
  }

  Future<void> updateMyCourse({required MyCourseDetails myCourseDetails}) async {
    await _database.collection('myCourses').doc(myCourseDetails.id).update(myCourseDetails.toMap());
  }

  Future<List<QueryDocumentSnapshot<Object?>>> getFeedback({required String createdBy}) async {
    QuerySnapshot querySnapshot = await _database.collection('feedback').where('createdBy', isEqualTo: createdBy).get();
    return querySnapshot.docs;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getFeedbackUsingId({required String feedbackId}) async {
    DocumentSnapshot<Map<String, dynamic>> querySnapshot = await _database.collection('feedback').doc(feedbackId).get();
    return querySnapshot;
  }

  Future<List<QueryDocumentSnapshot<Object?>>> getCourses({required String createdBy}) async {
    QuerySnapshot querySnapshot =
        await _database.collection('myCourses').where('createdBy', isEqualTo: createdBy).get();
    return querySnapshot.docs;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getNftIdLastCount() async {
    var documentSnapshot = await _database.collection('helper').doc('nftIdLastCount').get();
    return documentSnapshot;
  }

  Future<void> setNftIdLastCount({required Map<String, dynamic> nft}) async {
    await _database.collection('helper').doc('nftIdLastCount').set(nft);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getTotalCourseCount() async {
    var documentSnapshot = await _database.collection('helper').doc('totalCourseCount').get();
    return documentSnapshot;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getMyCourseUsingCourseId({
    required String createdBy,
    required String courseId,
  }) async {
    var documentSnapshot = await _database
        .collection('myCourses')
        .where('createdBy', isEqualTo: createdBy)
        .where('courseId', isEqualTo: courseId)
        .limit(1)
        .get();
    return documentSnapshot.docs;
  }
}
