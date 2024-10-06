import '../AllExport/Export.dart';

class ChatScreen extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        drawer: Drawer(
          child: Drawer(),
        ),
        appBar: AppBar(
          title: Text(
            "Campus Campanion",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(
                  chatController.isDarkMode
                      ? Icons.light_mode
                      : Icons.dark_mode,
                  color: chatController.isDarkMode
                      ? Color(0xffffa9a06)
                      : Color(0xfff0d5f98)),
              onPressed: chatController.toggleTheme,
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(
                () => chatController.messages.isEmpty
                    ? Text(
                        "Disclamer: \nCampus Campinion can answer's only \nabout University related question's",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: null,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.ltr,
                      )
                    : ListView.builder(
                        controller: chatController.scrollController,
                        itemCount: chatController.messages.length,
                        itemBuilder: (context, index) {
                          final message = chatController.messages[index];
                          return Align(
                            alignment: message.isBot
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: Container(
                              padding: EdgeInsets.all(12.0),
                              margin: EdgeInsets.symmetric(
                                  vertical: 6.0, horizontal: 12.0),
                              decoration: BoxDecoration(
                                color: message.isBot
                                    ? Colors.grey[400]
                                    : Color(0xfffd22a50),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(message.content,
                                      style: TextStyle(
                                          color: chatController.isDarkMode
                                              ? Colors.black
                                              : Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                    message.formattedTimestamp,
                                    maxLines: null,
                                    style: TextStyle(
                                        color: chatController.isDarkMode
                                              ? Colors.black
                                              : Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
            Obx(
              () => chatController.isBotTyping.value
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("Bot is typing...",
                          style: TextStyle(
                              color: chatController.isDarkMode
                                  ? Colors.white
                                  : Colors.black)),
                    )
                  : SizedBox.shrink(),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      minLines: null,
                      cursorColor: chatController.isDarkMode
                          ? Colors.white
                          : Color(0xfffd22a50),
                      textDirection: TextDirection.ltr,
                      controller: chatController.messageController,
                      decoration: InputDecoration(
                          hintText: "Type a message...",
                          filled: true,
                          fillColor: chatController.isDarkMode
                              ? Colors.grey[800]
                              : Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: chatController.isDarkMode
                                      ? Colors.white
                                      : Color(0xfffd22a50),
                                  width: 3))),
                      style: TextStyle(
                          color: chatController.isDarkMode
                              ? Colors.white
                              : Colors.black),
                    ),
                  ),
                  RotationTransition(
                    turns: AlwaysStoppedAnimation(-30 / 360),
                    child: IconButton(
                      icon: Icon(Icons.send),
                      color: chatController.isDarkMode
                          ? Colors.white
                          : Color(0xfffd22a50),
                      onPressed: () {
                        chatController
                            .sendMessage(chatController.messageController.text);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}