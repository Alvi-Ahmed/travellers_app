import 'dart:convert';

import 'package:equatable/equatable.dart';

class Places extends Equatable {
  final String placeName;
  final String city;
  final double lat;
  final double long;
  final String image; // how long this movie is (in minute)
  const Places({
    required this.placeName,
    required this.city,
    required this.lat,
    required this.long,
    required this.image,
  });

  Places copyWith({
    String? placeName,
    String? city,
    double? lat,
    double? long,
    String? image,
  }) {
    return Places(
      placeName: placeName ?? this.placeName,
      city: city ?? this.city,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'placeName': placeName,
      'city': city,
      'lat': lat,
      'long': long,
      'image': image,
    };
  }

  factory Places.fromMap(Map<String, dynamic> map) {
    return Places(
      placeName: map['placeName'] ?? '',
      city: map['city'] ?? '',
      lat: map['lat']?.toDouble() ?? 0.0,
      long: map['long']?.toDouble() ?? 0.0,
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Places.fromJson(String source) => Places.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Places(placeName: $placeName, city: $city, lat: $lat, long: $long, image: $image)';
  }

  @override
  List<Object> get props {
    return [
      placeName,
      city,
      lat,
      long,
      image,
    ];
  }
}
