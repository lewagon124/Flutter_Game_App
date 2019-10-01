import 'package:flame/components/component.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/widgets.dart';
import 'dart:ui';
import 'package:flutter/widgets.dart' as prefix1;

var game;
const SPEED = 120.0;
const ComponentSize =40.0;
main() async{
  Flame.images.loadAll(['images/morty.jpg','images/morty.jpg','images/morty.jpg','images/morty.jpg']);
  var dimensions = await Flame.util.initialDimensions();
  game = MyGame(dimensions);
  runApp(MaterialApp(
    home: Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: GameWrapper(game),
      ),
    ),
  ));
}

class GameWrapper extends StatelessWidget{
  final MyGame game;
  GameWrapper(this.game);
  @override
  Widget build(BuildContext context){
    return game.widget;
  }
}
Component component;
class MyGame extends BaseGame {
  Size dimensions;
  MyGame(this.dimensions);
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    String text = "Score: 0";
    TextPainter textPainter =TextPainter(
        text: TextSpan(
            text: text,
            style: TextStyle(
                color: Colors.white, fontSize: 48.0)
        )
    );
    textPainter.paint(canvas, Offset(size.width/ 5, size.height/2));
//    Flame.util.text(text, color: Colors.white, fontSize: 48.0);
//    textPainter.paint(canvas, Offset(size.width / 5, size.height / 2));
  }
  double creationTimer = 0.0;
  @override
  void update(double t){
    creationTimer +=t;
    if(creationTimer>=4){
      creationTimer =0.0;
      component = Component(dimensions);
      add(component);
    }
    super.update(t);
  }
}
class Component extends SpriteComponent{
  Size dimensions;
  Component(this.dimensions) : super.square(ComponentSize, 'images/morty.jpg');
  double maxY;
  bool remove = false;

  @override
  void update(double t){
    y += t * SPEED;
  }
  @override
  bool destroy(){
    bool remove;
    return remove;
  }
  @override
  void resize(Size size){
    this.x = size.width/2;
    this.y = 0;
    this.maxY = size.height;
  }
}