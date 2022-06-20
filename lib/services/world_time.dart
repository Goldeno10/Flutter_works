import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; //location name for the ui
  late String time; // the time in thatlocation
  String flag; // A url to an asset flag icon
  String url; //this is the locsation url for api end point
  late bool isDaytime; //true or false if daytime or not

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      Uri urls = Uri.https('worldtimeapi.org', '/api/timezone/$url');
      Response response = await get(urls);
      Map data = jsonDecode(response.body);
      //print(data);

      // get proerties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      //print(datetime);
      //print(offset);

      // create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      //print('Now =>> $now');
      //set time property
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('Cought error ==>> $e');
      time = 'Could not get time data';
    }
  }
}
