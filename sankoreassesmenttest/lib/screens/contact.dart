import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sankoreassesmenttest/providers/contact_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  List<Contact>? contacts;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() async {
      if (await FlutterContacts.requestPermission()) {
        context.read<PostDataProvider>().getContact();

        // setState(() {});
      }
    });
    // getContact();
  }

  // void getContact() async {
  //   if (await FlutterContacts.requestPermission()) {
  //     contacts = await FlutterContacts.getContacts(
  //         withProperties: true, withPhoto: true);
  //     print(contacts);
  //     // setState(() {});
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            "Contact",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          // backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
              child: NotificationListener<ScrollEndNotification>(
                onNotification: (t) {
                  if (t.metrics.pixels > 0 && t.metrics.atEdge) {
                    final postProvider = context.read<PostDataProvider>();
                    if (!postProvider.loading && !postProvider.loading) {
                      postProvider.getContact();
                    }
                  } else {}
                  return true;
                },
                child: Consumer<PostDataProvider>(
                  builder: (_, contact, ___) => (contact.contacts.isEmpty)
                      ? const SpinKitFadingCube(
                          color: Colors.blue,
                        )
                      : ListView.builder(
                          itemCount: contact.contacts.length,
                          itemBuilder: (BuildContext context, int index) {
                            Uint8List? image = contact.contacts[index].photo;
                            String num = (contact
                                    .contacts[index].phones.isNotEmpty)
                                ? (contact.contacts[index].phones.first.number)
                                : "--";
                            return ListTile(
                                leading: (contact.contacts[index].photo == null)
                                    ? const CircleAvatar(
                                        child: Icon(Icons.person))
                                    : CircleAvatar(
                                        backgroundImage: MemoryImage(image!)),
                                title: Text(
                                    "${contact.contacts[index].name.first} ${contact.contacts[index].name.last}"),
                                subtitle: Text(num),
                                onTap: () {
                                  if (contact
                                      .contacts[index].phones.isNotEmpty) {
                                    launch('tel: ${num}');
                                  }
                                });
                          },
                        ),
                ),
              ),
            ),
          ],
        ));
  }
}
