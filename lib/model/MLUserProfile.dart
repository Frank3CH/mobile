class MLUserProfile {
  String? name;
  String? email;
  String? firstname;
  String? lastName;
  String? username;
  String? Codewave;
  String? solde;

  MLUserProfile({this.name,this.email,this.firstname,this.lastName,this.username,this.solde, this.Codewave});


  factory MLUserProfile.fromJson(Map<String, dynamic> json) {
    return MLUserProfile(
      name: json['name'],
      email: json['email'],
      firstname: json['firstname'],
      lastName: json['lastName'],
      username: json['username'],
      Codewave: json['codeWave'],
      solde: json['solde'],
    );
  }
}
