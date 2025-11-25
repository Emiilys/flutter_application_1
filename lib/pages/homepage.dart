import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/enderecosImportantes/enderecospage.dart';
import 'loginpage.dart';
import 'profilepage.dart';
import 'chat/chatpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'telefoneEmergencia/telefonepage.dart';
import 'primeirosocorros/primeiros_socorros_page.dart';
import 'bemEstar/bem_estar_page.dart';
import 'fichaSaude/ficha_page.dart';
import 'package:flutter_application_1/pages/configuracao_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          _buildHeader(context, largura),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _welcomeBox(),

                  const SizedBox(height: 16),

                  
                  LayoutBuilder(
                    builder: (context, constraints) {
                      int crossCount = constraints.maxWidth < 380
                          ? 1
                          : constraints.maxWidth < 600
                              ? 2
                              : 3;

                      return GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: crossCount,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 1.1,
                        children: [
                          _buildCard(
                            color: const Color(0xffffe6e6),
                            icon: Icons.phone,
                            title: 'Telefones',
                            subtitle: 'Contatos de emergência',
                            backgroundIcon: Icons.phone_in_talk,
                            iconBackgroundColor: const Color(0xffd45a58),
                            onTap: () => Navigator.push(context,
                                MaterialPageRoute(builder: (_) => const TelefonePage())),
                          ),
                          _buildCard(
                            color: const Color(0xffe6f7e6),
                            icon: Icons.favorite,
                            title: 'Bem Estar',
                            subtitle: 'Cuidados pessoais',
                            backgroundIcon: Icons.favorite_outline,
                            iconBackgroundColor: const Color(0xff65c268),
                            onTap: () => Navigator.push(context,
                                MaterialPageRoute(builder: (_) => const BemEstarPage())),
                          ),
                          _buildCard(
                            color: const Color(0xffe6f1ff),
                            icon: Icons.medical_services,
                            title: 'Primeiros Socorros',
                            subtitle: 'Ajuda em emergências',
                            backgroundIcon: Icons.local_hospital_outlined,
                            iconBackgroundColor: const Color(0xff3f88db),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const PrimeirosSocorrosPage())),
                          ),
                          _buildCard(
                            color: const Color(0xfff9f0e6),
                            icon: Icons.location_on,
                            title: 'Endereços',
                            subtitle: 'Locais importantes',
                            backgroundIcon: Icons.location_pin,
                            iconBackgroundColor: const Color(0xfff5c555),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const EnderecosPage())),
                          ),
                          _buildCard(
                            color: const Color(0xfff0e8ff),
                            icon: Icons.chat,
                            title: 'Chat',
                            subtitle: 'Converse com Especialistas',
                            backgroundIcon: Icons.chat_bubble_outline,
                            iconBackgroundColor: const Color(0xff9c79d8),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const ChatPage())),
                          ),
                          _buildCard(
                            color: const Color(0xffffe6f0),
                            icon: Icons.description,
                            title: 'Ficha',
                            subtitle: 'Informações médicas',
                            backgroundIcon: Icons.note_alt_outlined,
                            iconBackgroundColor: const Color(0xfff979c1),
                            onTap: () {
                              final user = FirebaseAuth.instance.currentUser;
                              if (user != null) {
                                Navigator.push(
                                  context,
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
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

 
  Widget _buildHeader(BuildContext context, double largura) {
    bool telaPequena = largura < 380;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 45, left: 16, right: 16, bottom: 16),
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
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/logo.jpeg',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('EMC',
                      style: TextStyle(fontSize: 27,
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  Text('Emergency Center',
                      style: TextStyle(fontSize: 14, color: Colors.white70)),
                ],
              ),
              const Spacer(),

             
              if (telaPequena)
                PopupMenuButton(
                  offset: const Offset(0, 50),
                  icon: const Icon(Icons.more_vert, color: Colors.white),
                  itemBuilder: (_) => [
                    _buildMenuItem("Perfil", Icons.person_outline, () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const ProfilePage()));
                    }),
                    _buildMenuItem("Configurações", Icons.settings_outlined, () {
                     Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ConfiguracaoPage()),
                        );
                      }),
                    _buildMenuItem("Notificações", Icons.notifications_none, () {}),
                    _buildMenuItem("Sair", Icons.logout, () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => const LoginPage()));
                    }),
                  ],
                ),

            
              if (!telaPequena)
                Row(
                  children: [
                    _headerBtn(Icons.person_outline, () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const ProfilePage()));
                    }),
                    _headerBtn(Icons.settings_outlined, () {
                   Navigator.push(
                   context,
                   MaterialPageRoute(builder: (_) => const ConfiguracaoPage()),
                     );
                          }),
                    _headerBtn(Icons.notifications_none, () {}),
                    _headerBtn(Icons.logout, () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => const LoginPage()));
                    }),
                  ],
                )
            ],
          ),
        ],
      ),
    );
  }

  PopupMenuItem _buildMenuItem(String texto, IconData icon, Function() onTap) {
    return PopupMenuItem(
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 10),
          Text(texto),
        ],
      ),
      onTap: onTap,
    );
  }

  Widget _headerBtn(IconData icon, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(left: 6),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onTap,
      ),
    );
  }

  
  Widget _welcomeBox() {
    return Container(
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
            TextSpan(text: 'Olá! ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            WidgetSpan(child: Text('👋', style: TextStyle(fontSize: 18))),
            TextSpan(
              text: '\nO que você precisa hoje?',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

 
  Widget _buildCard({
    required Color color,
    required IconData icon,
    required String title,
    required String subtitle,
    required IconData backgroundIcon,
    required Color iconBackgroundColor,
    required VoidCallback onTap,
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
              child: Icon(backgroundIcon,
                  size: 60, color: iconBackgroundColor.withOpacity(0.2)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, size: 36, color: iconBackgroundColor),
                const SizedBox(height: 20),
                Text(title,
                    style:
                        const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text(subtitle,
                    style: const TextStyle(fontSize: 14, color: Colors.black54)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
