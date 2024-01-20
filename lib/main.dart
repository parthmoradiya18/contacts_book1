import 'package:contacts_book/view.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),));
}

class Home extends StatefulWidget {
  String ?id;
  String ?name;
  String ? contact;

  Home([this.id,this.name,this.contact]);


  // Map?m;
  // Home([this.m]);


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if(widget.m!= null)
    //   {
    //     name1.text=widget.m!['name'];
    //     contact1.text=widget.m!['contact'];
    //   }

    if(widget.id!=null)
      {
        name1.text=widget.name!;
        contact1.text=widget.contact!;
      }
  }

  TextEditingController name1 = TextEditingController();
  TextEditingController contact1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("contact book"),),
      body: Container(

        child:


        Column(children: [

          Card(
              margin: EdgeInsets.all(5),
              color: Colors.grey,
              child: TextField(controller: name1,
                decoration: InputDecoration(
                    hintText: "Enter name",
                    labelText: "Enter name"),)),
          Card(margin: EdgeInsets.all(5),
              color: Colors.grey,
              child: TextField(controller: contact1,
                decoration: InputDecoration(
                    hintText: "Enter contact",
                    labelText: "Enter contact"),)),


          // ElevatedButton(onPressed: () async {
          //   String name = name1.text;
          //   String contact = contact1.text;
          //   if(widget.m!=null)
          //   {
          //     var url = Uri.parse(
          //         'https://parth886695.000webhostapp.com/contacts_update.php');
          //
          //     var response = await http
          //         .post(url, body: {'id':'${widget.m!['id']}','name': '$name', 'contact': '$contact'});
          //     print('Response status: ${response.statusCode}');
          //     print('Response body: ${response.body}');
          //   }
          //   else
          //   {
          //     var url = Uri.parse(
          //         'https://parth886695.000webhostapp.com/contacts.php/contacts.php?name=$name&contact=$contact');
          //     var response = await http.get(url);
          //     print('Response status: ${response.statusCode}');
          //     print('Response body: ${response.body}');
          //   }
          // }, child: (widget.m!=null)?Text("Update"):Text("Add")),


          ElevatedButton(onPressed: () async {
            String name = name1.text;
            String contact = contact1.text;
            if(widget.id!=null)
            {
              var url = Uri.parse(
                  'https://parth886695.000webhostapp.com/contacts_update.php');
              var response = await http
                  .post(url, body: {'id':'${widget.id}','name': '$name', 'contact': '$contact'});
              print('Response status: ${response.statusCode}');
              print('Response body: ${response.body}');

              /*
               var url = Uri.parse(
                  'https://parth886695.000webhostapp.com/contacts_update.php?id=${widget.id}&name=$name&contact=$contact');
                   var response = await http
                  .get(url);
                  print('Response status: ${response.statusCode}');
              print('Response body: ${response.body}');
               */
            }
            else
            {
              var url = Uri.parse(
                  'https://parth886695.000webhostapp.com/contacts.php/contacts.php');
              var response = await http
                  .post(url, body: {'name': '$name', 'contact': '$contact'});
              print('Response status: ${response.statusCode}');
              print('Response body: ${response.body}');
              
              /*
              
              var url = Uri.parse(
                  'https://parth886695.000webhostapp.com/contacts.php/contacts.php?name=$name&contact=$contact');
              var response = await http.get(url);
              print('Response status: ${response.statusCode}');
              print('Response body: ${response.body}');
               */
            }
          }, child: (widget.id!=null)?Text("Update"):Text("Add")),


          ElevatedButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return view();
            },));
          }, child: Text("view"))


        ],),


      ),

    );
  }
}
