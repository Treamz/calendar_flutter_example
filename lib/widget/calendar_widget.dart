import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalendarWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CalendarWidgetState();
}

class CalendarWidgetState extends State<CalendarWidget> {
  late DateTime dt;
  var month;
  var day;
  var year;
  var firstDayOfMonth;
  var daysInMonth;
  var dateString;
  var paddingDays;
  var nav = 0;
  List days = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initCalendar();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  child: Container(
                    padding:EdgeInsets.all(10),
                    child: Text('${MyCalendar().months[month-1]} ${year}'),
                  ),
                ),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () => onBack(), child: Text("back")),
                    Padding(padding: EdgeInsets.all(5)),
                    ElevatedButton(
                        onPressed: () => onNext(), child: Text("next"))
                  ],
                ),
              ],
            ),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 7,
              children: [
                Card(
                    child: Center(
                  child: Text(
                    MyCalendar().weekDays[0].toString().substring(0, 3),
                    style: TextStyle(fontSize: 12),
                  ),
                )),
                Card(
                    child: Center(
                  child: Text(
                    MyCalendar().weekDays[1].toString().substring(0, 3),
                    style: TextStyle(fontSize: 12),
                  ),
                )),
                Card(
                    child: Center(
                  child: Text(
                    MyCalendar().weekDays[2].toString().substring(0, 3),
                    style: TextStyle(fontSize: 12),
                  ),
                )),
                Card(
                    child: Center(
                  child: Text(
                    MyCalendar().weekDays[3].toString().substring(0, 3),
                    style: TextStyle(fontSize: 12),
                  ),
                )),
                Card(
                    child: Center(
                  child: Text(
                    MyCalendar().weekDays[4].toString().substring(0, 3),
                    style: TextStyle(fontSize: 12),
                  ),
                )),
                Card(
                    child: Center(
                  child: Text(
                    MyCalendar().weekDays[5].toString().substring(0, 3),
                    style: TextStyle(fontSize: 12),
                  ),
                )),
                Card(
                    child: Center(
                  child: Text(
                    MyCalendar().weekDays[6].toString().substring(0, 3),
                    style: TextStyle(fontSize: 12),
                  ),
                )),
              ],
            ),
            GridView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  // childAspectRatio: (3 / 2),
                ),
                itemCount: days.length > 0 ? days.length : 0,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: days[index],
                  );
                }),
          ],
        ),
      ),
    );
  }

  Widget dayWidget(num num) {
    return Card(
      child: Center(
        child: Text("$num"),
      ),
    );
  }

  Widget paddingDayWidget() {
    return Container();
  }

  void onBack() {
    setState(() {
      nav--;
    });
    initCalendar();
  }

  void onNext() {
    setState(() {
      nav++;
    });
    initCalendar();
  }

  void initCalendar() {
    setState(() {
      days = [];
    });
    dt = DateTime.now();
    if (nav != 0) {
      dt = DateTime(DateTime.now().year, DateTime.now().month + nav);
    }
    day = dt.day;
    month = dt.month;
    year = dt.year;
    firstDayOfMonth = DateTime(year, month, 1);
    daysInMonth = DateTime(year, month + 1, 0).day;
    dateString = MyCalendar().weekDays[firstDayOfMonth.weekday - 1];
    paddingDays = MyCalendar().weekDays.indexOf(dateString);

    for (var i = 1; i <= paddingDays + daysInMonth; i++) {
      if (i > paddingDays) {
        days.add(dayWidget(i - paddingDays));
      } else {
        days.add(paddingDayWidget());
      }
    }

    setState(() {
      days = days;
    });
  }
}

class MyCalendar {
  List weekDays = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];
  List months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];


  MyCalendar();
}
