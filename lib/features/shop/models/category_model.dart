import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  String parentId;
  bool isFeatured;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.isFeatured,
    this.parentId = '',
  });

  //* Empty helper function
  static CategoryModel empty() =>
      CategoryModel(id: '', name: '', image: '', isFeatured: false);

  //* Convert the model to a Json structure so the data can be stored in Firebase
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Image': image,
      'ParentId': parentId,
      'IsFeatured': isFeatured,
    };
  }

  //* Map Json oriented document snapshot from Firebase to UserModel
  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      //* Map JSON Record to Model
      return CategoryModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        parentId: data['ParentId'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
      );
    } else {
      return CategoryModel.empty();
    }
  }
}

// class CategoryModel {
//   String id;
//   String name;
//   String image;
//   String? parentId;
//   bool featured;
//   List<CategoryModel>? children;

//   CategoryModel({
//     required this.id,
//     required this.name,
//     required this.image,
//     this.parentId,
//     required this.featured,
//     this.children,
//   });

//   factory CategoryModel.fromJson(Map<String, dynamic> json) {
//     return CategoryModel(
//       id: json['id'],
//       name: json['name'],
//       image: json['image'],
//       parentId: json['parentId'] as String?,
//       featured: json['featured'],
//       children: (json['children'] as List<dynamic>?)?.map((x) => CategoryModel.fromJson(x as Map<String, dynamic>)).toList(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'image': image,
//       'parentId': parentId,
//       'featured': featured,
//       'children': children?.map((x) => x.toJson()).toList(),
//     };
//   }
// }

