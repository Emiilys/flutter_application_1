import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditing = false;

  final TextEditingController nameController =
      TextEditingController(text: 'Maria Silva');
  final TextEditingController emailController =
      TextEditingController(text: 'maria.silva@email.com');
   final TextEditingController phoneController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Perfil'),
        backgroundColor: const Color(0xff00b894), 
        centerTitle: true,
      ),
      backgroundColor: const Color(0xffe6f2ef), 
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Avatar com ícone e botão de câmera
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 62, 117, 88),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 15,
                      spreadRadius: 3,
                    )
                  ],
                ),
                padding: const EdgeInsets.symmetric(vertical: 30),
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.green[100],
                      child: Icon(
                        Icons.person_outline,
                        size: 70,
                        color: Colors.green[600],
                      ),
                    ),
                    FloatingActionButton(
                      mini: true,
                      backgroundColor: const Color(0xff00b894),
                      onPressed: () {
                        // Lógica para alterar foto pode ficar aqui
                      },
                      child: const Icon(Icons.camera_alt, size: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Nome e email abaixo do avatar
              Text(
                'Maria Silva',
                style: TextStyle(
                    color: Colors.green[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
              const SizedBox(height: 4),
              Text(
                'maria.silva@email.com',
                style: TextStyle(color: Colors.green[600], fontSize: 16),
              ),
              const SizedBox(height: 30),

              // Caixa branca para "Informações de Contato"
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 15,
                      spreadRadius: 3,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.person_outline, color: Color(0xff00b894)),
                            SizedBox(width: 8),
                            Text(
                              'Informações de Contato',
                              style: TextStyle(
                                color: Color(0xff00b894),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        OutlinedButton.icon(
                          onPressed: () {
                            setState(() {
                              isEditing = !isEditing;
                            });
                          },
                          icon: const Icon(Icons.edit, size: 18),
                          label: Text(
                            isEditing ? 'Salvar' : 'Editar',
                            style: const TextStyle(fontSize: 14),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xff00b894),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            side: const BorderSide(color: Color(0xff00b894)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Campo Nome
                    Text(
                      'Nome',
                      style: TextStyle(
                        color: Colors.green[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextField(
                      controller: nameController,
                      enabled: isEditing,
                      decoration: InputDecoration(
                        hintText: 'Maria Silva',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green.shade100,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green.shade400,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Campo Email
                    Text(
                      'Email',
                      style: TextStyle(
                        color: Colors.green[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextField(
                      controller: emailController,
                      enabled: isEditing,
                      decoration: InputDecoration(
                        hintText: 'maria.silva@email.com',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green.shade100,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green.shade400,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                      ),
                    ),
                     const SizedBox(height: 16),

                    // Novo campo Telefone
                    Text(
                      'Telefone',
                      style: TextStyle(
                        color: Colors.green[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextField(
                      controller: phoneController,
                      enabled: isEditing,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: '(00) 00000-0000',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green.shade100,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green.shade400,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}