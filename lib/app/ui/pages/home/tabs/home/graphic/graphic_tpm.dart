// ignore_for_file: sized_box_for_whitespace, camel_case_types, non_constant_identifier_names, avoid_print, unused_local_variable, sort_child_properties_last
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:tesis_1/app/classes/language_constants.dart';
import 'package:tesis_1/app/tmp_graphic.dart';
import 'package:tesis_1/app/tmp_graphic2.dart';

class Graphic_TPM extends StatelessWidget {
  const Graphic_TPM({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    return Scaffold(
        appBar: AppBar(
          title: Text(translation(context).simpleText49),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  width: 580,
                  height: 580,
                  child: isDark ? const _DateTPM() : const _DateTPM1(),
                )
              ],
            ),
          ),
        ));
  }
}

class _DateTPM extends StatefulWidget {
  const _DateTPM({Key? key}) : super(key: key);

  @override
  State<_DateTPM> createState() => __DateTPMState();
}

class __DateTPMState extends State<_DateTPM> {
  final _URL_BANCO_CENTRAL =
      'https://si3.bcentral.cl/SieteRestWS/SieteRestWS.ashx';

  final _User = '196686746';

  final _PASS = '98pnQn6ja52v';

  final _TIMESERIES = 'F022.TPM.TIN.D001.NO.Z.D';
  bool loading = true;
  List<TimeSeriesSales> _data = [];
  @override
  void initState() {
    super.initState();
    InitialGraphic();
  }

  Future InitialGraphic() async {
    final url =
        '$_URL_BANCO_CENTRAL?user=$_User&pass=$_PASS&firstdate=2022-01-01&lastdate=2022-12-01&timeseries=$_TIMESERIES';
    final res = await http.get(Uri.parse(url));
    final jsondata = jsonDecode(res.body);
    _data = [];
    for (var item in jsondata['Series']['Obs']) {
      if (!double.parse(item["value"]).isNaN) {
        print(item);
        var n = item['indexDateString'].split('-');
        _data.add(TimeSeriesSales(
            DateTime(int.parse(n[2]), int.parse(n[1]), int.parse(n[0])),
            double.parse(item['value'])));
      }
    }
    if (!mounted) return;
    setState(() {
      loading = false;
    });
  }

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(2022, 01, 01),
    end: DateTime.now(),
  );
  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(translation(context).simpleText55,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 40,
                    child: ElevatedButton.icon(
                      onPressed: pickDateRange,
                      label: Text('${start.day}-${start.month}-${start.year}'),
                      icon: const Icon(Icons.calendar_today),
                    ),
                  ),
                  const SizedBox(width: 30),
                  Container(
                    width: 150,
                    height: 40,
                    child: ElevatedButton.icon(
                      onPressed: pickDateRange,
                      label: Text('${end.day}-${end.month}-${end.year}'),
                      icon: const Icon(Icons.calendar_today),
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Center(
                      child: SizedBox(
                          height: 400.0,
                          width: 350.0,
                          child: (loading == true)
                              ? Transform.scale(
                                  scale: 0.3,
                                  child: const CircularProgressIndicator(),
                                )
                              : SimpleTimeSeriesChart.withSampleData(_data)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        initialDateRange: dateRange,
        firstDate: DateTime(1997),
        lastDate: DateTime.now(),
        builder: (context, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 100),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 550,
                    maxWidth: 380,
                  ),
                  child: child,
                )
              ],
            ),
          );
        });
    if (newDateRange != null) {
      String fecha_inicial =
          DateFormat('yyyy-MM-dd').format(newDateRange.start);
      String fecha_final = DateFormat('yyyy-MM-dd').format(newDateRange.end);
      print(fecha_inicial);
      print(fecha_final);
      final url =
          '$_URL_BANCO_CENTRAL?user=$_User&pass=$_PASS&firstdate=$fecha_inicial&lastdate=$fecha_final&timeseries=$_TIMESERIES';
      final res = await http.get(Uri.parse(url));
      final jsondata = jsonDecode(res.body);
      _data = [];
      for (var item in jsondata['Series']['Obs']) {
        if (!double.parse(item["value"]).isNaN) {
          print(item);
          var n = item['indexDateString'].split('-');
          _data.add(TimeSeriesSales(
              DateTime(int.parse(n[2]), int.parse(n[1]), int.parse(n[0])),
              double.parse(item['value'])));
        }
      }
      setState(() {
        dateRange = newDateRange;
        bool loading = false;
      });
    }
  }
}

