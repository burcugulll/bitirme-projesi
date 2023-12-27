import 'package:flutter/material.dart';

class Alarm {
  final String name;
  TimeOfDay time;
  List<String> days;
  bool isEnabled;

  Alarm({
    required this.name,
    required this.time,
    required this.days,
    this.isEnabled = true,
  });
}

class AlarmListWidget extends StatefulWidget {
  const AlarmListWidget({Key? key}) : super(key: key);

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
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white70,
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
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AlarmDetailScreen(alarm: widget.alarms[index]),
              ),
            );
          },
          child: buildAlarmTile(widget.alarms[index]),
        );
      },
    );
  }

  Widget buildAlarmTile(Alarm alarm) {
    return ListTile(
      title: Text(alarm.name),
      subtitle: Text(
        '${alarm.time.hour}:${alarm.time.minute}  ${alarm.days.join(', ')}',
      ),
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

class AlarmDetailScreen extends StatefulWidget {
  final Alarm alarm;

  const AlarmDetailScreen({Key? key, required this.alarm}) : super(key: key);

  @override
  _AlarmDetailScreenState createState() => _AlarmDetailScreenState();
}

class _AlarmDetailScreenState extends State<AlarmDetailScreen> {
  late TimeOfDay selectedTime;
  late List<String> selectedDays;
  late List<String> allDays = ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt', 'Paz'];

  @override
  void initState() {
    super.initState();
    selectedTime = widget.alarm.time;
    selectedDays = List.from(widget.alarm.days);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alarm Düzenle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text('Saat'),
              trailing: Text('${selectedTime.hour}:${selectedTime.minute}'),
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: selectedTime,
                );

                if (pickedTime != null && pickedTime != selectedTime) {
                  setState(() {
                    selectedTime = pickedTime;
                  });
                }
              },
            ),
            ListTile(
              title: Text('Günler'),
              trailing: Text(selectedDays.join(', ')),
              onTap: () async {
                List<String>? pickedDays = await showDialog<List<String>>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Günleri Seç'),
                    content: Column(
                      children: allDays.map((day) {
                        return CheckboxListTile(
                          title: Text(day),
                          value: selectedDays.contains(day),
                          onChanged: (value) {
                            setState(() {
                              if (value != null) {
                                if (value) {
                                  if (!selectedDays.contains(day)) {
                                    selectedDays.add(day);
                                  }
                                } else {
                                  selectedDays.remove(day);
                                }
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, selectedDays);
                        },
                        child: Text('Tamam'),
                      ),
                    ],
                  ),
                );

                if (pickedDays != null) {
                  setState(() {
                    selectedDays = pickedDays;
                  });
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.alarm.time = selectedTime;
                  widget.alarm.days = selectedDays;
                });
                Navigator.pop(context);
              },
              child: Text('Kaydet'),
            ),
          ],
        ),
      ),
    );
  }
}
