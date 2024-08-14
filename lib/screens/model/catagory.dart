class ProductsCatagory {
  int? id;
  String? name;
  String? status;

  ProductsCatagory({this.id, this.name, this.status});

  ProductsCatagory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    return data;
  }
}
