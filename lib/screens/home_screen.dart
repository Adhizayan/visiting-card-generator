import 'package:flutter/material.dart';
import 'card_form_screen.dart';
import 'card_preview_screen.dart';
import '../models/visiting_card.dart';
import '../models/social_media_link.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<VisitingCard> _savedCards = [];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visiting Card Generator'),
        centerTitle: true,
        elevation: 2,
      ),
      body: _savedCards.isEmpty
          ? _buildEmptyState()
          : _buildCardsList(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _navigateToCardForm(),
        icon: const Icon(Icons.add),
        label: const Text('Create New Card'),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.credit_card,
            size: 100,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 20),
          Text(
            'No visiting cards created yet',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Tap the button below to create your first card',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _savedCards.length,
      itemBuilder: (context, index) {
        final card = _savedCards[index];
        return Card(
          elevation: 3,
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: card.primaryColor,
              child: Text(
                card.fullName.isNotEmpty ? card.fullName[0].toUpperCase() : 'U',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(
              card.fullName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(card.profession),
                if (card.company.isNotEmpty)
                  Text(
                    card.company,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => _navigateToCardForm(card: card, index: index),
                ),
                IconButton(
                  icon: const Icon(Icons.visibility, color: Colors.green),
                  onPressed: () => _navigateToPreview(card),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteCard(index),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _navigateToCardForm({VisitingCard? card, int? index}) async {
    final result = await Navigator.push<VisitingCard>(
      context,
      MaterialPageRoute(
        builder: (context) => CardFormScreen(existingCard: card),
      ),
    );

    if (result != null) {
      setState(() {
        if (index != null) {
          _savedCards[index] = result;
        } else {
          _savedCards.add(result);
        }
      });
    }
  }

  void _navigateToPreview(VisitingCard card) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CardPreviewScreen(card: card),
      ),
    );
  }

  void _deleteCard(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Card'),
        content: const Text('Are you sure you want to delete this card?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _savedCards.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Card deleted successfully')),
              );
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
