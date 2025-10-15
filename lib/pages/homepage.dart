import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/enderecospage.dart';
import 'loginpage.dart';
import 'profilepage.dart';
import 'chatpage.dart';
import 'ficha_page.dart';
import 'telefonepage.dart';
import 'enderecospage.dart';


class HomePage extends StatelessWidget { // Renomeado para HomePage
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff00b894), 
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.local_hospital, color: const Color(0xff00b894)),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('EMC',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                Text('Emergency Center',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    )),
              ],
            ),
          ],
        ),
        actions: [
        IconButton(
              tooltip: 'Perfil',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ProfilePage()),
                );
              },
              icon: const Icon(Icons.person_outline),),
          IconButton(
              tooltip: 'Configurações',
              onPressed: () {},
              icon: const Icon(Icons.settings_outlined)),
          IconButton(
              tooltip: 'Notificações',
              onPressed: () {},
              icon: const Icon(Icons.notifications_none)),
          IconButton(
              tooltip: 'Sair',
              onPressed: () {
                // Aqui você pode navegar de volta para login ou sair do app
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              icon: const Icon(Icons.logout)),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mensagem de boas vindas com ícone de mão e fundo branco arredondado
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
            Expanded(
              child: GridView.count(
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
                  ),
                  _buildCard(
                    color: const Color(0xffe6f1ff),
                    icon: Icons.medical_services,
                    title: 'Primeiros Socorros',
                    subtitle: 'Ajuda em emergências',
                    backgroundIcon: Icons.local_hospital_outlined,
                    iconBackgroundColor: const Color(0xff3f88db),
                    iconColor: Colors.white,
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
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const FichaPage()),
                    );
                  },
                ),
                ],
              )
            )
          ],
        ),
      ),
    );
  }

  // Função para montar os cards com ícone de fundo (similar a imagem)
// Altere o retorno do _buildCard para GestureDetector para detectar toques
  Widget _buildCard({
    required Color color,
    required IconData icon,
    required String title,
    required String subtitle,
    required IconData backgroundIcon,
    required Color iconBackgroundColor,
    required Color iconColor,
    VoidCallback? onTap,   // novo parâmetro opcional
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