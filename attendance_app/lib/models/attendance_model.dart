import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceModel {
  final String? uid;
  final String name;
  final String? checkIn;
  final String? checkOut;
  final DateTime? date;
  final String? status;

  AttendanceModel({
    this.uid,
    required this.name,
    this.checkIn,
    this.checkOut,
    this.date,
    this.status,
  });

  factory AttendanceModel.fromMap(Map<String, dynamic> data) {
    return AttendanceModel(
      name: data['name'] ?? '',
      uid: data['uid'] ?? '',
      checkIn: data['checkIn'] ?? '',
      checkOut: data['checkOut'] ?? '',
      date: data['date'] != null ? (data['date'] as Timestamp).toDate() : null,
      status: data['status'] ?? '',
    );
  }
}
