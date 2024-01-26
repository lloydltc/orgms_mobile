
import 'dart:convert';

class Contribution {
  int? id;
  String? status;
  String? description;
  num? amount;
  num? userId;
  String? createdAt;
  String? updatedAt;

  Contribution(
      {this.id,
        this.status,
        this.description,
        this.amount,
        this.userId,
        this.createdAt,
        this.updatedAt});

  Contribution.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    description = json['description'];
    amount = json['amount'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['description'] = this.description;
    data['amount'] = this.amount;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}