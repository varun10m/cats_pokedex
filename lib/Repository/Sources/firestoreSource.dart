import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_management/PetManagement/Model/ListOfCatsModel.dart';

class FireStoreSource {
  static FireStoreSource? _firestoreSource;
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static FireStoreSource? getInstance() {
    if (_firestoreSource == null) _firestoreSource = new FireStoreSource();
    return _firestoreSource;
  }

  Future<String> addCatToList(List<CatDetails> listOfCatDetails) async {
    try {
      ListOfCatsModel listOfCatsModel = ListOfCatsModel(listOfCatDetails);
      return await _firestore
          .collection("cats")
          .doc("yoni11T5QZE5mdWhj5RM")
          .update(listOfCatsModel.toJson())
          .then((value) => "success");
    } catch (error) {
      print(error.toString());
      return "error";
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getStreamOfCatsList() {
    return _firestore
        .collection("cats")
        .doc("yoni11T5QZE5mdWhj5RM")
        .snapshots();
  }
}
