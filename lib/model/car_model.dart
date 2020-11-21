import 'dart:convert';
import 'dart:typed_data';

class CarModel {
  final int id;
  final String name;
  final bool availability;
  final String carBody;
  final String color;
  final String equipment;
  final int modelId;
  final String modelName;
  final Uint8List photo;

  CarModel(this.id, this.name, this.availability, this.carBody, this.color, this.equipment, this.modelId,this.modelName,this.photo);

  CarModel.fromJson(Map<String, dynamic> json)
      : id = json["id_car"],
        name = json["name"],
        availability = json["availability"],
        carBody = json["car_body"],
        color = json["color"],
        equipment = json["equipment"],
        modelId = json["model_id"],
        modelName = json["model_name"],
        photo = base64Decode(json["photo"]);
}