import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class PostDataProvider with ChangeNotifier {

  List<Contact> contacts =[];
  // PostModel post = PostModel();
  
  bool loading = false;

  void getContact() async {
    loading = true;
    if (await FlutterContacts.requestPermission()) {
      contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);
      print(contacts);
      // setState(() {});
      loading=false;
    }
       notifyListeners();
  }

}
