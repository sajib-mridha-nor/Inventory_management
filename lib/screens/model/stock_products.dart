class StockProducts {
  String? message;
  List<StockProduct>? data;

  StockProducts({this.message, this.data});

  StockProducts.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <StockProduct>[];
      json['data'].forEach((v) {
        data!.add(new StockProduct.fromJson(v));
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

class StockProduct {
  int? id;
  String? productCode;
  String? categoryName;
  String? manufactureName;
  String? purchaseVendor;
  String? type;
  String? size;
  String? modelNo;
  String? manufacturerId;
  String? purchaseQuantity;
  String? purchaseSupplierId;
  String? unitPrice;
  String? purchaseQuantityToAfterSell;
  String? productImage;
  String? status;
  String? createdAt;
  String? updatedAt;

  StockProduct(
      {this.id,
      this.productCode,
      this.categoryName,
      this.manufactureName,
      this.purchaseVendor,
      this.type,
      this.size,
      this.modelNo,
      this.manufacturerId,
      this.purchaseQuantity,
      this.purchaseSupplierId,
      this.unitPrice,
      this.purchaseQuantityToAfterSell,
      this.productImage,
      this.status,
      this.createdAt,
      this.updatedAt});

  StockProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productCode = json['product_code'];
    categoryName = json['category_name'];
    manufactureName = json['manufacture_name'];
    purchaseVendor = json['purchase_vendor'];
    type = json['type'];
    size = json['size'];
    modelNo = json['model_no'];
    manufacturerId = json['manufacturer_id'];
    purchaseQuantity = json['purchase_quantity'];
    purchaseSupplierId = json['purchase_supplier_id'];
    unitPrice = json['unit_price'];
    purchaseQuantityToAfterSell = json['purchase_quantity_to_after_sell'];
    productImage = json['product_image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_code'] = this.productCode;
    data['category_name'] = this.categoryName;
    data['manufacture_name'] = this.manufactureName;
    data['purchase_vendor'] = this.purchaseVendor;
    data['type'] = this.type;
    data['size'] = this.size;
    data['model_no'] = this.modelNo;
    data['manufacturer_id'] = this.manufacturerId;
    data['purchase_quantity'] = this.purchaseQuantity;
    data['purchase_supplier_id'] = this.purchaseSupplierId;
    data['unit_price'] = this.unitPrice;
    data['purchase_quantity_to_after_sell'] = this.purchaseQuantityToAfterSell;
    data['product_image'] = this.productImage;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
