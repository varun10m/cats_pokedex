import 'package:flutter/material.dart';
import 'package:pet_management/PetManagement/BLOC/BLOC.dart';
import 'package:pet_management/PetManagement/Model/ListOfCatsModel.dart';
import 'package:pet_management/Utils/ProgressDialog.dart';
import 'package:pet_management/Utils/utils.dart';

class AddAndEditACatDetails extends StatefulWidget {
  final List<CatDetails>? listOfCatDetails;
  final int? index;
  AddAndEditACatDetails({this.listOfCatDetails, this.index});
  @override
  _AddAndEditACatDetailsState createState() => _AddAndEditACatDetailsState();
}

class _AddAndEditACatDetailsState extends State<AddAndEditACatDetails> {
  PetManagementBloc? _bloc = PetManagementBloc.getInstance();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  TextEditingController _nameController = new TextEditingController();

  TextEditingController _breedController = new TextEditingController();

  TextEditingController _descriptionController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(),
      body: getBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: widget.index == null ? Text("Add Cat") : Text("Edit Cat"),
    );
  }

  Widget getBody() {
    return Column(
      children: [
        getTextFormField(_nameController, "Name", "Enter Cat's Name"),
        getTextFormField(_breedController, "Breed", "Enter Cat's Breed"),
        getTextFormField(
            _descriptionController, "Description", "Enter Cat's Description"),
        ElevatedButton(onPressed: () => _onPressed(), child: Text("Submit")),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      _nameController.text = widget.listOfCatDetails![widget.index!].name!;
      _breedController.text = widget.listOfCatDetails![widget.index!].breed!;
      _descriptionController.text =
          widget.listOfCatDetails![widget.index!].description!;
    }
  }

  Future<void> _onPressed() async {
    CatDetails details = CatDetails(_nameController.text, _breedController.text,
        _descriptionController.text);
    if (widget.index != null) {
      onEditPressed(details);
    }
    widget.listOfCatDetails!.add(details);
    ProgressDialog dialog = ProgressDialog(context, isDismissible: false);
    dialog.style(message: 'Please wait...');
    await dialog.show();
    String response = await _bloc!.addCatToList(widget.listOfCatDetails!);
    await dialog.hide();
    if (response == "success") {
      Navigator.pop(context);
    } else {
      showErrorMessageInSnackBar(
          context, "An Error Occured Please try again", _scaffoldKey);
    }
  }

  void onEditPressed(CatDetails details) async {
    widget.listOfCatDetails!.removeAt(widget.index!);
  }
}
