import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mool_task/data/model/user_response.dart';
import '../cubit/users/users_cubit.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<UsersCubit>();
      cubit.fetchAllUsers(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("All Users"),
      ),
      body: BlocBuilder<UsersCubit, UsersState>(builder: (context, state) {
        if (state is UsersSuccess) {
          final allUsers = state.allUsers;
          if (allUsers.isEmpty) {
            return const Center(
              child: Text(
                "No Users Found.",
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          return ListView.builder(
            itemCount: allUsers.length,
            itemBuilder: (context, index) {
              UserResponse user = allUsers[index];
              return buildUserCard(context, user);
            },
          );
        } else if (state is UsersFailed) {
          return const Center(
            child: Text("Error! Couldn't load.", style: TextStyle(color: Colors.white)),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }
      }),
    );
  }

  Widget buildUserCard(BuildContext context, UserResponse user) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
       child: Card(
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(20),
         ),
          color: Colors.lightGreen,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name: ${user.fullname}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Username: ${user.username}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),

    );
  }
}
