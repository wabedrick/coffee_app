class User {
  late final String userid;
  late final String useremail;
  late final String userpassword;


  User({required this.userid, required this.useremail, required this.userpassword});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userid: json['userid'],
      useremail: json['useremail'],
      userpassword: json['userpassword'],
    );
  }

  Map<String, dynamic> toJson() => {
    'userid' : userid,
    'useremail': useremail,
    'userpassword': userpassword,
  };
}
