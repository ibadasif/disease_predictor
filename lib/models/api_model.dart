class Model {
  String img;

  Model({this.img});

  factory Model.fromMap(Map<String, dynamic> map) {
    return Model(
      img: map['img'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'img': img,
    };
  }
}
