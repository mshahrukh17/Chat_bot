import 'package:campus_campanion/Controller/ChatController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDrawerWidget extends StatelessWidget {
  const MyDrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ChatController chatController = Get.put(ChatController());
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        children: [
          Image.asset(
            'assets/gcuh.png',
            height: size.height * 0.2,
            width: size.width * 0.8,
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  tileColor: Color(0xfffb61e1a),
                  leading: Icon(Icons.question_mark_sharp, color: Colors.white),
                  title: Text(
                    "Q U E S T I O N S",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  tileColor: Color(0xfffb61e1a),
                  leading: Icon(Icons.help_center, color: Colors.white),
                  title: Text(
                    "H E L P",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  tileColor: Color(0xfffb61e1a),
                  leading:
                      Icon(Icons.contact_support_sharp, color: Colors.white),
                  title: Text(
                    "C O N T A C T",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  textColor: Colors.white,
                  iconColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  tileColor: Color(0xfffb61e1a),
                  leading: Icon(
                    Icons.question_mark_sharp,
                  ),
                  title: Text(
                    "A B O U T",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                SwitchListTile(
                  trackOutlineColor: MaterialStatePropertyAll(
                    Color(0xfffb61e1a).withOpacity(0.5),
                  ),
                  activeColor: Color(0xfffb61e1a),
                  inactiveThumbColor: Color(0xfffb61e1a),
                  inactiveTrackColor: Color(0xfffb61e1a).withOpacity(0.5),
                  title: Text("Dark Mode"),
                  value: chatController.isDarkMode,
                  onChanged: (value) {
                    chatController.toggleTheme();
                  },
                  secondary: Icon(
                      chatController.isDarkMode
                          ? Icons.dark_mode
                          : Icons.light_mode,
                      color: chatController.isDarkMode
                          ? Color(0xfff0d5f98)
                          : Color(0xffffa9a06)),
                ),
              ],
            ),
          ),
          Spacer(),
          Text(
            "Developed By\n CS Students Batch 2021",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
