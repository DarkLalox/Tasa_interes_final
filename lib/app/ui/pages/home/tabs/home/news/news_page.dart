import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:tesis_1/app/classes/language_constants.dart';
import 'package:tesis_1/app/ui/pages/home/tabs/home/news/news_controller.dart';
import 'package:tesis_1/app/ui/pages/home/tabs/home/news/tabs/news_international/international_tab.dart';
import 'package:tesis_1/app/ui/pages/home/tabs/home/news/tabs/news_national/national_tab.dart';
import 'package:tesis_1/app/ui/pages/home/tabs/home/news/widgets/news_tab_bar.dart';

final newsProvider = SimpleProvider(
  (_) => NewsController(),
);

class News extends StatelessWidget {
  const News({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ProviderListener<NewsController>(
      provider: newsProvider,
      builder: (_, controller) {
        return Scaffold(
          bottomNavigationBar: NewsTabBar(),
          appBar: AppBar(
            title: Text(translation(context).simpleText44),
          ),
          body: SafeArea(
              child: TabBarView(
            controller: controller.tabController,
            children: const [
              NationalTab(),
              InternationalTab(),
            ],
          )),
        );
      },
    );
  }
}
