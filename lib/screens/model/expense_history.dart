class ExpenseHistory {
  String? message;
  String? date;
  List<Expense>? expense;
  int? totalAmount;

  ExpenseHistory({this.message, this.date, this.expense, this.totalAmount});

  ExpenseHistory.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    date = json['date'];
    if (json['expense'] != null) {
      expense = <Expense>[];
      json['expense'].forEach((v) {
        expense!.add(new Expense.fromJson(v));
      });
    }
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['date'] = this.date;
    if (this.expense != null) {
      data['expense'] = this.expense!.map((v) => v.toJson()).toList();
    }
    data['total_amount'] = this.totalAmount;
    return data;
  }
}

class Expense {
  int? id;
  String? categoryId;
  String? details;
  String? amount;
  String? date;
  String? createdAt;
  String? updatedAt;
  String? categoryName;

  Expense(
      {this.id,
      this.categoryId,
      this.details,
      this.amount,
      this.date,
      this.createdAt,
      this.updatedAt,
      this.categoryName});

  Expense.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    details = json['details'];
    amount = json['amount'];
    date = json['date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['details'] = this.details;
    data['amount'] = this.amount;
    data['date'] = this.date;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['category_name'] = this.categoryName;
    return data;
  }
}
