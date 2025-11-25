import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationsService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  // 🔧 Inicializar notificações
  static Future<void> initialize() async {
    await Permission.notification.request();

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    await _plugin.initialize(settings);
  }

  // 🔔 Método GENÉRICO — usado pelo botão
  static Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'canal_padrao',
      'Notificações gerais',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await _plugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      notificationDetails,
    );
  }

  // 🔔 Teste rápido do switch
  static Future<void> enviarNotificacaoTeste() async {
    await showNotification(
      title: 'Notificação ativada!',
      body: 'Isso é um teste — sua notificação está funcionando.',
    );
  }
}
