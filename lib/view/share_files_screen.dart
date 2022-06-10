import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:share/share.dart';
import 'package:share_files_demo/widgets/share_button_widget.dart';

import 'package:share_files_demo/widgets/textfield_widget.dart';

class ShareFilesScreen extends StatefulWidget {
  @override
  _ShareFilesScreenState createState() => _ShareFilesScreenState();
}

class _ShareFilesScreenState extends State<ShareFilesScreen> {
  final _controller = TextEditingController();

  Future<List<String>?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    return result!.paths as List<String>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Share Texts and Files"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextfieldWidget(controller: _controller),
            ),
            SizedBox(
              height: 35,
            ),
            ShareButtonWidget(onClicked: () {
              if (_controller.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.teal,
                    content: Text("Please enter caption.. "),
                  ),
                );
              } else {
                Share.share(_controller.text);
              }
            }),
            SizedBox(
              height: 55,
            ),
            FlatButton(
              onPressed: () async {
                final filePaths = await pickFile();
                Share.shareFiles(filePaths!);
              },
              child: Row(
                children: [
                  Text(
                    "Share Files",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.attach_file_sharp,
                    color: Colors.white,
                  ),
                ],
              ),
              color: Colors.teal,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
            ),
          ],
        ),
      ),
    );
  }
}
