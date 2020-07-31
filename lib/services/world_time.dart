import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class WorldTime {

  String location; // Location name for the UI
  String time; // The time in the location
  String flag; // Url to an asset flag icon
  String url; // This is the location url for API end-point
  bool isDaytime; // True or False day-time or not

  WorldTime({ this.location , this.flag , this.url });

  Future<void> getTime() async {
    try {
      // Make request
      Response response = await get(
          'http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      //print(data);

      // Get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      //print(datetime);
      //print(offset);

      // Create date-time object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // Set time property
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }

    catch (e) {
      time = 'Could not get the Time !!!!';
    }
  }
}

