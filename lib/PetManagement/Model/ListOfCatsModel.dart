class ListOfCatsModel {
  List<CatDetails>? listOfCat;

  ListOfCatsModel(this.listOfCat);

  ListOfCatsModel.formJson(Map<String, dynamic> map) {
    listOfCat = <CatDetails>[];
    map['listOfCats'].forEach((v) {
      listOfCat!.add(CatDetails.fromMap(v));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listOfCat != null) {
      data['listOfCats'] = this.listOfCat!.map((v) => v.toMap()).toList();
    }
    return data;
  }
}

class CatDetails {
  String? name;
  String? breed;
  String? description;

  CatDetails(this.name, this.breed, this.description);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> mapToReturn = new Map();
    mapToReturn["name"] = this.name;
    mapToReturn["breed"] = this.breed;
    mapToReturn["description"] = this.description;
    return mapToReturn;
  }

  CatDetails.fromMap(Map<String, dynamic> map) {
    name = map["name"];
    breed = map["breed"];
    description = map["description"];
  }
}
