import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:elektra_fit/global/global-variables.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

import '../../global/global-models.dart';

class HomeService {
  BehaviorSubject<List<SpaGroupActivityMemberListModel>?> spaGroupActivityMember$ = BehaviorSubject.seeded(null);
  BehaviorSubject<List<SpaGroupActivityModel>?> spaGroupActivity$ = BehaviorSubject.seeded(null);

  Future<RequestResponse> spaGroupActivityTimetableList() async {
    spaGroupActivity$.add(null);
    final url = Uri.parse('https://4001.hoteladvisor.net');
    try {
      final response = await http.post(url,
          body: json.encode({
            "Action": "ApiSequence",
            "Object": "spaGroupActivityTimetableList",
            "Parameters": {"HOTELID": member$.value?.first.profile.hotelid}
          }));

      if (response.statusCode == 200) {
        final jsonData = json.decode(utf8.decode(response.bodyBytes));
        List<SpaGroupActivityModel> spaMember = [];

        for (var item in jsonData) {
          spaMember.add(SpaGroupActivityModel.fromJson(item));
        }
        spaGroupActivity$.add(spaMember);
        spaGroupActivity$.add(spaGroupActivity$.value);
      }

      return RequestResponse(message: utf8.decode(response.bodyBytes).tr(), result: true);
    } catch (e) {
      print(e);
      return RequestResponse(message: e.toString(), result: false);
    }
  }

  Future<RequestResponse> spaGroupActivityTimetableMembersList() async {
    spaGroupActivityMember$.add(null);
    final url = Uri.parse('https://4001.hoteladvisor.net');
    try {
      final response = await http.post(url,
          body: json.encode({
            "Action": "ApiSequence",
            "Object": "spaGroupActivityTimetableMembersList",
            "Parameters": {"HOTELID": member$.value?.first.profile.hotelid}
          }));

      if (response.statusCode == 200) {
        final jsonData = json.decode(utf8.decode(response.bodyBytes));
        List<SpaGroupActivityMemberListModel> spaGroupMember = [];

        for (var item in jsonData) {
          spaGroupMember.add(SpaGroupActivityMemberListModel.fromJson(item));
        }
        spaGroupActivityMember$.add(spaGroupMember);
        spaGroupActivityMember$.add(spaGroupActivityMember$.value);
      }

      return RequestResponse(message: utf8.decode(response.bodyBytes).tr(), result: true);
    } catch (e) {
      print(e);
      return RequestResponse(message: e.toString(), result: false);
    }
  }
}
