import 'package:ecommerce_app_huma_volve/features/home/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity{
  CategoryModel({
    super.id,
    super.name,
    super.slug,
    super.image,
    super.creationAt,
    super.updatedAt,
  });

  CategoryModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    creationAt = json['creationAt'];
    updatedAt = json['updatedAt'];
  }



  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['slug'] = slug;
    map['image'] = image;
    map['creationAt'] = creationAt;
    map['updatedAt'] = updatedAt;
    return map;
  }
  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      name: name,
      slug: slug,
      image: image,
      creationAt: creationAt,
      updatedAt: updatedAt,
    );
  }
}
