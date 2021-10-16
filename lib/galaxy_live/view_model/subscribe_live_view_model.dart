import 'package:flutter/material.dart';
import 'package:flutter_learnings/galaxy_live/models/live_model.dart';

class SubScribeLiveViewModel extends ChangeNotifier {
  LiveModel live;
  String get title => live.title;
  SubScribeLiveViewModel(this.live);
}