import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_management/PetManagement/BLOC/BLOC.dart';
import 'package:pet_management/PetManagement/Model/ListOfCatsModel.dart';
import 'package:pet_management/PetManagement/UI/AddAndEditACatDetails.dart';
import 'package:pet_management/Utils/ProgressDialog.dart';
import 'package:pet_management/Utils/utils.dart';

class ListOfCats extends StatefulWidget {
  @override
  _ListOfCatsState createState() => _ListOfCatsState();
}

class _ListOfCatsState extends State<ListOfCats> {
  PetManagementBloc? _bloc = PetManagementBloc.getInstance();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  late List<CatDetails> listOfCats;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: getAppBar(),
      body: getList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addCat(),
        child: Icon(Icons.add),
      ),
    );
  }

  PreferredSizeWidget getAppBar() {
    return AppBar(
      title: Text("List of Cats"),
    );
  }

  Widget? getList() {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: _bloc!.getStreamOfCatsList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return getDefaultLoading();
          ListOfCatsModel? listOfCatsModel;
          if ((snapshot.data != null && snapshot.data!.data() != null)) {
            listOfCatsModel = ListOfCatsModel.formJson(snapshot.data!.data()!);
            listOfCats = listOfCatsModel.listOfCat!;
            print(listOfCats.length);
          }
          if (listOfCats.length == 0) {
            return Center(child: Text("No Data"));
          }
          return ListView.builder(
              itemCount: listOfCatsModel!.listOfCat!.length,
              itemBuilder: (context, index) {
                return getListTile(listOfCatsModel!.listOfCat![index], index,
                    listOfCatsModel.listOfCat!);
              });
        });
  }

  Widget getListTile(
      CatDetails catDetails, int index, List<CatDetails> listOfCat) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          title: Text(
            catDetails.name! + "-" + catDetails.breed!,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
          ),
          subtitle: Text(catDetails.description!),
          trailing: Wrap(
            children: [
              IconButton(
                  onPressed: () => onEditPressed(listOfCat, index),
                  icon: Icon(
                    Icons.edit,
                    color: Colors.deepPurpleAccent,
                  )),
              IconButton(
                  onPressed: () => onDeletePressed(listOfCat, index),
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void onEditPressed(List<CatDetails> listOfCat, int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddAndEditACatDetails(
                  index: index,
                  listOfCatDetails: listOfCat,
                )));
  }

  Future<void> onDeletePressed(List<CatDetails> listOfCat, int index) async {
    listOfCat.removeAt(index);
    ProgressDialog dialog = ProgressDialog(context, isDismissible: false);
    dialog.style(message: 'Please wait...');
    await dialog.show();
    String response = await _bloc!.addCatToList(listOfCat);
    await dialog.hide();
    if (response == "success") {
      showErrorMessageInSnackBar(
          context, "Successfully updated!", _scaffoldKey);
    } else {
      showErrorMessageInSnackBar(
          context, "An Error Occured Please try again", _scaffoldKey);
    }
  }

  void addCat() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddAndEditACatDetails(
                  listOfCatDetails: listOfCats,
                )));
  }
}
