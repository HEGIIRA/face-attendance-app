import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeeModel {
  final String id;
  final String name;
  final String position;
  final String division;
  final String ownerUid;
  final Timestamp? createdAt;

  EmployeeModel({
    required this.id,
    required this.name,
    required this.position,
    required this.division,
    required this.ownerUid,
    this.createdAt,
  });

  factory EmployeeModel.fromMap(Map<String, dynamic> map, String id) {
    return EmployeeModel(
      id: id,
      name: map['name'] ?? '',
      position: map['position'] ?? '',
      division: map['division'] ?? '',
      ownerUid: map['ownerUid'] ?? '',
      createdAt: map['createdAt'] as Timestamp?,
    );
  }

  factory EmployeeModel.fromFirestore(DocumentSnapshot doc) {
    return EmployeeModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  }
}
