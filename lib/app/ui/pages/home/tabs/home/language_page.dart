// ignore_for_file: avoid_unnecessary_containers, no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tesis_1/app/classes/language.dart';
import 'package:tesis_1/app/classes/language_constants.dart';
import 'package:tesis_1/app/my_app.dart';

class Idioma extends StatefulWidget {
  const Idioma({Key? key}) : super(key: key);

  @override
  State<Idioma> createState() => _IdiomaState();
}

class _IdiomaState extends State<Idioma> {
  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    return Scaffold(
        appBar: AppBar(
          title: Text(translation(context).simpleText45),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Container(
                child: Center(
                    child: DropdownButton<Language>(
                  iconSize: 30,
                  hint: Text(translation(context).simpleText62),
                  onChanged: (Language? language) async {
                    if (language != null) {
                      Locale _locale = await setLocale(language.languageCode);
                      MyApp.setLocale(context, _locale);
                    }
                  },
                  items: Language.languageList()
                      .map<DropdownMenuItem<Language>>(
                        (e) => DropdownMenuItem<Language>(
                          value: e,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                e.flag,
                                style: const TextStyle(fontSize: 30),
                              ),
                              Text(e.name)
                            ],
                          ),
                        ),
                      )
                      .toList(),
                )),
              ),
              const SizedBox(height: 80),
              AspectRatio(
                aspectRatio: 16 / 9,
                child: SvgPicture.asset(
                  'assets/images/${isDark ? 'dark' : 'light'}/World.svg',
                ),
              ),
            ],
          ),
        ));
  }
}
