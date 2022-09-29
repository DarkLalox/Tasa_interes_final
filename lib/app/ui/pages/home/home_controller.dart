// ignore_for_file: implementation_imports

import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:flutter_meedu/meedu.dart';

class HomeController extends SimpleNotifier implements TickerProvider {
  late TabController tabController;

  HomeController() {
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}
