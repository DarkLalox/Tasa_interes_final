// ignore_for_file: prefer_const_constructors, implementation_imports, must_be_immutable
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/src/text_element.dart' as elements;
import 'package:charts_flutter/src/text_style.dart' as styles;
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:tesis_1/app/classes/language_constants.dart';

class SimpleTimeSeriesChart extends StatelessWidget {
  final List<charts.Series<dynamic, DateTime>> seriesList;
  final bool animate;

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  SimpleTimeSeriesChart(this.seriesList, {required this.animate});

  factory SimpleTimeSeriesChart.withSampleData(data) {
    return SimpleTimeSeriesChart(
      _createSampleData(data),
      animate: false,
    );
  }
  static String? pointerAmount;
  static String? pointerDay;
  var axis = charts.NumericAxisSpec(
      renderSpec: charts.GridlineRendererSpec(
    labelStyle: charts.TextStyleSpec(
        fontSize: 10,
        color: charts.MaterialPalette
            .white), //chnage white color as per your requirement.
  ));

  @override
  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(
      seriesList,
      selectionModels: [
        charts.SelectionModelConfig(
            changedListener: (charts.SelectionModel model) {
          if (model.hasDatumSelection) {
            pointerAmount = model.selectedSeries[0]
                .measureFn(model.selectedDatum[0].index)
                ?.toStringAsFixed(2);
            pointerDay = model.selectedSeries[0]
                .domainFn(model.selectedDatum[0].index)
                ?.toString();
          }
        })
      ],
      behaviors: [
        charts.LinePointHighlighter(symbolRenderer: MySymbolRenderer(context))
      ],
      animate: animate,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
      domainAxis: charts.DateTimeAxisSpec(
          renderSpec: charts.GridlineRendererSpec(
              lineStyle: charts.LineStyleSpec(
                  color: charts.MaterialPalette.transparent),
              labelStyle:
                  charts.TextStyleSpec(color: charts.MaterialPalette.white))),
      primaryMeasureAxis: charts.NumericAxisSpec(
          tickProviderSpec: charts.BasicNumericTickProviderSpec(
            desiredTickCount: 7,
          ),
          renderSpec: charts.GridlineRendererSpec(
              labelStyle:
                  charts.TextStyleSpec(color: charts.MaterialPalette.white),
              lineStyle: charts.LineStyleSpec(
                  color: charts.MaterialPalette.gray.shade800))),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData(
      data) {
    return [
      charts.Series<TimeSeriesSales, DateTime>(
        id: 'Tasa de interés',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (TimeSeriesSales value, _) => value.time,
        measureFn: (TimeSeriesSales value, _) => value.value,
        data: data,
      )
    ];
  }
}

class MySymbolRenderer extends charts.CircleSymbolRenderer {
  final BuildContext context;
  MySymbolRenderer(this.context);
  @override
  void paint(charts.ChartCanvas canvas, Rectangle<num> bounds,
      {List<int>? dashPattern,
      charts.Color? fillColor,
      charts.FillPatternType? fillPattern,
      charts.Color? strokeColor,
      double? strokeWidthPx}) {
    super.paint(
      canvas,
      bounds,
      dashPattern: dashPattern,
      fillColor: fillColor,
      fillPattern: fillPattern,
      strokeColor: strokeColor,
      strokeWidthPx: strokeWidthPx,
    );

    canvas.drawRect(
      Rectangle(
        bounds.left - 40,
        bounds.top - 32,
        bounds.width + 80,
        bounds.height + 22,
      ),
      fill: charts.ColorUtil.fromDartColor(Color(0xff1b1b1b)),
      stroke: charts.ColorUtil.fromDartColor(Colors.red),
      strokeWidthPx: 2,
    );

    var myStyle = styles.TextStyle();
    myStyle.fontSize = 9;
    myStyle.color = charts.ColorUtil.fromDartColor(Colors.grey.shade300);
    canvas.drawText(
      elements.TextElement(
          translation(context).textWithPlaceholders(
              DateFormat('dd-MM-yyyy')
                  .format(DateTime.parse(SimpleTimeSeriesChart.pointerDay!)),
              SimpleTimeSeriesChart.pointerAmount!),
          style: myStyle),
      (bounds.left - 35).round(),
      (bounds.top - 24).round(),
    );
  }
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final double value;

  TimeSeriesSales(this.time, this.value);
}
