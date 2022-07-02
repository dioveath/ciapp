import 'package:flutter/material.dart';
import 'package:ciapp/size_config.dart';


class SplashContent extends StatelessWidget {
  final String text;
  final String imageLoc;

  const SplashContent({
    Key key,
    this.text,
    this.imageLoc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        Spacer(),
        Text("Charicha Institute",
            style: Theme.of(context).textTheme.headline5),
        Text(text, style: Theme.of(context).textTheme.headline6),
        Spacer(),
        Image.asset(imageLoc,
          fit: BoxFit.scaleDown, 
          width: getPHeight(800), 
        ),
      ]),
    );
  }
}
