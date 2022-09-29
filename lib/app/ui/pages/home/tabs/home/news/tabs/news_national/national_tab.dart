// ignore_for_file: must_call_super, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:tesis_1/app/data/data_source/services/news_service.dart';
import 'package:tesis_1/app/ui/pages/home/tabs/home/news/widgets/list_news.dart';

final newsService = SimpleProvider(
  (ref) => NewsService(),
);

class NationalTab extends StatefulWidget {
  const NationalTab({Key? key}) : super(key: key);

  @override
  State<NationalTab> createState() => _NationalTabState();
}

class _NationalTabState extends State<NationalTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (_, ref, __) {
        final controller = ref.watch(newsService);
        return Scaffold(
            body: (controller.headlines.length == 0)
                ? const Center(child: CircularProgressIndicator())
                : List_News(controller.headlines));
      }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
