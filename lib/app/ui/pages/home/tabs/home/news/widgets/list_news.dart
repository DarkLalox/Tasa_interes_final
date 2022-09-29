// ignore_for_file: use_key_in_widget_constructors, camel_case_types, unnecessary_this, avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:tesis_1/app/classes/language_constants.dart';
import 'package:tesis_1/app/domain/models/news_models.dart';
import 'package:url_launcher/url_launcher.dart';

class List_News extends StatelessWidget {
  final List<Article> news;

  const List_News(this.news);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.news.length,
      itemBuilder: (BuildContext context, int index) {
        return _News(
          newss: this.news[index],
          index: index,
        );
      },
    );
  }
}

class _News extends StatelessWidget {
  final Article newss;
  final int index;
  const _News({required this.newss, required this.index});
  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    return Column(
      children: <Widget>[
        _CardTopBar(newss, index),
        _CardTitle(newss),
        _CardImage(newss),
        _CardBody(newss),
        const SizedBox(height: 10),
        _CardButtons(newss),
        const SizedBox(
          height: 10,
        ),
        Divider(color: isDark ? Colors.white : Colors.black54),
      ],
    );
  }
}

class _CardButtons extends StatelessWidget {
  final Article newss;

  const _CardButtons(this.newss);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 30,
            width: 100,
            child: ElevatedButton(
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all(
                  const TextStyle(
                    fontSize: 13,
                  ),
                ),
                elevation: MaterialStateProperty.all(3),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              onPressed: () {
                // ignore: deprecated_member_use
                launch(newss.url);
              },
              child: Text(translation(context).simpleText61),
            ),
          ),
        ],
      ),
    );
  }
}

class _CardBody extends StatelessWidget {
  final Article newss;
  const _CardBody(this.newss);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text((newss.description != null) ? newss.description! : ' '));
  }
}

class _CardImage extends StatelessWidget {
  final Article newss;

  const _CardImage(this.newss);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.isDarkMode;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(30),
        ),
        child: Container(
            child: (newss.urlToImage != null)
                ? FadeInImage(
                    placeholder: AssetImage(
                        'assets/images/${isDarkMode ? 'dark' : 'light'}/giphy.gif'),
                    image: NetworkImage(newss.urlToImage!),
                  )
                : Image(
                    image: AssetImage(
                        'assets/images/${isDarkMode ? 'dark' : 'light'}/no-image.png'),
                  )),
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  final Article newss;

  const _CardTitle(this.newss);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        newss.title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _CardTopBar extends StatelessWidget {
  final Article newss;
  final int index;

  const _CardTopBar(this.newss, this.index);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          Text(
            '${index + 1}. ',
            style: const TextStyle(color: Colors.red),
          ),
          Text('${newss.source.name}. '),
        ],
      ),
    );
  }
}
