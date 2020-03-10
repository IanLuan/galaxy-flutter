import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

var assets = ["pink", "blue", "green", "yellow", "orange", "grey"];

class AnimationList extends StatelessWidget {
  AnimationList({this.asset});

  final asset;

  @override
  Widget build(BuildContext context) {

    return Container(
     child: SizedBox(
          width: 110,
          height: 110,
          child: FlareActor(asset,
          animation: 'rotation',
          ),
     ),
    );
  }
}