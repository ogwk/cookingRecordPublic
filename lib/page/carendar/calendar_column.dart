import 'package:cooking_record/extension/date_time_ex.dart';
import 'package:cooking_record/model/record.dart';
import 'package:cooking_record/page/carendar/calendar_view_model.dart';
import 'package:cooking_record/page/record/edit_record.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarColumn extends StatefulWidget {
  const CalendarColumn(this.viewModel, {Key? key}) : super(key: key);
  final CalendarViewModel viewModel;

  @override
  State<CalendarColumn> createState() => _CalendarColumnState();
}

class _CalendarColumnState extends State<CalendarColumn> {
  //表示カレンダーの最終日
  final dateTimeAfter = DateTime.now().getAfterYear(5);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildTableCalendar(),
        const SizedBox(
          height: 30.0,
        ),
        ListView(
          shrinkWrap: true,
          children: widget.viewModel
              .getRecord(widget.viewModel.selectedDay!)
              .map((record) => Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 8.0),
                    child: ListTile(
                      title: Text(record.title.toString()),
                      leading: Icon(Icons.done,
                          color:
                              record.isDone ? Colors.red : Colors.transparent),
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10.0)),
                      onTap: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditRecordPage(record)));
                        //カレンダーのレコードデータ再読み込み
                        await widget.viewModel.getMyRecords();
                        await widget.viewModel.addRecords();
                        setState(() {});
                      },
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  TableCalendar<dynamic> buildTableCalendar() {
    return TableCalendar(
      headerStyle: const HeaderStyle(
        titleCentered: true, //タイトルを中央にするか
        formatButtonVisible: false, //週に絞り込みボタン非表示
      ),
      //曜日表記の高さ
      daysOfWeekHeight: 40,
      //  日付セルの高さ
      rowHeight: 52,
      locale: 'ja_JP',
      //  始まりの日
      firstDay: DateTime(2022, 1, 1),
      //  終わりの日
      lastDay: dateTimeAfter,
      focusedDay: widget.viewModel.focusedDay,
      eventLoader: widget.viewModel.getRecord,
      //  カレンダーデザイン
      calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          tablePadding: const EdgeInsets.all(20.0),
          isTodayHighlighted: true,
          tableBorder: TableBorder.symmetric(
            inside: BorderSide(color: Colors.grey.withOpacity(0.4)),
          )),
      selectedDayPredicate: (day) {
        return isSameDay(widget.viewModel.selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(widget.viewModel.selectedDay, selectedDay)) {
          setState(() {
            widget.viewModel.setSelectedDay = selectedDay;
            widget.viewModel.setFocusedDay = focusedDay;
          });
        }
      },
      onPageChanged: (focusedDay) {
        widget.viewModel.setFocusedDay = focusedDay;
        setState(() {});
      },
      calendarBuilders: _calendarBuilders(),
    );
  }

  CalendarBuilders<dynamic> _calendarBuilders() {
    return CalendarBuilders(dowBuilder: (BuildContext context, DateTime day) {
      String weekDayName = _engWeekday(day);
      Color weekDayColor = _weekdayColor(day);
      return Center(
        child: Text(
          weekDayName,
          style: TextStyle(color: weekDayColor, fontSize: 12),
        ),
      );
    }, todayBuilder: (BuildContext context, DateTime day, DateTime focusedDay) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: EdgeInsets.zero,
        alignment: Alignment.center,
        child: Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red,
          ),
          child: Text(
            day.day.toString(),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
    }, defaultBuilder:
        (BuildContext context, DateTime day, DateTime focusedDay) {
      Color weekDayColor = _weekdayColor(day);

      return AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: EdgeInsets.zero,
        alignment: Alignment.center,
        child: Text(
          day.day.toString(),
          style: TextStyle(
            color: weekDayColor,
          ),
        ),
      );
    }, selectedBuilder:
        (BuildContext context, DateTime day, DateTime focusedDay) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: EdgeInsets.zero,
        alignment: Alignment.center,
        child: Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey,
          ),
          child: Text(
            day.day.toString(),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
    }, markerBuilder:
        (BuildContext context, DateTime day, List<dynamic> eventList) {
      if (eventList.isEmpty) return null;
      return Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Wrap(
          children: eventList.map((e) => _eventMark(e)).toList(),
        ),
      );
    });
  }

  String _engWeekday(DateTime day) {
    switch (day.weekday) {
      case 1:
        return "MON";
      case 2:
        return "TUE";
      case 3:
        return "WEN";
      case 4:
        return "THU";
      case 5:
        return "FRI";
      case 6:
        return "SAT";
      case 7:
        return "SUN";
      default:
        return "";
    }
  }

  Color _weekdayColor(DateTime day) {
    if (day.weekday == 6) {
      return Colors.blue;
    } else if (day.weekday == 7) {
      return Colors.red;
    } else {
      return Colors.black87;
    }
  }

  Icon _eventMark(Record record) {
    return (record.isDone == true) ? const Icon(Icons.done,color: Colors.red,size: 12,)
    : const Icon(Icons.star,color: Colors.grey,size: 12,);

  }
}