class _DateTPM1 extends StatefulWidget {
  const _DateTPM1({Key? key}) : super(key: key);

  @override
  State<_DateTPM1> createState() => __DateTPMState1();
}

class __DateTPMState1 extends State<_DateTPM1> {
  final _URL_BANCO_CENTRAL =
      'https://si3.bcentral.cl/SieteRestWS/SieteRestWS.ashx';

  final _User = '196686746';

  final _PASS = '98pnQn6ja52v';

  final _TIMESERIES = 'F022.TPM.TIN.D001.NO.Z.D';
  bool loading = true;
  List<TimeSeriesSales1> _data1 = [];
  @override
  void initState() {
    super.initState();
    InitialGraphic();
  }

  Future InitialGraphic() async {
    final url =
        '$_URL_BANCO_CENTRAL?user=$_User&pass=$_PASS&firstdate=2022-01-01&lastdate=2022-12-01&timeseries=$_TIMESERIES';
    final res = await http.get(Uri.parse(url));
    final jsondata = jsonDecode(res.body);
    _data1 = [];
    for (var item in jsondata['Series']['Obs']) {
      if (!double.parse(item["value"]).isNaN) {
        print(item);
        var n = item['indexDateString'].split('-');
        _data1.add(TimeSeriesSales1(
            DateTime(int.parse(n[2]), int.parse(n[1]), int.parse(n[0])),
            double.parse(item['value'])));
      }
    }
    if (!mounted) return;
    setState(() {
      loading = false;
    });
  }

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(2022, 01, 01),
    end: DateTime.now(),
  );
  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(translation(context).simpleText55,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 40,
                    child: ElevatedButton.icon(
                      onPressed: pickDateRange,
                      label: Text('${start.day}-${start.month}-${start.year}'),
                      icon: const Icon(Icons.calendar_today),
                    ),
                  ),
                  const SizedBox(width: 30),
                  Container(
                    width: 150,
                    height: 40,
                    child: ElevatedButton.icon(
                      onPressed: pickDateRange,
                      label: Text('${end.day}-${end.month}-${end.year}'),
                      icon: const Icon(Icons.calendar_today),
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Center(
                      child: SizedBox(
                          height: 400.0,
                          width: 350.0,
                          child: (loading == true)
                              ? Transform.scale(
                                  scale: 0.3,
                                  child: const CircularProgressIndicator(),
                                )
                              : SimpleTimeSeriesChart1.withSampleData(_data1)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        initialDateRange: dateRange,
        firstDate: DateTime(1997),
        lastDate: DateTime.now(),
        builder: (context, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 100),
                ConstrainedBox(
                  child: Theme(
                      data:
                          ThemeData.light().copyWith(primaryColor: Colors.blue),
                      child: child!),
                  constraints: const BoxConstraints(
                    maxHeight: 550,
                    maxWidth: 380,
                  ),
                )
              ],
            ),
          );
        });
    if (newDateRange != null) {
      String fecha_inicial =
          DateFormat('yyyy-MM-dd').format(newDateRange.start);
      String fecha_final = DateFormat('yyyy-MM-dd').format(newDateRange.end);
      print(fecha_inicial);
      print(fecha_final);
      final url =
          '$_URL_BANCO_CENTRAL?user=$_User&pass=$_PASS&firstdate=$fecha_inicial&lastdate=$fecha_final&timeseries=$_TIMESERIES';
      final res = await http.get(Uri.parse(url));
      final jsondata = jsonDecode(res.body);
      _data1 = [];
      for (var item in jsondata['Series']['Obs']) {
        if (!double.parse(item["value"]).isNaN) {
          print(item);
          var n = item['indexDateString'].split('-');
          _data1.add(TimeSeriesSales1(
              DateTime(int.parse(n[2]), int.parse(n[1]), int.parse(n[0])),
              double.parse(item['value'])));
        }
      }

      setState(() {
        dateRange = newDateRange;
        bool loading = false;
      });
    }
  }
}
