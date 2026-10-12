import 'package:ecommerce_app_huma_volve/features/home/models/category_model.dart';

class ProductModel {
  ProductModel({
      this.id, 
      this.title, 
      this.slug, 
      this.price, 
      this.description, 
      this.category, 
      this.images, 
      this.creationAt, 
      this.updatedAt,});

  ProductModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    price = json['price'];
    description = json['description'];
    category = json['category'] != null ? CategoryModel.fromJson(json['category']) : null;
    images = json['images'] != null ? json['images'].cast<String>() : [];
    creationAt = json['creationAt'];
    updatedAt = json['updatedAt'];
  }
  num? id;
  String? title;
  String? slug;
  num? price;
  String? description;
  CategoryModel? category;
  List<String>? images;
  String? creationAt;
  String? updatedAt;
ProductModel copyWith({  num? id,
  String? title,
  String? slug,
  num? price,
  String? description,
  CategoryModel? category,
  List<String>? images,
  String? creationAt,
  String? updatedAt,
}) => ProductModel(  id: id ?? this.id,
  title: title ?? this.title,
  slug: slug ?? this.slug,
  price: price ?? this.price,
  description: description ?? this.description,
  category: category ?? this.category,
  images: images ?? this.images,
  creationAt: creationAt ?? this.creationAt,
  updatedAt: updatedAt ?? this.updatedAt,
);
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

}

