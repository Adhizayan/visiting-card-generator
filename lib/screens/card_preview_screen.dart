import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/visiting_card.dart';
import '../models/social_media_link.dart';
import '../services/pdf_service.dart';
import '../widgets/card_templates.dart';

class CardPreviewScreen extends StatefulWidget {
  final VisitingCard card;

  const CardPreviewScreen({super.key, required this.card});

  @override
  State<CardPreviewScreen> createState() => _CardPreviewScreenState();
}

class _CardPreviewScreenState extends State<CardPreviewScreen> {
  bool _isGeneratingPdf = false;
  int _selectedTemplateIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Preview'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _isGeneratingPdf ? null : _downloadPdf,
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _isGeneratingPdf ? null : _sharePdf,
          ),
        ],
      ),
      body: Column(
        children: [
          // Template selector
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ChoiceChip(
                    label: Text('Template ${index + 1}'),
                    selected: _selectedTemplateIndex == index,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _selectedTemplateIndex = index;
                        });
                      }
                    },
                  ),
                );
              },
            ),
          ),
          // Card preview
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: _buildCardPreview(),
              ),
            ),
          ),
          // Action buttons
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isGeneratingPdf ? null : _downloadPdf,
                    icon: _isGeneratingPdf
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.download),
                    label: Text(_isGeneratingPdf ? 'Generating...' : 'Download PDF'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _isGeneratingPdf ? null : _sharePdf,
                    icon: const Icon(Icons.share),
                    label: const Text('Share'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardPreview() {
    switch (_selectedTemplateIndex) {
      case 0:
        return ProfessionalCardTemplate(card: widget.card);
      case 1:
        return ModernCardTemplate(card: widget.card);
      case 2:
        return MinimalCardTemplate(card: widget.card);
      default:
        return ProfessionalCardTemplate(card: widget.card);
    }
  }

  Future<void> _downloadPdf() async {
    setState(() {
      _isGeneratingPdf = true;
    });

    try {
      final pdfService = PdfService();
      final file = await pdfService.generatePdf(widget.card, _selectedTemplateIndex);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('PDF saved to: ${file.path}'),
          action: SnackBarAction(
            label: 'Open',
            onPressed: () async {
              // Open the PDF file
              final Uri uri = Uri.file(file.path);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
              }
            },
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error generating PDF: $e')),
      );
    } finally {
      setState(() {
        _isGeneratingPdf = false;
      });
    }
  }

  Future<void> _sharePdf() async {
    setState(() {
      _isGeneratingPdf = true;
    });

    try {
      final pdfService = PdfService();
      await pdfService.sharePdf(widget.card, _selectedTemplateIndex);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sharing PDF: $e')),
      );
    } finally {
      setState(() {
        _isGeneratingPdf = false;
      });
    }
  }
}
