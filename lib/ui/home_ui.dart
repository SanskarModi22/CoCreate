import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../models/document_model.dart';
import '../models/error_model.dart';
import '../repository/auth_repository.dart';
import '../repository/document_repository.dart';
import '../style/colors.dart';
import 'loading_ui.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  void signOut(WidgetRef ref) {
    ref.read(authRepositoryProvider).signOut();
    ref.read(userProvider.notifier).update((state) => null);
  }

  void createDocument(BuildContext context, WidgetRef ref) async {
    String token = ref.read(userProvider)!.token;
    print(token);
    final navigator = Routemaster.of(context);
    final snackbar = ScaffoldMessenger.of(context);
    final errorModel =
        await ref.read(documentRepositoryProvider).createDocument(token);
    if (errorModel.data != null) {
      navigator.push('/document/${errorModel.data.id}');
    } else {
      snackbar.showSnackBar(SnackBar(content: Text(errorModel.error!)));
    }
  }

  void navigateTODocument(BuildContext context, String documentId) {
    Routemaster.of(context).push('/document/$documentId');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => createDocument(context, ref),
            icon: const Icon(
              Icons.add,
              color: kBlackColor,
            ),
          ),
          IconButton(
            onPressed: () => signOut(ref),
            icon: const Icon(
              Icons.logout,
              color: kRedColor,
            ),
          )
        ],
      ),
      body: FutureBuilder<ErrorModel?>(
          future: ref
              .watch(documentRepositoryProvider)
              .getDocument(ref.watch(userProvider)!.token),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loader();
            }
            return Center(
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                width: 600,
                // height: 50,
                child: ListView.builder(
                    itemCount: snapshot.data!.data.length,
                    itemBuilder: ((context, index) {
                      DocumentModel document = snapshot.data!.data[index];
                      return SizedBox(
                        height: 50,
                        child: InkWell(
                          onTap: () => navigateTODocument(context, document.id),
                          child: Card(
                              child: Center(
                            child: Column(
                              children: [
                                Text(document.title),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text('${document.createdAt}')
                              ],
                            ),
                          )),
                        ),
                      );
                    })),
              ),
            );
          })),
    );
  }
}
