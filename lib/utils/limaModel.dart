class LimaModel {
    String? text,image;
    LimaModel({
      this.text,
      this.image
    });

factory LimaModel.fromjson(Map<String,dynamic>map){
  return LimaModel(
    text: map[""],
    image: map[""]
  );
}  
}