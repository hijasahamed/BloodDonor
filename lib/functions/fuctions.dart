// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

final CollectionReference donor= FirebaseFirestore.instance.collection('blooddonation');

Future<void> deletebuttonclicked(data,context) async{ 
    showDialog(
      context: context, 
      builder: (ctx){ 
        return AlertDialog(
          content: const Text('Do You Want To Delete This Donor?',style:TextStyle(fontWeight: FontWeight.w600),),  
          actions: [
            TextButton(
              onPressed: (){ 
                removeBloodUser(data);
                Navigator.of(context).pop();
                scaffoldMessage('Details Deleted', context);                
              }, 
              child:const Text('YES'),
            ),
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              }, 
              child:const Text('NO')
            )
          ],
        );
      }
    );
}

removeBloodUser(docid){
  donor.doc(docid).delete();
}

scaffoldMessage(text,context){
  ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      backgroundColor:  const Color.fromARGB(255, 219, 14, 14),
      margin: const EdgeInsets.all(75),
      content: Text(text,textAlign: TextAlign.center,
      ),
    ),
  );
}

Future<void> makePhoneCall(String phoneNumber) async {
  if (await Permission.phone.request().isGranted) {
    final Uri url = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print('Could not launch the dialer for $phoneNumber');
    }
  } else {
    print('Phone call permission not granted');
  }
}

Future<void> makeSms(String phoneNumber) async {
  final Uri smsUrl = Uri.parse('sms:$phoneNumber');
  
  if (await canLaunchUrl(smsUrl)) {
    await launchUrl(smsUrl, mode: LaunchMode.externalApplication);
  } else {
    print('Could not launch the SMS app for $phoneNumber');
  }
}