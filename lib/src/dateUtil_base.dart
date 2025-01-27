// Copyright (c) 2018, Adetu Ridwan and Egbesola Anthony.
import 'dart:io';
import 'dart:core';

/// A date utility interface to get every information of dates, months, weeks and year taking leap
/// year into consideration.
class DateUtil {
  var dayOfWeek = 0;
  int yearLength(int year) {
    var yearLength = 0;
    for (int counter = 1; counter < year; counter++) {
      if (counter >= 4) {
        if (leapYear(counter) == true)
          yearLength += 366;
        else
          yearLength += 365;
      } else
        yearLength += 365;
    }
    return yearLength;
  }

  String? day(int length) {
    final day = <String>[
      'Saturday',
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday'
    ];

    var count = 0;
    String? resultDay;

    for (var counter = 1; counter <= length; counter++) {
      final check = ((counter > 639798) && (counter < 639811));
      if (check == true) {
      } else {
        if (count >= 7) {
          if (count % 7 == 0) count = 0;
        }
        resultDay = day[count];
        count++;
      }
    }
    if (count == 1)
      dayOfWeek = 7;
    else
      dayOfWeek = (count - 1);
    return resultDay;
  }

  String month(final int monthNum) {
    final month = <String>[
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
    return month[monthNum - 1];
  }

  int daysInMonth(final int monthNum, final int year) {
    switch (monthNum) {
      case 0:
      case 2:
      case 4:
      case 6:
      case 7:
      case 9:
      case 11:
        return 31;

      case 3:
      case 5:
      case 8:
      case 10:
        return 30;

      case 1:
        return leapYear(year) ? 29 : 28;

      default:
        throw RangeError.range(monthNum, 0, 11);
    }
  }

  int daysPastInYear(final int monthNum, final int dayNum, final int year) {
    var totalMonthLength = 0;

    for (var count = 1; count < monthNum; count++) {
      totalMonthLength += daysInMonth(count, year);
    }

    var monthLengthTotal = totalMonthLength + dayNum;

    return monthLengthTotal;
  }

  totalLengthOfDays(final int monthNum, final int dayNum, final int year) =>
      daysPastInYear(monthNum, dayNum, year) + yearLength(year);

  void printMonthCalendar(final int monthNum, final int year) {
    int dayNum = 1;
    final str_Day = <String>['Sun', 'Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat'];
    day(daysPastInYear(monthNum, 1, year) + yearLength(year));
    int dayDays = 1;

    for (int i = 0; i < 7; i++) {
      stdout.write('${str_Day[i]}\t');
    }
    stdout.writeln();

    for (int i = 1; i <= 6; i++) {
      for (int j = 1; j <= 7; j++) {
        if (dayNum >= dayOfWeek) {
          if (dayDays <= daysInMonth(monthNum, year)) {
            stdout.write('${dayDays}\t');
          }
          ++dayDays;
        } else if (dayNum < dayOfWeek) stdout.write('\t');

        dayNum++;
      }
      stdout.writeln();
    }
  }

  int getWeek(int monthNum, int dayNum, int year) {
    double a = (daysPastInYear(monthNum, dayNum, year) / 7) + 1;
    return a.toInt();
  }

  bool leapYear(int year) {
    bool leapYear = false;

    bool leap = ((year % 100 == 0) && (year % 400 != 0));
    if (leap == true)
      leapYear = false;
    else if (year % 4 == 0) leapYear = true;

    return leapYear;
  }
}
