// 0:
// "ip" -> "127.0.0.1"
// 1:
// "port" -> 50232

class GameShieldModel {
  String? ip;
  int? port;

  GameShieldModel({this.ip, this.port});

  GameShieldModel.fromJson(Map<String, dynamic> json) {
    ip = json['ip'];
    port = json['port'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ip'] = ip;
    data['port'] = port;
    return data;
  }
}
