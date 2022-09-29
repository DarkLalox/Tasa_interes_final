// ignore_for_file: unnecessary_this, use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';

import 'package:tesis_1/app/domain/models/interest_models.dart';

class ListInterest extends StatelessWidget {
  final List<Ob> interest;

  const ListInterest(this.interest);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.interest.length,
      itemBuilder: (BuildContext context, int index) {
        return Text(this.interest[index].value);
      },
    );
  }
}
