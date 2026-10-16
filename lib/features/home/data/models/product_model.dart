import 'package:ecommerce_app_huma_volve/features/home/data/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {

  String? slug;
  CategoryModel? category;
  String? creationAt;
  String? updatedAt;

  ProductModel({
    super.id,
    super.title,
    this.slug,
    super.price,
    super.description,
    super.images,
    this.category,
    this.creationAt,
    this.updatedAt,
  });

  ProductModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    price = json['price'];
    description = json['description'];
    category = json['category'] != null
        ? CategoryModel.fromJson(json['category'])
        : null;
    images = json['images'] != null ? json['images'].cast<String>() : [];
    creationAt = json['creationAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['slug'] = slug;
    map['price'] = price;
    map['description'] = description;
    if (category != null) {
      map['category'] = category?.toJson();
    }
    map['images'] = images;
    map['creationAt'] = creationAt;
    map['updatedAt'] = updatedAt;
    return map;
  }

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      title: title,
      price: price,
      description: description,
      images: images,
    );
  }
}
