class Disease {
  String label;

  Disease({this.label});

  factory Disease.fromJson(Map<String, dynamic> json) => Disease(
        label: json["label"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
      };
}
