import 'package:flutter/material.dart';

class ListTileComponent extends StatelessWidget {
   ListTileComponent({super.key , required this.leading ,required this.title ,required this.subtitle , required this.trailing});
  String leading , title, subtitle, trailing;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {},
          child: ListTile(
            leading:  Text(
             leading,
              style: TextStyle(color: Colors.black38, fontFamily: 'Pacifico'),
            ),
            title:  Text(
                title ,
              style: TextStyle(color: Colors.black38, fontFamily: 'Pacifico'),
            ),
            subtitle:  Text(
                 subtitle  ,
              style: TextStyle(color: Colors.black38, fontFamily: 'Pacifico'),
            ),
            trailing:  Text(
              trailing,
              style: TextStyle(
                  color: Colors.blue, fontFamily: 'Pacifico', fontSize: 16),
            ),
          ),
        ),
        const Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Divider(
            color: Colors.grey,
            height: 1,
          ),
        ),
      ],
    );
  }
}
