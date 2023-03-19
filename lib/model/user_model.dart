class UserModel {
  String? uid;
  String? name;
  String? email;
  String? profilePic;

  UserModel( {this.uid, this.name, this.email, this.profilePic});

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
        uid: map['uid'],
        name: map['name'],
        email: map['email'],
        profilePic: map['profilePic']);
  }
  Map<String, dynamic> toMap() {
    return {
      'uid': uid??"",
      'name': name??"",
      'email': email ?? "",
      'profilePic': profilePic ?? "",
    };
  }
}
