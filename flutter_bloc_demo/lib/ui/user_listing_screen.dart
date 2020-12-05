import 'package:flutter/material.dart';
import 'package:flutter_bloc_demo/bloc/user_list_bloc.dart';
import 'package:flutter_bloc_demo/modals/response/Data.dart';

class UserListingScreen extends StatefulWidget {
  @override
  _UserListingScreenState createState() => _UserListingScreenState();
}

class _UserListingScreenState extends State<UserListingScreen> {
  UserListBloc userListBloc;

  @override
  void initState() {
    super.initState();

    if (mounted) {
      userListBloc = UserListBloc();
      userListBloc.getUserList();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    userListBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User List"),
      ),
      body: StreamBuilder<List<Data>>(
          stream: userListBloc.userStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (buildContext, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                NetworkImage(snapshot.data[index].avatar),
                          ),
                          title: Text(snapshot.data[index].first_name),
                          subtitle: Text(snapshot.data[index].email),
                        ),
                      );
                    }),
              );
            } else if (snapshot.hasError) {
              return Container(
                child: Text(snapshot.error.toString()),
              );
            } else {
              // Showing Progress
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
