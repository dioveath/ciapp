
import 'package:ciapp/constants.dart';
import 'package:flutter/material.dart';

class ProfileMetricsSide extends StatelessWidget {
  String? text = "";
  Icon? icon;

  ProfileMetricsSide({
    Key? key,
    this.text,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kBackgroundColor, 
      child: InkWell(
        onTap: (){}, 
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14), 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              icon!,
              Text(this.text!,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontSize: 16,
                        color: kSecondaryColor,
                      )),
              // Text("Articles", style: Theme.of(context).textTheme.headline6.copyWith(
              //     fontSize: 16,
              //     color: kSecondaryColor,
              // )),
            ],
          ),
        ),
      ),
    );
  }
}
