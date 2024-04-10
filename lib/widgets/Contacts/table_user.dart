import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project/widgets/Contacts/list_user.dart';

class TableUser extends StatefulWidget {
  const TableUser({super.key});

  @override
  State<TableUser> createState() => _TableState();
}

class _TableState extends State<TableUser> {
  List<list_user>? _data;

  // เมธอดสำหรับโหลดข้อมูล
  void _getuser() async {
    try {
      var dio = Dio(BaseOptions(responseType: ResponseType.plain));
      var response = await dio.get('https://dummyjson.com/users');

      if (response.statusCode == 200) {
        var userData = jsonDecode(response.data)['users'] as List;
        setState(() {
          _data = userData
              .map((user) => list_user(
                    firstName: user['firstName'],
                    lastName: user['lastName'],
                    phone: user['phone'],
                    image: user['image'],
                  ))
              .toList();
        });
      } else {
        print('Failed to load user data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      // Handle error
    }
  }

  @override
  void initState() {
    super.initState();
    // เรียกเมธอดสำหรับโหลดข้อมูลใน initState() ของคลาสที่ extends มาจาก State
    _getuser();
  }

  Future<void> _showinfo(list_user data) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Info User"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(data.image ?? ''),
                  ),
                ),
                SizedBox(height: 10),
                Text("Firstname : ${data.firstName}"),
                Text("Lastname : ${data.lastName}"),
                Text("Phone : ${data.phone}"),
                //CircleAvatar(backgroundImage: NetworkImage(data.image ?? ''),),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildPageBody() {
      if (_data == null) {
        // Show a loading indicator or an error message when data is null
        return Center(child: CircularProgressIndicator());
      } else {
        return ListView.builder(
          itemCount: _data!.length,
          itemBuilder: (context, index) {
            var data = _data![index];
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Card(
                color: Color.fromARGB(
                    255, 32, 32, 32),
                child: ListTile(
                  title: Text(
                    "Name : ${data.firstName} ${data.lastName}",
                    style: TextStyle(
                        color: Colors.white),
                  ),
                  subtitle: Text(
                    "Phone: ${data.phone}",
                    style: TextStyle(
                        color: Colors.white),
                  ),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(data.image ?? ''),
                  ),
                  onTap: () {
                    _showinfo(data);
                  },
                ),
              ),
            );
          },
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        
        backgroundColor: const Color.fromARGB(255, 43, 43, 43),
        
        title: Center(
          child: Text(
            'Contacts',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Center(
          child: _buildPageBody(),
        ),
      ),
    );
  }
}
