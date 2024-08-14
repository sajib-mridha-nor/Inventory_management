class ProductsSuplirer {
  String? message;
  List<Suplirer>? data;

  ProductsSuplirer({this.message, this.data});

  ProductsSuplirer.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Suplirer>[];
      json['data'].forEach((v) {
        data!.add(new Suplirer.fromJson(v));
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

class Suplirer {
  int? id;
  String? vendorName;
  String? vendorEmail;
  String? vendorPhone;
  String? vendorAddress;
  String? status;
  String? createdAt;
  String? updatedAt;

  Suplirer(
      {this.id,
      this.vendorName,
      this.vendorEmail,
      this.vendorPhone,
      this.vendorAddress,
      this.status,
      this.createdAt,
      this.updatedAt});

  Suplirer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorName = json['vendor_name'];
    vendorEmail = json['vendor_email'];
    vendorPhone = json['vendor_phone'];
    vendorAddress = json['vendor_address'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_name'] = this.vendorName;
    data['vendor_email'] = this.vendorEmail;
    data['vendor_phone'] = this.vendorPhone;
    data['vendor_address'] = this.vendorAddress;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
