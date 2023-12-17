import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

  final CollectionReference donor= FirebaseFirestore.instance.collection('blooddonation');

Future<void> deletebuttonclicked(data,context) async{ 
    showDialog(
      context: context, 
      builder: (ctx){ 
        return AlertDialog(
          content: Text('Do You Want To Delete This Donor?',style:const TextStyle(fontWeight: FontWeight.w600),),  
          actions: [
            TextButton(
              onPressed: (){ 
                removeBloodUser(data);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor:  Color.fromARGB(255, 219, 14, 14),
                    margin: EdgeInsets.all(75),
                    content: Text(
                      'Details Deleted',
                      textAlign: TextAlign.center,
 
                    ),
                  ),
                );                
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