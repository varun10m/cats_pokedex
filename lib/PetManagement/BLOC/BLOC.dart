import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_management/PetManagement/Model/ListOfCatsModel.dart';
import 'package:pet_management/Repository/Repository.dart';

class PetManagementBloc {
  static PetManagementBloc? _instance;
  Repository _repo = Repository.getRepository();
  static PetManagementBloc? getInstance() {
    if (_instance == null) return _instance = new PetManagementBloc();
    return _instance;
  }

  Future<String> addCatToList(List<CatDetails> listOfCatDetails) async {
    return await _repo.addCatToList(listOfCatDetails);
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getStreamOfCatsList() {
    return _repo.getStreamOfCatsList();
  }
}
