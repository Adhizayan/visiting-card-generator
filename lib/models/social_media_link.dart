import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum SocialPlatform {
  linkedin,
  twitter,
  facebook,
  instagram,
  github,
  youtube,
  website,
  email,
  phone,
  whatsapp,
}

class SocialMediaLink {
  final String id;
  final SocialPlatform platform;
  final String url;
  final String username;

  SocialMediaLink({
    required this.id,
    required this.platform,
    required this.url,
    required this.username,
  });

  IconData get icon {
    switch (platform) {
      case SocialPlatform.linkedin:
        return FontAwesomeIcons.linkedin;
      case SocialPlatform.twitter:
        return FontAwesomeIcons.twitter;
      case SocialPlatform.facebook:
        return FontAwesomeIcons.facebook;
      case SocialPlatform.instagram:
        return FontAwesomeIcons.instagram;
      case SocialPlatform.github:
        return FontAwesomeIcons.github;
      case SocialPlatform.youtube:
        return FontAwesomeIcons.youtube;
      case SocialPlatform.website:
        return FontAwesomeIcons.globe;
      case SocialPlatform.email:
        return FontAwesomeIcons.envelope;
      case SocialPlatform.phone:
        return FontAwesomeIcons.phone;
      case SocialPlatform.whatsapp:
        return FontAwesomeIcons.whatsapp;
    }
  }

  Color get color {
    switch (platform) {
      case SocialPlatform.linkedin:
        return const Color(0xFF0077B5);
      case SocialPlatform.twitter:
        return const Color(0xFF1DA1F2);
      case SocialPlatform.facebook:
        return const Color(0xFF1877F2);
      case SocialPlatform.instagram:
        return const Color(0xFFE4405F);
      case SocialPlatform.github:
        return const Color(0xFF181717);
      case SocialPlatform.youtube:
        return const Color(0xFFFF0000);
      case SocialPlatform.website:
        return const Color(0xFF4285F4);
      case SocialPlatform.email:
        return const Color(0xFFEA4335);
      case SocialPlatform.phone:
        return const Color(0xFF34A853);
      case SocialPlatform.whatsapp:
        return const Color(0xFF25D366);
    }
  }

  String get displayName {
    switch (platform) {
      case SocialPlatform.linkedin:
        return 'LinkedIn';
      case SocialPlatform.twitter:
        return 'Twitter';
      case SocialPlatform.facebook:
        return 'Facebook';
      case SocialPlatform.instagram:
        return 'Instagram';
      case SocialPlatform.github:
        return 'GitHub';
      case SocialPlatform.youtube:
        return 'YouTube';
      case SocialPlatform.website:
        return 'Website';
      case SocialPlatform.email:
        return 'Email';
      case SocialPlatform.phone:
        return 'Phone';
      case SocialPlatform.whatsapp:
        return 'WhatsApp';
    }
  }

  String getFullUrl() {
    switch (platform) {
      case SocialPlatform.linkedin:
        return url.startsWith('http') ? url : 'https://linkedin.com/in/$username';
      case SocialPlatform.twitter:
        return url.startsWith('http') ? url : 'https://twitter.com/$username';
      case SocialPlatform.facebook:
        return url.startsWith('http') ? url : 'https://facebook.com/$username';
      case SocialPlatform.instagram:
        return url.startsWith('http') ? url : 'https://instagram.com/$username';
      case SocialPlatform.github:
        return url.startsWith('http') ? url : 'https://github.com/$username';
      case SocialPlatform.youtube:
        return url.startsWith('http') ? url : 'https://youtube.com/@$username';
      case SocialPlatform.email:
        return 'mailto:$url';
      case SocialPlatform.phone:
        return 'tel:$url';
      case SocialPlatform.whatsapp:
        return 'https://wa.me/$url';
      case SocialPlatform.website:
        return url.startsWith('http') ? url : 'https://$url';
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'platform': platform.index,
      'url': url,
      'username': username,
    };
  }

  factory SocialMediaLink.fromMap(Map<String, dynamic> map) {
    return SocialMediaLink(
      id: map['id'],
      platform: SocialPlatform.values[map['platform']],
      url: map['url'],
      username: map['username'],
    );
  }
}
