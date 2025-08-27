import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:printing/printing.dart';
import '../models/visiting_card.dart';
import '../models/social_media_link.dart';

class PdfService {
  Future<File> generatePdf(VisitingCard card, int templateIndex) async {
    final pdf = pw.Document();

    // Add page with visiting card
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Center(
            child: _buildPdfCard(card, templateIndex),
          );
        },
      ),
    );

    // Get the documents directory
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/visiting_card_${card.id}.pdf';
    final file = File(filePath);

    // Save the PDF
    await file.writeAsBytes(await pdf.save());
    
    return file;
  }

  Future<void> sharePdf(VisitingCard card, int templateIndex) async {
    final file = await generatePdf(card, templateIndex);
    
    await Share.shareXFiles(
      [XFile(file.path)],
      text: 'My Visiting Card - ${card.fullName}',
      subject: 'Visiting Card',
    );
  }

  pw.Widget _buildPdfCard(VisitingCard card, int templateIndex) {
    switch (templateIndex) {
      case 0:
        return _buildProfessionalTemplate(card);
      case 1:
        return _buildModernTemplate(card);
      case 2:
        return _buildMinimalTemplate(card);
      default:
        return _buildProfessionalTemplate(card);
    }
  }

  pw.Widget _buildProfessionalTemplate(VisitingCard card) {
    return pw.Container(
      width: 350,
      height: 200,
      decoration: pw.BoxDecoration(
        color: PdfColor.fromInt(card.primaryColor.value),
        borderRadius: pw.BorderRadius.circular(12),
      ),
      child: pw.Padding(
        padding: const pw.EdgeInsets.all(20),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            // Name and profession
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  card.fullName,
                  style: pw.TextStyle(
                    color: PdfColors.white,
                    fontSize: 22,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  card.profession,
                  style: pw.TextStyle(
                    color: PdfColors.white90,
                    fontSize: 14,
                  ),
                ),
                if (card.company.isNotEmpty) ...[
                  pw.SizedBox(height: 2),
                  pw.Text(
                    card.company,
                    style: pw.TextStyle(
                      color: PdfColors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
            // Contact info
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  children: [
                    pw.Text(
                      'Email: ',
                      style: pw.TextStyle(
                        color: PdfColors.white90,
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      card.email,
                      style: pw.TextStyle(
                        color: PdfColors.white90,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 4),
                pw.Row(
                  children: [
                    pw.Text(
                      'Phone: ',
                      style: pw.TextStyle(
                        color: PdfColors.white90,
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      card.phone,
                      style: pw.TextStyle(
                        color: PdfColors.white90,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                if (card.website.isNotEmpty) ...[
                  pw.SizedBox(height: 4),
                  pw.Row(
                    children: [
                      pw.Text(
                        'Website: ',
                        style: pw.TextStyle(
                          color: PdfColors.white90,
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        card.website,
                        style: pw.TextStyle(
                          color: PdfColors.white90,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
                if (card.socialLinks.isNotEmpty) ...[
                  pw.SizedBox(height: 8),
                  pw.Text(
                    'Connect with me:',
                    style: pw.TextStyle(
                      color: PdfColors.white90,
                      fontSize: 10,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 4),
                  ...card.socialLinks.take(5).map((link) {
                    return pw.Text(
                      '${link.displayName}: ${link.username}',
                      style: pw.TextStyle(
                        color: PdfColors.white70,
                        fontSize: 9,
                      ),
                    );
                  }).toList(),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  pw.Widget _buildModernTemplate(VisitingCard card) {
    return pw.Container(
      width: 350,
      height: 200,
      decoration: pw.BoxDecoration(
        color: PdfColor.fromInt(card.secondaryColor.value),
        borderRadius: pw.BorderRadius.circular(16),
        border: pw.Border.all(
          color: PdfColor.fromInt(card.primaryColor.value).shade(0.3),
          width: 1,
        ),
      ),
      child: pw.Row(
        children: [
          // Left side - colored accent
          pw.Container(
            width: 120,
            decoration: pw.BoxDecoration(
              color: PdfColor.fromInt(card.primaryColor.value),
              borderRadius: const pw.BorderRadius.only(
                topLeft: pw.Radius.circular(16),
                bottomLeft: pw.Radius.circular(16),
              ),
            ),
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Container(
                  width: 70,
                  height: 70,
                  decoration: pw.BoxDecoration(
                    color: PdfColors.white,
                    shape: pw.BoxShape.circle,
                  ),
                  child: pw.Center(
                    child: pw.Text(
                      card.fullName.isNotEmpty ? card.fullName[0].toUpperCase() : 'U',
                      style: pw.TextStyle(
                        fontSize: 28,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColor.fromInt(card.primaryColor.value),
                      ),
                    ),
                  ),
                ),
                if (card.socialLinks.isNotEmpty) ...[
                  pw.SizedBox(height: 10),
                  ...card.socialLinks.take(3).map((link) {
                    return pw.Padding(
                      padding: const pw.EdgeInsets.symmetric(vertical: 1),
                      child: pw.Text(
                        link.displayName,
                        style: pw.TextStyle(
                          color: PdfColors.white90,
                          fontSize: 8,
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ],
            ),
          ),
          // Right side - info
          pw.Expanded(
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(16),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    card.fullName,
                    style: pw.TextStyle(
                      color: PdfColor.fromInt(card.primaryColor.value),
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Text(
                    card.profession,
                    style: pw.TextStyle(
                      color: PdfColors.grey700,
                      fontSize: 13,
                      fontWeight: pw.FontWeight.normal,
                    ),
                  ),
                  if (card.company.isNotEmpty) ...[
                    pw.SizedBox(height: 2),
                    pw.Text(
                      card.company,
                      style: pw.TextStyle(
                        color: PdfColors.grey600,
                        fontSize: 11,
                      ),
                    ),
                  ],
                  pw.SizedBox(height: 12),
                  pw.Divider(color: PdfColor.fromInt(card.primaryColor.value).shade(0.2)),
                  pw.SizedBox(height: 8),
                  pw.Text(
                    card.email,
                    style: pw.TextStyle(
                      color: PdfColors.grey700,
                      fontSize: 10,
                    ),
                  ),
                  pw.SizedBox(height: 2),
                  pw.Text(
                    card.phone,
                    style: pw.TextStyle(
                      color: PdfColors.grey700,
                      fontSize: 10,
                    ),
                  ),
                  if (card.website.isNotEmpty) ...[
                    pw.SizedBox(height: 2),
                    pw.Text(
                      card.website,
                      style: pw.TextStyle(
                        color: PdfColors.grey700,
                        fontSize: 10,
                      ),
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

  pw.Widget _buildMinimalTemplate(VisitingCard card) {
    return pw.Container(
      width: 350,
      height: 200,
      decoration: pw.BoxDecoration(
        color: PdfColors.white,
        borderRadius: pw.BorderRadius.circular(8),
        border: pw.Border.all(
          color: PdfColors.grey300,
          width: 1,
        ),
      ),
      child: pw.Column(
        children: [
          // Top accent line
          pw.Container(
            height: 4,
            decoration: pw.BoxDecoration(
              color: PdfColor.fromInt(card.primaryColor.value),
              borderRadius: const pw.BorderRadius.only(
                topLeft: pw.Radius.circular(8),
                topRight: pw.Radius.circular(8),
              ),
            ),
          ),
          pw.Expanded(
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(20),
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    card.fullName,
                    style: pw.TextStyle(
                      color: PdfColors.grey900,
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Text(
                    card.profession,
                    style: pw.TextStyle(
                      color: PdfColor.fromInt(card.primaryColor.value),
                      fontSize: 14,
                      fontWeight: pw.FontWeight.normal,
                    ),
                  ),
                  if (card.company.isNotEmpty) ...[
                    pw.SizedBox(height: 2),
                    pw.Text(
                      card.company,
                      style: pw.TextStyle(
                        color: PdfColors.grey600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                  pw.SizedBox(height: 16),
                  pw.Container(
                    width: 40,
                    height: 1,
                    color: PdfColors.grey300,
                  ),
                  pw.SizedBox(height: 16),
                  pw.Text(
                    card.email,
                    style: pw.TextStyle(
                      color: PdfColors.grey700,
                      fontSize: 11,
                    ),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Text(
                    card.phone,
                    style: pw.TextStyle(
                      color: PdfColors.grey700,
                      fontSize: 11,
                    ),
                  ),
                  if (card.socialLinks.isNotEmpty) ...[
                    pw.SizedBox(height: 12),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: card.socialLinks.take(6).map((link) {
                        return pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(horizontal: 4),
                          child: pw.Text(
                            link.displayName,
                            style: pw.TextStyle(
                              color: PdfColors.grey600,
                              fontSize: 9,
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
}
