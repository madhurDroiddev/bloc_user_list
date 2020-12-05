import 'Data.dart';
import 'Support.dart';

class UserListResponse {
  List<Data> data;
  int page;
  int per_page;
  Support support;
  int total;
  int total_pages;

  UserListResponse(
      {this.data,
      this.page,
      this.per_page,
      this.support,
      this.total,
      this.total_pages});

  factory UserListResponse.fromJson(Map<String, dynamic> json) {
    return UserListResponse(
      data: json['data'] != null
          ? (json['data'] as List).map((i) => Data.fromJson(i)).toList()
          : null,
      page: json['page'],
      per_page: json['per_page'],
      support:
          json['support'] != null ? Support.fromJson(json['support']) : null,
      total: json['total'],
      total_pages: json['total_pages'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['per_page'] = this.per_page;
    data['total'] = this.total;
    data['total_pages'] = this.total_pages;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.support != null) {
      data['support'] = this.support.toJson();
    }
    return data;
  }
}
