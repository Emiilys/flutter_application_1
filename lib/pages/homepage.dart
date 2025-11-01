import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/enderecosImportantes/enderecospage.dart';
import 'loginpage.dart';
import 'profilepage.dart';
import 'chat/chatpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'telefoneEmergencia/telefonepage.dart';
import 'primeirosocorrospage.dart';
import 'bemEstar/bem_estar_page.dart';
import 'fichaSaude/ficha_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 🔹 Cabeçalho grande com gradiente
          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xff00b894), Color(0xff55efc4)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Logo
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/logo.jpeg',
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 20),
                // 🔹 Título e subtítulo
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'EMC',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Emergency Center',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // 🔹 Botões à direita com ação
                Row(
                  children: [
                    _headerIconButton(context, Icons.person_outline, 'Perfil', () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const ProfilePage()),
                      );
                    }),
                    const SizedBox(width: 8),
                    _headerIconButton(context, Icons.settings_outlined, 'Configurações', () {}),
                    const SizedBox(width: 8),
                    _headerIconButton(context, Icons.notifications_none, 'Notificações', () {}),
                    const SizedBox(width: 8),
                    _headerIconButton(context, Icons.logout, 'Sair', () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const LoginPage()),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),

          // 🔹 Conteúdo principal com scroll
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Mensagem de boas-vindas
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(color: Colors.black87),
                        children: [
                          TextSpan(
                            text: 'Olá! ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          WidgetSpan(
                            child: Text('👋', style: TextStyle(fontSize: 18)),
                          ),
                          TextSpan(
                            text: '\nO que você precisa hoje?',
                            style: TextStyle(fontSize: 14, color: Colors.black54),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Grid de cards
                  GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: [
                      _buildCard(
                        color: const Color(0xffffe6e6),
                        icon: Icons.phone,
                        title: 'Telefones',
                        subtitle: 'Contatos de emergência',
                        backgroundIcon: Icons.phone_in_talk,
                        iconBackgroundColor: const Color(0xffd45a58),
                        iconColor: Colors.white,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const TelefonePage()),
                          );
                        },
                      ),
                      _buildCard(
                        color: const Color(0xffe6f7e6),
                        icon: Icons.favorite,
                        title: 'Bem Estar',
                        subtitle: 'Cuidados pessoais',
                        backgroundIcon: Icons.favorite_outline,
                        iconBackgroundColor: const Color(0xff65c268),
                        iconColor: Colors.white,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const BemEstarPage()),
                          );
                        },
                      ),
                      _buildCard(
                        color: const Color(0xffe6f1ff),
                        icon: Icons.medical_services,
                        title: 'Primeiros Socorros',
                        subtitle: 'Ajuda em emergências',
                        backgroundIcon: Icons.local_hospital_outlined,
                        iconBackgroundColor: const Color(0xff3f88db),
                        iconColor: Colors.white,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const PrimeirosSocorrosPage()),
                          );
                        },
                      ),
                      _buildCard(
                        color: const Color(0xfff9f0e6),
                        icon: Icons.location_on,
                        title: 'Endereços',
                        subtitle: 'Locais importantes',
                        backgroundIcon: Icons.location_pin,
                        iconBackgroundColor: const Color(0xfff5c555),
                        iconColor: Colors.white,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const EnderecosPage()),
                          );
                        },
                      ),
                      _buildCard(
                        color: const Color(0xfff0e8ff),
                        icon: Icons.chat,
                        title: 'Chat',
                        subtitle: 'Converse com Especialistas',
                        backgroundIcon: Icons.chat_bubble_outline,
                        iconBackgroundColor: const Color(0xff9c79d8),
                        iconColor: Colors.white,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const ChatPage()),
                          );
                        },
                      ),
                      _buildCard(
                        color: const Color(0xffffe6f0),
                        icon: Icons.description,
                        title: 'Ficha',
                        subtitle: 'Informações médicas',
                        backgroundIcon: Icons.note_alt_outlined,
                        iconBackgroundColor: const Color(0xfff979c1),
                        iconColor: Colors.white,
                        onTap: () {
                        final user = FirebaseAuth.instance.currentUser;

                        if (user != null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => FichaPage(
                                usuarioLogado: {
                                  "uid": user.uid,
                                  "email": user.email ?? "",
                                },
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Função para criar botões do cabeçalho com ação
  Widget _headerIconButton(BuildContext context, IconData icon, String tooltip, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        tooltip: tooltip,
        onPressed: onTap,
        icon: Icon(icon, color: Colors.white),
      ),
    );
  }

  // 🔹 Função para montar os cards
  Widget _buildCard({
    required Color color,
    required IconData icon,
    required String title,
    required String subtitle,
    required IconData backgroundIcon,
    required Color iconBackgroundColor,
    required Color iconColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              right: 10,
              child: Icon(
                backgroundIcon,
                size: 60,
                color: iconBackgroundColor.withOpacity(0.2),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, size: 36, color: iconBackgroundColor),
                const SizedBox(height: 20),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
