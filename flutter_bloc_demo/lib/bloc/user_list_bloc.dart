import 'dart:async';

import 'package:flutter_bloc_demo/bloc/base_bloc.dart';
import 'package:flutter_bloc_demo/modals/response/Data.dart';
import 'package:flutter_bloc_demo/rest/rest_api_calls.dart';

class UserListBloc with BaseBloc {
  // 1
  final _getUserController = StreamController<List<Data>>.broadcast();

  // 2
  Stream<List<Data>> get userStream => _getUserController.stream;

  // 3
  StreamSink<List<Data>> get userSink => _getUserController.sink;

  // 4
  StreamSubscription<List<Data>> get userSubscriptionSubscription =>
      userStream.listen((event) {});

  getUserList() {
    RestApiCalls apiCalls = RestApiCalls();

    apiCalls.getUsersList().then((value) {
      userSink.add(value.data);
    }).catchError((error) {
      userSink.addError(error.toString());
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _getUserController.close();
  }
}
