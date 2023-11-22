import 'package:flutter/material.dart';

class Alarm {
  final String name;
  final TimeOfDay time;
  final List<String> days;
  bool isEnabled;

  Alarm({
    required this.name,
    required this.time,
    required this.days,
    this.isEnabled = true,
  });
}

class AlarmListWidget extends StatefulWidget {
  @override
  _AlarmListWidgetState createState() => _AlarmListWidgetState();
}

class _AlarmListWidgetState extends State<AlarmListWidget> {
  List<Alarm> alarms = [
    Alarm(
      name: 'Kahvaltı Alarmı',
      time: TimeOfDay(hour: 7, minute: 30),
      days: ['Pzt', 'Çar', 'Cum'],
      isEnabled: true,
    ),
    Alarm(
      name: 'Öğle Yemeği Alarmı',
      time: TimeOfDay(hour: 13, minute: 30),
      days: ['Pzt', 'Çar', 'Cum'],
      isEnabled: true,
    ),
    Alarm(
      name: 'Akşam Yemeği Alarmı',
      time: TimeOfDay(hour: 18, minute: 00),
      days: ['Pzt', 'Çar', 'Cum'],
      isEnabled: true,
    ),
    Alarm(
      name: 'Egzersiz Alarmı',
      time: TimeOfDay(hour: 21, minute: 15),
      days: ['Pzt', 'Per', 'Cmrt'],
      isEnabled: true,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alarm Listesi'),
      ),
      body: AlarmList(alarms: alarms),
    );
  }
}

class AlarmList extends StatefulWidget {
  final List<Alarm> alarms;

  const AlarmList({Key? key, required this.alarms}) : super(key: key);

  @override
  _AlarmListState createState() => _AlarmListState();
}

class _AlarmListState extends State<AlarmList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.alarms.length,
      itemBuilder: (context, index) {
        return buildAlarmTile(widget.alarms[index]);
      },
    );
  }

  Widget buildAlarmTile(Alarm alarm) {
    return ListTile(
      title: Text(alarm.name),
      subtitle: Text(
          '${alarm.time.hour}:${alarm.time.minute}  ${alarm.days.join(', ')}'),
      trailing: Switch(
        value: alarm.isEnabled,
        onChanged: (value) {
          setState(() {
            alarm.isEnabled = value;
          });
        },
      ),
    );
  }
}
