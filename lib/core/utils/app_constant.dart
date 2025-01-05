import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';

class AppConstant {
 static List<Reaction<String>?> reactionList = [
    Reaction<String>(
      value: 'LIKE',
      icon: Image.asset('assets/images/reaction/like.gif'),
    ),
    Reaction<String>(
      value: 'LOVE',
      icon: Image.asset('assets/images/reaction/love.gif'),
    ),
    Reaction<String>(
      value: 'HAHA',
      icon: Image.asset('assets/images/reaction/haha.gif'),
    ),
    Reaction<String>(
      value: 'WOW',
      icon: Image.asset('assets/images/reaction/wow.gif'),
    ),
    Reaction<String>(
      value: 'SAD',
      icon: Image.asset('assets/images/reaction/sad.gif'),
    ),
    Reaction<String>(
      value: 'ANGRY',
      icon: Image.asset('assets/images/reaction/angry.gif'),
    ),
  ];
}

enum ReactionEmoji {
  nothing,
  like,
  love,
  haha,
  wow,
  sad,
  angry,
}

class AssetSounds {
  static const String boxDown = "sound_box_down.mp3";
  static const String boxUp = "sound_box_up.mp3";
  static const String focus = "sound_focus.mp3";
  static const String pick = "sound_pick.mp3";
  static const String shortPressLike = "sound_short_press_like.mp3";
}

class AssetImages {
  static const String loveGif = "assets/images/reaction/love.gif";
  static const String hahaGif = "assets/images/reaction/haha.gif";
  static const String likeGif = "assets/images/reaction/like.gif";
  static const String wowGif = "assets/images/reaction/wow.gif";
  static const String sadGif = "assets/images/reaction/sad.gif";
  static const String angryGif = "assets/images/reaction/angry.gif";

  static const String icLikeFill = "assets/images/reaction/ic_like_fill.png";
  static const String icLike = "assets/images/reaction/ic_like.png";
  static const String icLove2 = "assets/images/reaction/love2.png";
  static const String icHaha2 = "assets/images/reaction/haha2.png";
  static const String icWow2 = "assets/images/reaction/wow2.png";
  static const String icSad2 = "assets/images/reaction/sad2.png";
  static const String icAngry2 = "assets/images/reaction/angry2.png";
}
