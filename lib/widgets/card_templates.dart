import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/visiting_card.dart';
import '../models/social_media_link.dart';

class ProfessionalCardTemplate extends StatelessWidget {
  final VisitingCard card;

  const ProfessionalCardTemplate({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [card.primaryColor, card.primaryColor.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background pattern
          Positioned(
            right: -30,
            bottom: -30,
            child: Icon(
              Icons.person,
              size: 150,
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Name and profession
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      card.fullName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      card.profession,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                      ),
                    ),
                    if (card.company.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        card.company,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
                // Contact info
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.email, size: 14, color: Colors.white.withOpacity(0.9)),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            card.email,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.phone, size: 14, color: Colors.white.withOpacity(0.9)),
                        const SizedBox(width: 6),
                        Text(
                          card.phone,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    if (card.socialLinks.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: card.socialLinks.take(5).map((link) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                              onTap: () => _launchUrl(link.getFullUrl()),
                              child: Icon(
                                link.icon,
                                size: 16,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

class ModernCardTemplate extends StatelessWidget {
  final VisitingCard card;

  const ModernCardTemplate({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 200,
      decoration: BoxDecoration(
        color: card.secondaryColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: card.primaryColor.withOpacity(0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: card.primaryColor.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Left side - colored accent
          Container(
            width: 120,
            decoration: BoxDecoration(
              color: card.primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.white,
                  child: Text(
                    card.fullName.isNotEmpty ? card.fullName[0].toUpperCase() : 'U',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: card.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                if (card.socialLinks.isNotEmpty)
                  Column(
                    children: card.socialLinks.take(3).map((link) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: GestureDetector(
                          onTap: () => _launchUrl(link.getFullUrl()),
                          child: Icon(
                            link.icon,
                            size: 18,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
          // Right side - info
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    card.fullName,
                    style: TextStyle(
                      color: card.primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    card.profession,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (card.company.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      card.company,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 11,
                      ),
                    ),
                  ],
                  const SizedBox(height: 12),
                  Divider(color: card.primaryColor.withOpacity(0.2)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.email, size: 12, color: Colors.grey[600]),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          card.email,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 11,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.phone, size: 12, color: Colors.grey[600]),
                      const SizedBox(width: 6),
                      Text(
                        card.phone,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  if (card.website.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.language, size: 12, color: Colors.grey[600]),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            card.website,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 11,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

class MinimalCardTemplate extends StatelessWidget {
  final VisitingCard card;

  const MinimalCardTemplate({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top accent line
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: card.primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    card.fullName,
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    card.profession,
                    style: TextStyle(
                      color: card.primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  if (card.company.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      card.company,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  Container(
                    width: 40,
                    height: 1,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    card.email,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    card.phone,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 12,
                    ),
                  ),
                  if (card.socialLinks.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: card.socialLinks.take(6).map((link) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: GestureDetector(
                            onTap: () => _launchUrl(link.getFullUrl()),
                            child: Icon(
                              link.icon,
                              size: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
