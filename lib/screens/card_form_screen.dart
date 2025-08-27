import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/visiting_card.dart';
import '../models/social_media_link.dart';

class CardFormScreen extends StatefulWidget {
  final VisitingCard? existingCard;

  const CardFormScreen({super.key, this.existingCard});

  @override
  State<CardFormScreen> createState() => _CardFormScreenState();
}

class _CardFormScreenState extends State<CardFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _professionController;
  late TextEditingController _companyController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _websiteController;
  late TextEditingController _bioController;
  
  List<SocialMediaLink> _socialLinks = [];
  CardTheme _selectedTheme = CardTheme.professional;
  Color _primaryColor = Colors.blue;
  Color _secondaryColor = Colors.white;

  @override
  void initState() {
    super.initState();
    final card = widget.existingCard;
    _nameController = TextEditingController(text: card?.fullName ?? '');
    _professionController = TextEditingController(text: card?.profession ?? '');
    _companyController = TextEditingController(text: card?.company ?? '');
    _emailController = TextEditingController(text: card?.email ?? '');
    _phoneController = TextEditingController(text: card?.phone ?? '');
    _addressController = TextEditingController(text: card?.address ?? '');
    _websiteController = TextEditingController(text: card?.website ?? '');
    _bioController = TextEditingController(text: card?.bio ?? '');
    
    if (card != null) {
      _socialLinks = List.from(card.socialLinks);
      _selectedTheme = card.theme;
      _primaryColor = card.primaryColor;
      _secondaryColor = card.secondaryColor;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _professionController.dispose();
    _companyController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _websiteController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingCard == null ? 'Create Card' : 'Edit Card'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveCard,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSectionTitle('Personal Information'),
            _buildTextField(
              controller: _nameController,
              label: 'Full Name',
              icon: Icons.person,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            _buildTextField(
              controller: _professionController,
              label: 'Profession',
              icon: Icons.work,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your profession';
                }
                return null;
              },
            ),
            _buildTextField(
              controller: _companyController,
              label: 'Company',
              icon: Icons.business,
            ),
            const SizedBox(height: 20),
            
            _buildSectionTitle('Contact Information'),
            _buildTextField(
              controller: _emailController,
              label: 'Email',
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            _buildTextField(
              controller: _phoneController,
              label: 'Phone',
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
            ),
            _buildTextField(
              controller: _addressController,
              label: 'Address',
              icon: Icons.location_on,
              maxLines: 2,
            ),
            _buildTextField(
              controller: _websiteController,
              label: 'Website',
              icon: Icons.language,
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: 20),
            
            _buildSectionTitle('Bio'),
            _buildTextField(
              controller: _bioController,
              label: 'Short Bio',
              icon: Icons.description,
              maxLines: 3,
              hint: 'Write a short description about yourself',
            ),
            const SizedBox(height: 20),
            
            _buildSectionTitle('Social Media Links'),
            _buildSocialLinksSection(),
            const SizedBox(height: 20),
            
            _buildSectionTitle('Card Theme'),
            _buildThemeSection(),
            const SizedBox(height: 20),
            
            _buildSectionTitle('Colors'),
            _buildColorSection(),
            const SizedBox(height: 30),
            
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: _saveCard,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
                ),
                child: Text(
                  widget.existingCard == null ? 'Create Card' : 'Update Card',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hint,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        maxLines: maxLines,
        keyboardType: keyboardType,
        validator: validator,
      ),
    );
  }

  Widget _buildSocialLinksSection() {
    return Column(
      children: [
        ..._socialLinks.map((link) => Card(
              child: ListTile(
                leading: Icon(link.icon, color: link.color),
                title: Text(link.displayName),
                subtitle: Text(link.username),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      _socialLinks.remove(link);
                    });
                  },
                ),
              ),
            )),
        const SizedBox(height: 10),
        OutlinedButton.icon(
          onPressed: _addSocialLink,
          icon: const Icon(Icons.add),
          label: const Text('Add Social Link'),
        ),
      ],
    );
  }

  void _addSocialLink() {
    showDialog(
      context: context,
      builder: (context) {
        SocialPlatform? selectedPlatform = SocialPlatform.linkedin;
        final usernameController = TextEditingController();
        final urlController = TextEditingController();

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Add Social Link'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<SocialPlatform>(
                    value: selectedPlatform,
                    decoration: const InputDecoration(
                      labelText: 'Platform',
                      border: OutlineInputBorder(),
                    ),
                    items: SocialPlatform.values.map((platform) {
                      return DropdownMenuItem(
                        value: platform,
                        child: Text(SocialMediaLink(
                          id: '',
                          platform: platform,
                          url: '',
                          username: '',
                        ).displayName),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedPlatform = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username/Handle',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: urlController,
                    decoration: const InputDecoration(
                      labelText: 'URL (optional)',
                      border: OutlineInputBorder(),
                      hintText: 'Leave empty to use default',
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (usernameController.text.isNotEmpty) {
                      this.setState(() {
                        _socialLinks.add(SocialMediaLink(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          platform: selectedPlatform!,
                          username: usernameController.text,
                          url: urlController.text.isEmpty
                              ? usernameController.text
                              : urlController.text,
                        ));
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildThemeSection() {
    return Wrap(
      spacing: 10,
      children: CardTheme.values.map((theme) {
        return ChoiceChip(
          label: Text(_getThemeName(theme)),
          selected: _selectedTheme == theme,
          onSelected: (selected) {
            if (selected) {
              setState(() {
                _selectedTheme = theme;
                _updateThemeColors(theme);
              });
            }
          },
        );
      }).toList(),
    );
  }

  String _getThemeName(CardTheme theme) {
    switch (theme) {
      case CardTheme.professional:
        return 'Professional';
      case CardTheme.creative:
        return 'Creative';
      case CardTheme.minimal:
        return 'Minimal';
      case CardTheme.dark:
        return 'Dark';
      case CardTheme.colorful:
        return 'Colorful';
    }
  }

  void _updateThemeColors(CardTheme theme) {
    switch (theme) {
      case CardTheme.professional:
        _primaryColor = Colors.blue;
        _secondaryColor = Colors.white;
        break;
      case CardTheme.creative:
        _primaryColor = Colors.purple;
        _secondaryColor = Colors.orange.shade50;
        break;
      case CardTheme.minimal:
        _primaryColor = Colors.grey.shade800;
        _secondaryColor = Colors.grey.shade50;
        break;
      case CardTheme.dark:
        _primaryColor = Colors.black;
        _secondaryColor = Colors.grey.shade900;
        break;
      case CardTheme.colorful:
        _primaryColor = Colors.teal;
        _secondaryColor = Colors.amber.shade50;
        break;
    }
  }

  Widget _buildColorSection() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Primary Color'),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _pickColor(true),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: _primaryColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Secondary Color'),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _pickColor(false),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: _secondaryColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _pickColor(bool isPrimary) {
    showDialog(
      context: context,
      builder: (context) {
        final colors = [
          Colors.red,
          Colors.pink,
          Colors.purple,
          Colors.deepPurple,
          Colors.indigo,
          Colors.blue,
          Colors.lightBlue,
          Colors.cyan,
          Colors.teal,
          Colors.green,
          Colors.lightGreen,
          Colors.lime,
          Colors.yellow,
          Colors.amber,
          Colors.orange,
          Colors.deepOrange,
          Colors.brown,
          Colors.grey,
          Colors.blueGrey,
          Colors.black,
          Colors.white,
        ];

        return AlertDialog(
          title: Text(isPrimary ? 'Pick Primary Color' : 'Pick Secondary Color'),
          content: Container(
            width: double.maxFinite,
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: colors.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isPrimary) {
                        _primaryColor = colors[index];
                      } else {
                        _secondaryColor = colors[index];
                      }
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: colors[index],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.grey,
                        width: 2,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _saveCard() {
    if (_formKey.currentState!.validate()) {
      final card = VisitingCard(
        id: widget.existingCard?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        fullName: _nameController.text,
        profession: _professionController.text,
        company: _companyController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        address: _addressController.text,
        website: _websiteController.text,
        bio: _bioController.text,
        socialLinks: _socialLinks,
        theme: _selectedTheme,
        primaryColor: _primaryColor,
        secondaryColor: _secondaryColor,
      );

      Navigator.pop(context, card);
    }
  }
}
