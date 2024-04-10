import 'package:flutter/material.dart';

class PinButton extends StatelessWidget {
  const PinButton({super.key, required this.num, required this.onClick});

  final int num;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    String? label;
    // num = 0-9
    List<String> labelList = [
      '+',
      '',
      'ABC',
      'DEF',
      'GHI',
      'JKL',
      'MNO',
      'PQRS',
      'TUV',
      'WXYZ',
    ];

    if (num >= 0 && num <= 9) {
      label = labelList[num];
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onClick,
        child: Container(
          width: 80.0,
          height: 80.0,
          margin: EdgeInsets.only(top: 4.0, right: 10.0 , left: 10.0 , bottom: 4.0),
          decoration: BoxDecoration(
            
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (num >= 0 && num <= 9)
                  Text(
                    num.toString(),
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                if (num == 0 || num >= 2 && num <= 9)
                  Text(label ?? '', style: TextStyle(fontSize: 15.0 , color: Colors.white)),
                if (num == 1) Icon(Icons.voicemail , color: Colors.white, size: 17.0,),
                if (num == -2) Icon(Icons.close , color: Colors.white,),
                if (num == -1) Icon(Icons.backspace , color: Colors.white,),
                if (num == -3) Icon(Icons.phone , color: Colors.white,),
                if (num == -4) Text(
                    "*",
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                if (num == -5) Text(
                    "#",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
