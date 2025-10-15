import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String? _profileImageUrl;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        final data = userDoc.data()!;
        _nameController.text = data['name'] ?? '';
        _phoneController.text = data['phone'] ?? '';
        _profileImageUrl = data['photoUrl'];
      }
    } catch (e) {
      debugPrint('Erro ao carregar dados: $e');
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _saveUserData() async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'email': user.email,
        'name': _nameController.text.trim(),
        'phone': _phoneController.text.trim(),
        'photoUrl': _profileImageUrl,
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Perfil salvo com sucesso!')),
      );
    } catch (e) {
      debugPrint('Erro ao salvar dados: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao salvar perfil')),
      );
    }
  }

  Future<void> _pickAndUploadImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked == null) return;

    final file = File(picked.path);

    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child('${user.uid}.jpg');

      await ref.putFile(file);
      final url = await ref.getDownloadURL();

      setState(() {
        _profileImageUrl = url;
      });

      await _saveUserData();
    } catch (e) {
      debugPrint('Erro ao enviar imagem: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do Usuário'),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // FOTO DE PERFIL
            GestureDetector(
              onTap: _pickAndUploadImage,
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.orange.shade100,
                backgroundImage:
                    _profileImageUrl != null ? NetworkImage(_profileImageUrl!) : null,
                child: _profileImageUrl == null
                    ? const Icon(Icons.camera_alt, size: 50, color: Colors.orange)
                    : null,
              ),
            ),
            const SizedBox(height: 20),

            // EMAIL
            TextField(
              enabled: false,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: user.email,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // NOME
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // TELEFONE
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Telefone',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 30),

            // BOTÃO SALVAR
            ElevatedButton.icon(
              onPressed: _saveUserData,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.save, color: Colors.white),
              label: const Text(
                'Salvar',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
