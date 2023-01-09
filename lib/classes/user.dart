class UserToApi {
  late String uid;
  final String nickname;
  late String picture;
  late int win;
  late int lose;
  // ignore: non_constant_identifier_names
  late String favourite_categoryy;
  // ignore: non_constant_identifier_names
  late String max_points;
  UserToApi({required this.nickname});
  factory UserToApi.fromJson(Map<String, dynamic> json) {
    return UserToApi(
      nickname: json['nickname'],
    );
  }
}
