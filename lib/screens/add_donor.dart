
import 'package:flutter/material.dart';

class Addblooduser extends StatefulWidget {
  const Addblooduser({super.key});

  @override
  State<Addblooduser> createState() => _AddblooduserState();
}

class _AddblooduserState extends State<Addblooduser> {

  final bloodGroups=['A+','A-','B+','B-','O+','O-','AB+','AB-'];
  String ? selectedGroup;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Donors',style: TextStyle(fontWeight: FontWeight.w700),),
        centerTitle: true,
        backgroundColor: Colors.red,  
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Donor Name') 
                  ),
                  textCapitalization: TextCapitalization.words,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Age') 
                  ),
                  textCapitalization: TextCapitalization.words,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Mobile') 
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('District') 
                  ),
                  textCapitalization: TextCapitalization.words,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Village') 
                  ),
                  textCapitalization: TextCapitalization.words,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: DropdownButtonFormField(
                  hint:const Text('Add Blood Group'),
                  decoration:const InputDecoration(icon: Icon(Icons.bloodtype,color: Colors.red,)),
                  items: bloodGroups.map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  )).toList(), 
                  onChanged: (val){
                    selectedGroup=val;
                  }
                ),
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                onPressed: (){},
                style:const ButtonStyle(
                  minimumSize: MaterialStatePropertyAll(Size(200, 50)),
                  backgroundColor: MaterialStatePropertyAll(Colors.red)
                ),
                 
                child:const Text('Submit',style: TextStyle(fontSize: 20,color: Colors.white),)
              ) 
            ],
          ),
        ),
      ),
    );
  }
}