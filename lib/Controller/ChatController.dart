import 'dart:convert';

import 'package:intl/intl.dart';
import '../AllExports/Export.dart';
import 'package:http/http.dart' as http;

class ChatController extends GetxController {
  var messages = <MessageModel>[].obs;
  var isBotTyping = false.obs;
  TextEditingController messageController = TextEditingController();

  final GetStorage _box = GetStorage();
  final _isDarkMode = false.obs;

  bool get isDarkMode => _isDarkMode.value;

  @override
  void onInit() {
    super.onInit();
    _isDarkMode.value = _box.read('isDarkMode') ?? false;
  }

  ScrollController scrollController = ScrollController();

  void toggleTheme() {
    _isDarkMode.value = !_isDarkMode.value;
    Get.changeThemeMode(_isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    _box.write('isDarkMode', _isDarkMode.value);
  }

  void sendMessage(String content) {
    if (content.isNotEmpty) {
      messages.add(MessageModel(
          content: content, isBot: false, timestamp: DateTime.now()));
      messageController.clear();
      scrollToBottom();
      botReply(content);
    }
  }

   Future<void> botReply(String userMessage) async {
    isBotTyping.value = true;
    
    try {
      final response = await http.post(
        Uri.parse('http://192.168.0.105:5000/chat'), 
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'message': userMessage,
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body); 

        String botResponse = data['response'];

        messages.add(MessageModel(
            content: botResponse, isBot: true, timestamp: DateTime.now()));
      } else {
        messages.add(MessageModel(
            content: "Error: Unable to get bot response", 
            isBot: true, 
            timestamp: DateTime.now()));
      }
    } catch (e) {
      messages.add(MessageModel(
          content: "Error: $e", isBot: true, timestamp: DateTime.now()));
    }

    isBotTyping.value = false;
    scrollToBottom(); 
  }

  void scrollToBottom() {
    Future.delayed(Duration(milliseconds: 300), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}

class MessageModel {
  final String content;
  final bool isBot;
  final DateTime timestamp;

  MessageModel(
      {required this.content, required this.isBot, required this.timestamp});
  String get formattedTimestamp {
    return DateFormat('hh:mm a').format(timestamp); 
  }
}