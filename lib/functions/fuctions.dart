import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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