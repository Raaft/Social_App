import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/cubit/login_cubit/cubit.dart';
import 'package:socialapp/cubit/social_cubit/cubit.dart';
import 'package:socialapp/cubit/social_cubit/states.dart';
import 'package:socialapp/models/user_model.dart';
import 'package:socialapp/shared/componnatnts.dart';

import '../chatditails_Screen.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => SocialLogInCubit(),
        child: BlocConsumer<SocialCubit, SocialStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = SocialCubit.get(context);

              return ListView.builder(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                itemBuilder: (context, index) =>
                    chatIItem(context, cubit.users[index], cubit),
                itemCount: cubit.users.length,
              );
            }));
  }

  Widget chatIItem(
      BuildContext context, SocialUserModel model, SocialCubit cubit) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: InkWell(
        onTap: () {
          cubit.getMessages(receiverId: model.uId).then((value) {
            navigateTo(context, ChatDetailsScreen(userModel: model));
          });
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(model.image.toString()),
              radius: 28,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(model.name.toString(),
                          style: Theme.of(context).textTheme.bodyText1),
                      SizedBox(
                        width: 7,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
