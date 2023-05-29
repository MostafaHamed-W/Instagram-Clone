class User {
  final String email;
  final String username;
  final String uid;
  final String fullname;
  final List followers;
  final List following;

  const User({
    required this.email,
    required this.username,
    required this.uid,
    required this.fullname,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "username": username,
        "uid": uid,
        "fullname": fullname,
        "followers": followers,
        "following": following,
      };
}
