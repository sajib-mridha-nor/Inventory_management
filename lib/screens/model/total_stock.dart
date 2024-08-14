class TotalStock {
  String? message;
  String? totalStock;

  TotalStock({this.message, this.totalStock});

  TotalStock.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    totalStock = json['totalStock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['totalStock'] = this.totalStock;
    return data;
  }
}
