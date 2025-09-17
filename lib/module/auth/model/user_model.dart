class UserModel
{
  final String? uid;
  final String? email;
  final String? displayName;
  final String? photoUrl;

  UserModel({required this.uid,required this.email,required this.displayName,required this.photoUrl});

  Map<String, dynamic> toMap() => {
    'uid': uid,
    'email': email,
    'displayName': displayName,
    'photoUrl': photoUrl,
  };

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
    uid: map['uid'],
    email: map['email'],
    displayName: map['displayName'],
    photoUrl: map['photoUrl'],
  );
}