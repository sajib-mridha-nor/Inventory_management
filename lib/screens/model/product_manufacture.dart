class ProductsManufacture {
  String? message;
  List<Manufacture>? data;

  ProductsManufacture({this.message, this.data});

  ProductsManufacture.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Manufacture>[];
      json['data'].forEach((v) {
        data!.add(new Manufacture.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Manufacture {
  int? id;
  String? manufactureName;
  String? status;
  String? createdAt;
  String? updatedAt;

  Manufacture(
      {this.id,
      this.manufactureName,
      this.status,
      this.createdAt,
      this.updatedAt});

  Manufacture.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    manufactureName = json['manufacture_name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['manufacture_name'] = this.manufactureName;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
