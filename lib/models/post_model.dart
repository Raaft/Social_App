class PostModel {
  String name;
  String uId;
  String image;
  String dateTime;
  String text;
  String postImage;

  PostModel({
    this.name,
    this.postImage,
    this.text,
    this.uId,
    this.image,
    this.dateTime,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dateTime = json['dateTime'];
    text = json['text'];
    uId = json['uId'];
    image = json['image'];
    postImage = json['postImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'postImage': postImage,
      'text': text,
      'uId': uId,
      'image': image,
      'dateTime': dateTime,
    };
  }
}
