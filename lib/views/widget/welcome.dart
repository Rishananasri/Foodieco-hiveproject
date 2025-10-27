import 'package:flutter/material.dart';

Future<void> showWelcomeDialog(BuildContext context, String username,{String?txt1,String?txt2}) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        backgroundColor: const Color.fromARGB(101, 0, 0, 0),
        child: Container(
          height: 200,
          padding:  EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 217, 226, 236),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
              txt1 ?? 'Welcome!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 33, 62, 111),
                ),
              ),
              SizedBox(height: 10),
              Text(
              txt2??  'Hello, $username',
                style: TextStyle(fontSize: 20, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
      );
    },
  );

  await Future.delayed(Duration(seconds: 2));
  Navigator.of(context).pop();
}
