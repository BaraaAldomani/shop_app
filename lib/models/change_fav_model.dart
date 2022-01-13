class ChangeFav {
  late  bool status;
  late  String msg;

  ChangeFav.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
  }
}
