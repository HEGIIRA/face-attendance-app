import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceModel {
  final String? uid;
  final String? employeeId;
  final String name;
  final String position;
  final String division;
  final String? checkIn;
  final String? checkOut;
  final DateTime? date;
  final String? status;
  final String? description;
  final String? issueStatus;
  final DateTime? issueDate;

  AttendanceModel({
    this.uid,
    this.employeeId,
    required this.name,
    required this.position,
    required this.division,
    required this.date,
    this.checkIn,
    this.checkOut,
    this.status,
    this.description,
    this.issueDate,
    this.issueStatus,
  });

  factory AttendanceModel.fromMap(Map<String, dynamic> data) {
    return AttendanceModel(
      name: data['name'],
      position: data['position'],
      division: data['division'],
      uid: data['uid'],
      employeeId: data['employeeId'],
      checkIn: data['checkIn'],
      checkOut: data['checkOut'],
      date: (data['date'] as Timestamp).toDate(),
      status: data['status'],
      description: data['description'],
      issueDate: data['issueDate'] != null ? (data['issueDate'] as Timestamp).toDate() : null,
      issueStatus: data['issueStatus'],
    );
  }

  factory AttendanceModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AttendanceModel.fromMap(data);
  }
  
}
