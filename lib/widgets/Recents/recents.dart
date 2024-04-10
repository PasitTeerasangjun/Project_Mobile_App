import 'package:flutter/material.dart';

class RecentsUser extends StatelessWidget {
  final List<Map<String, dynamic>> userDataList;

  const RecentsUser({Key? key, required this.userDataList}) : super(key: key);

  Future<void> _showinfo(
      BuildContext context, Map<String, dynamic> userData) async {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 43, 43, 43),
        title: Center(
          child: Text(
            'Recents',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Center(
          child: ListView.builder(
            itemCount: userDataList.length,
            itemBuilder: (context, index) {
              int reverseIndex = userDataList.length - index - 1;
              final userData = userDataList[reverseIndex];
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: Card(
                  color: Color.fromARGB(255, 32, 32, 32),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(userData['image'] ?? ''),
                    ),
                    title: Text(
                      'Name : ${userData['firstName']} ${userData['lastName']}',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      'Phone : ${userData['phone']}',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      _showinfo(
                          context, userData);
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
