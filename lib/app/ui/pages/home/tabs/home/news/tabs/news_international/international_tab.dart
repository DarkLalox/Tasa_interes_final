// ignore_for_file: prefer_is_empty, must_call_super, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:tesis_1/app/data/data_source/services/news_service.dart';
import 'package:tesis_1/app/ui/pages/home/tabs/home/news/widgets/list_news.dart';

final NewsService22 = SimpleProvider(
  (ref) => NewsService2(),
);

class InternationalTab extends StatefulWidget {
  const InternationalTab({Key? key}) : super(key: key);

  @override
  State<InternationalTab> createState() => _InternationalTabState();
}

class _InternationalTabState extends State<InternationalTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (_, ref, __) {
        final controller = ref.watch(NewsService22);
        return Scaffold(
            body: (controller.headlines2.length == 0)
                ? const Center(child: CircularProgressIndicator())
                : List_News(controller.headlines2));
      }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
