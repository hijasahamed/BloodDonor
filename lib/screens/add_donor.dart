import 'package:blood_donor/functions/fuctions.dart';
import 'package:flutter/material.dart';

class Addblooduser extends StatefulWidget {
  const Addblooduser({super.key});

  @override
  State<Addblooduser> createState() => _AddblooduserState();
}

final bloodGroups=['A+','A-','B+','B-','O+','O-','AB+','AB-'];

class _AddblooduserState extends State<Addblooduser> {
 
  String ? selectedGroup;

  void addDoner(){
    final data={
      'name':donerName.text,
      'age':donerAge.text,
      'mobile':donerMobile.text,
      'district':donerDistrict.text,
      'village':donerVillage.text,
      'blood':selectedGroup,
     };
     donor.add(data);
     Navigator.pop(context);
  }

  TextEditingController donerName=TextEditingController();
  TextEditingController donerAge=TextEditingController();
  TextEditingController donerMobile=TextEditingController();
  TextEditingController donerDistrict=TextEditingController();
  TextEditingController donerVillage=TextEditingController();

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
                  controller: donerName,
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
                  controller: donerAge,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Age') 
                  ),
                  keyboardType: TextInputType.number,
                  textCapitalization: TextCapitalization.words,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: donerMobile,
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
                  controller: donerDistrict,
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
                  controller: donerVillage,
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
                onPressed: (){
                  addDoner();
                },
                style:const ButtonStyle(
                  minimumSize: WidgetStatePropertyAll(Size(200, 50)),
                  backgroundColor: WidgetStatePropertyAll(Colors.red)
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