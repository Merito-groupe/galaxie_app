// lib/models/advertisement_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Advertisement {
  final String? title;
  final String? advertiserName;
  final String? url;
  final String? city;
  final String? routes;
  final DateTime? startTime;
  final DateTime? endTime;

  Advertisement({
    this.title,
    this.advertiserName,
    this.url,
    this.city,
    this.routes,
    this.startTime,
    this.endTime,
  });

  factory Advertisement.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Advertisement(
      title: data['title'] as String?,
      advertiserName: data['advertiserName'] as String?,
      url: data['url'] as String?,
      city: data['city'] as String?,
      routes: data['routes'] as String?,
      startTime: data['startTime']?.toDate(),
      endTime: data['endTime']?.toDate(),
    );
  }
}
