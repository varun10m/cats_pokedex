import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_management/PetManagement/Model/ListOfCatsModel.dart';
import 'package:pet_management/Repository/Sources/firestoreSource.dart';

class Repository {
  static Repository? _repository;
  late FireStoreSource? _firestoreSource;

  Repository._new() {
    _firestoreSource = FireStoreSource.getInstance();
  }

  static getRepository() {
    if (_repository == null) {
      _repository = Repository._new();
    }
    return _repository;
  }

  Future<String> addCatToList(List<CatDetails> listOfCatDetails) async {
    return await _firestoreSource!.addCatToList(listOfCatDetails);
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getStreamOfCatsList() {
    return _firestoreSource!.getStreamOfCatsList();
  }
}
