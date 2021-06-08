class Disease {
  String response;

  Disease({this.response});

  factory Disease.fromJson(Map<String, dynamic> json) => Disease(
        response: json["number"],
      );

  Map<String, dynamic> toJson() => {
        "number": response,
      };
}
