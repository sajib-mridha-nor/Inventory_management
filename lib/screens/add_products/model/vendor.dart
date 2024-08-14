class VendorResponse {
  String? message;
  List<Vendor>? data;

  VendorResponse({this.message, this.data});

  VendorResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Vendor>[];
      json['data'].forEach((v) {
        data!.add(new Vendor.fromJson(v));
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

class Vendor {
  int? id;
  String? vendorName;
  String? vendorEmail;
  String? vendorPhone;
  String? vendorAddress;
  String? status;
  String? createdAt;
  String? updatedAt;

  Vendor(
      {this.id,
      this.vendorName,
      this.vendorEmail,
      this.vendorPhone,
      this.vendorAddress,
      this.status,
      this.createdAt,
      this.updatedAt});

  Vendor.fromJson(Map<String, dynamic> json) {
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
