class TodaySell {
  String? message;
  int? todaySell;

  TodaySell({this.message, this.todaySell});

  TodaySell.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    todaySell = json['todaySell'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['todaySell'] = this.todaySell;
    return data;
  }
}
