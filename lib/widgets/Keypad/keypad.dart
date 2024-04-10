import 'package:flutter/material.dart';
import 'package:project/widgets/Keypad/widgets/pin_button.dart';
import 'package:dio/dio.dart';

class Keypad extends StatefulWidget {
  final Function(Map<String, dynamic>) onUserFound;

  const Keypad({Key? key, required this.onUserFound}) : super(key: key);

  static const _keypad = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
    // -2 = Clear, -1 = Back
    [-4, 0, -5],
    [-2, -3, -1]
  ];

  @override
  State<Keypad> createState() => _PinLoginPageState();
}

class _PinLoginPageState extends State<Keypad> {
  String _input = '';

  @override
  Widget build(BuildContext context) {
    //print('Your input is $_input');

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$_input ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            _buildKeypad(),
          ],
        ),
      ),
    );
  }

  Column _buildKeypad() {
    return Column(
      children: [
        for (var row in Keypad._keypad) _buildRow(row),
      ],
    );
  }

  void _handleClickButton(int num) {
    setState(() {
      if (_input.length == 3 || _input.length == 7) {
        _input += ' ';
      }

      if (num == -1) {
        if (_input.substring(_input.length - 1, _input.length) == ' ') {
          _input = _input.substring(0, _input.length - 2);
        } else {
          _input = _input.substring(0, _input.length - 1);
        }
      } else if (num == -2) {
        _input = '';
      } else if (num == -3) {
        _checkNum();
      } else if (num == -4) {
        _input += '*';
      } else if (num == -5) {
        _input += '#';
      } else {
        _input += num.toString();
      }
    });
  }

  Widget _buildRow(List<int> numList) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var num in numList)
          PinButton(
            num: num,
            onClick: () {
              _handleClickButton(num);
            },
          ),
      ],
    );
  }

  Future<void> _checkNum() async {
  var dio = Dio();
  try {
    final response = await dio.get('https://dummyjson.com/users');
    final List<Map<String, dynamic>> users = List<Map<String, dynamic>>.from(response.data['users']);
    final List<String> phoneNumbers = users.map((user) => user['phone'].toString()).toList();

    List<String> phoneSubstrings = phoneNumbers.map((phoneNumber) => phoneNumber.substring(phoneNumber.length - 12)).toList();
    //print(phoneSubstrings);

    int index = phoneSubstrings.indexOf(_input);
    if (index != -1) {
      final userData = users[index];
      widget.onUserFound(userData);
      
      showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Calling..."),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(userData['image'] ?? ''),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text("Firstname : ${userData['firstName']}"),
                  Text("Lastname : ${userData['lastName']}"),
                  Text("Phone : ${userData['phone']}"),
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
    

    } else {
      showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sorry!'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('This number is not in contacts.'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  } catch (e) {
    print('Error fetching user data: $e');
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('An error occurred. Please try again later.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

}
