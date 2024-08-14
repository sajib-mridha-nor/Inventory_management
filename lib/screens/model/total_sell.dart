class TotalSell {
  String? message;
  String? totalSell;

  TotalSell({this.message, this.totalSell});

  TotalSell.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    totalSell = json['totalSell'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['totalSell'] = this.totalSell;
    return data;
  }
}
