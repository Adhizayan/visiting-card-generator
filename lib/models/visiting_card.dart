import 'package:flutter/material.dart';
import 'social_media_link.dart';

enum CardTheme {
  professional,
  creative,
  minimal,
  dark,
  colorful,
}

class VisitingCard {
  final String id;
  final String fullName;
  final String profession;
  final String company;
  final String email;
  final String phone;
  final String address;
  final String website;
  final String bio;
  final List<SocialMediaLink> socialLinks;
  final CardTheme theme;
  final Color primaryColor;
  final Color secondaryColor;
  final String? logoPath;
  final String? profileImagePath;

  VisitingCard({
    required this.id,
    required this.fullName,
    required this.profession,
    this.company = '',
    required this.email,
    required this.phone,
    this.address = '',
    this.website = '',
    this.bio = '',
    this.socialLinks = const [],
    this.theme = CardTheme.professional,
    this.primaryColor = Colors.blue,
    this.secondaryColor = Colors.white,
    this.logoPath,
    this.profileImagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'profession': profession,
      'company': company,
      'email': email,
      'phone': phone,
      'address': address,
      'website': website,
      'bio': bio,
      'socialLinks': socialLinks.map((link) => link.toMap()).toList(),
      'theme': theme.index,
      'primaryColor': primaryColor.value,
      'secondaryColor': secondaryColor.value,
      'logoPath': logoPath,
      'profileImagePath': profileImagePath,
    };
  }

  factory VisitingCard.fromMap(Map<String, dynamic> map) {
    return VisitingCard(
      id: map['id'],
      fullName: map['fullName'],
      profession: map['profession'],
      company: map['company'] ?? '',
      email: map['email'],
      phone: map['phone'],
      address: map['address'] ?? '',
      website: map['website'] ?? '',
      bio: map['bio'] ?? '',
      socialLinks: (map['socialLinks'] as List<dynamic>?)
              ?.map((link) => SocialMediaLink.fromMap(link))
              .toList() ??
          [],
      theme: CardTheme.values[map['theme'] ?? 0],
      primaryColor: Color(map['primaryColor'] ?? Colors.blue.value),
      secondaryColor: Color(map['secondaryColor'] ?? Colors.white.value),
      logoPath: map['logoPath'],
      profileImagePath: map['profileImagePath'],
    );
  }

  VisitingCard copyWith({
    String? id,
    String? fullName,
    String? profession,
    String? company,
    String? email,
    String? phone,
    String? address,
    String? website,
    String? bio,
    List<SocialMediaLink>? socialLinks,
    CardTheme? theme,
    Color? primaryColor,
    Color? secondaryColor,
    String? logoPath,
    String? profileImagePath,
  }) {
    return VisitingCard(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      profession: profession ?? this.profession,
      company: company ?? this.company,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      website: website ?? this.website,
      bio: bio ?? this.bio,
      socialLinks: socialLinks ?? this.socialLinks,
      theme: theme ?? this.theme,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      logoPath: logoPath ?? this.logoPath,
      profileImagePath: profileImagePath ?? this.profileImagePath,
    );
  }
}
