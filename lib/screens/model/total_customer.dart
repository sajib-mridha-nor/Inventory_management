class TotalCustomer {
  String? message;
  int? totalCustomer;

  TotalCustomer({this.message, this.totalCustomer});

  TotalCustomer.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    totalCustomer = json['totalCustomer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['totalCustomer'] = this.totalCustomer;
    return data;
  }
}
