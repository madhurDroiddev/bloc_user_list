

class Data {
    String avatar;
    String email;
    String first_name;
    int id;
    String last_name;

    Data({this.avatar, this.email, this.first_name, this.id, this.last_name});

    factory Data.fromJson(Map<String, dynamic> json) {
        return Data(
            avatar: json['avatar'], 
            email: json['email'], 
            first_name: json['first_name'], 
            id: json['id'], 
            last_name: json['last_name'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['avatar'] = this.avatar;
        data['email'] = this.email;
        data['first_name'] = this.first_name;
        data['id'] = this.id;
        data['last_name'] = this.last_name;
        return data;
    }
}