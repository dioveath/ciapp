import 'package:ciapp/constants.dart';
import 'package:ciapp/size_config.dart';
import 'package:flutter/material.dart';

class ProfileViewBio extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth! * 0.8,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children:  [
          Text("About", style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontSize: 20,
              color: kSecondaryColor, 
          )),
          SizedBox(height: 10), 
          Text('''"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
            "''',
            overflow: TextOverflow.ellipsis,
            maxLines: 8,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontWeight: FontWeight.normal,
              fontSize: 14,
              color: kSecondaryColor,
          )),           
        ], 
      ), 
    );
  }
}
