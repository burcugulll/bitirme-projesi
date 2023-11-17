import "package:flutter/material.dart";

class CustomButtonRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget page;

  CustomButtonRow(
      {required this.icon, required this.title, required this.page});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(icon),
        SizedBox(width: 8),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.deepPurple[200],
              onPrimary: Colors.black,
            ),
            child: Text(title),
          ),
        ),
      ],
    );
  }
}
