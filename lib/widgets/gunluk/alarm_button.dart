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
      subtitle: Text('${alarm.time.format(context)}  ${alarm.days.join(', ')}'),
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
