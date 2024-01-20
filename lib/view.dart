import 'dart:convert';

import 'package:contacts_book/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class view extends StatefulWidget {
  const view({Key? key}) : super(key: key);

  @override
  State<view> createState() => _viewState();
}

class _viewState extends State<view> {

  get_data()
  async {
    var url = Uri.parse(
        'https://parth886695.000webhostapp.com/contacts_view.php');
    var response = await http.get(url);
    List l = jsonDecode(response.body);
    print(l);
    return l;
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   get_data();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:
        Text("view contact"),
      actions: [
        IconButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Home();
          },));
        }, icon: Icon(Icons.home))
      ],
      ),

      
      floatingActionButton: InkWell(onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Home();
        },));
      },child: Icon(Icons.home,size: 50,)),
      body: FutureBuilder(future: get_data(),builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.active || snapshot.connectionState==ConnectionState.done)
          {
            List list = snapshot.data as List;
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
              return Card(
                color: Colors.grey,
                margin: EdgeInsets.all(5),
                child: ListTile(
                  title: Text("${list[index]['name']}"),
                  subtitle: Text("${list[index]['contact']}"),
                    trailing: Wrap(children: [
                      IconButton(onPressed: () async {
                        var url = Uri.parse(
                            'https://parth886695.000webhostapp.com/cotacts_deleted.php?id=${list[index]['id']}');
                        var response = await http.get(url);
                        print(response.body);
                        setState(() {});
                      }, icon: Icon(Icons.delete_forever_outlined)),

                      //
                      // IconButton(onPressed: () async {
                      //   Navigator.push(context, MaterialPageRoute(
                      //     builder: (context) {
                      //       return Home(list[index]);
                      //     },
                      //   ));
                      // }, icon: Icon(Icons.edit)),

                      IconButton(onPressed: () async {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return Home(list[index]['id'],list[index]['name'],list[index]['contact']);
                          },
                        ));
                      }, icon: Icon(Icons.edit))


                    ],),
                ),);
            },);
          }
        else
          {
            return CircularProgressIndicator();
          }
      },)

    );
  }
}
