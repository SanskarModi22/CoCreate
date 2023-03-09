import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import '../models/document_model.dart';
import '../models/error_model.dart';
import '../repository/auth_repository.dart';
import '../repository/document_repository.dart';
import '../repository/socket_repository.dart';
import '../style/colors.dart';

class DocumentScreen extends ConsumerStatefulWidget {
  final String id;
  const DocumentScreen({super.key, required this.id});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends ConsumerState<DocumentScreen> {
  TextEditingController controller =
      TextEditingController(text: "Untitled Document");
  final quill.QuillController _controller = quill.QuillController.basic();
  ErrorModel? errorModel;
  SocketRepo socketRepo = SocketRepo();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    socketRepo.joinRoom(widget.id);
    fetchDocumentData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  void fetchDocumentData() async {
    errorModel = await ref.read(documentRepositoryProvider).getDocumentById(
          ref.read(userProvider)!.token,
          widget.id,
        );
    print("hmm");
    if (errorModel!.data != null) {
      controller.text = (errorModel!.data as DocumentModel).title;
      print(controller.text);
      // print(errorModel!.data.content);
    }
  }

  void updateTitle(String title) async {
    print("Updating");
    ref.read(documentRepositoryProvider).updateTitle(
        token: ref.read(userProvider)!.token, id: widget.id, title: title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: kBlueColor),
                onPressed: () {},
                icon: const Icon(
                  Icons.lock,
                  size: 16,
                  color: kWhiteColor,
                ),
                label: const Text(
                  'Share',
                  style: TextStyle(color: kWhiteColor),
                )),
          )
        ],
        // ignore: prefer_const_literals_to_create_immutables
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 9.0),
          child: Row(children: [
            const Image(
              image: AssetImage('assets/images/docs-logo.png'),
              height: 40,
              width: 40,
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 200,
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kBlueColor,
                      ),
                    ),
                    contentPadding: EdgeInsets.only(
                      left: 10,
                    )),
                onSubmitted: (value) => updateTitle(value),
              ),
            )
          ]),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
              decoration: BoxDecoration(
            border: Border.all(
              color: kGreyColor,
              width: 0.1,
            ),
          )),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            quill.QuillToolbar.basic(controller: _controller),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: SizedBox(
                width: 750,
                child: Card(
                  color: kWhiteColor,
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: quill.QuillEditor.basic(
                      controller: _controller,
                      readOnly: false, // true for view only mode
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
