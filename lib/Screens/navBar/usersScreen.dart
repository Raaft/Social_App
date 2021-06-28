import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/cubit/social_cubit/cubit.dart';
import 'package:socialapp/cubit/social_cubit/states.dart';
import 'package:socialapp/shared/componnatnts.dart';

class UsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: height / 3.7,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: height / 5.1,
                          width: width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      cubit.userModel.cover),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        radius: 63,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              cubit.userModel.image),
                          radius: 60,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(cubit.userModel.name,
                    style: Theme.of(context).textTheme.bodyText1),
                Text(cubit.userModel.bio, style: Theme.of(context).textTheme.caption),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Column(children: [
                          Text("100",
                              style: Theme.of(context).textTheme.subtitle1),
                          Text("posts",
                              style: Theme.of(context).textTheme.caption),
                        ]),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Column(children: [
                          Text("100",
                              style: Theme.of(context).textTheme.subtitle1),
                          Text("potos",
                              style: Theme.of(context).textTheme.caption),
                        ]),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Column(children: [
                          Text("100",
                              style: Theme.of(context).textTheme.subtitle1),
                          Text("Videos",
                              style: Theme.of(context).textTheme.caption),
                        ]),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                defaultButton(
                    function: () {},
                    radius: 5,
                    text: 'EDIT PROFILE',
                    width: width / 1.2)
              ],
            ),
          );
        });
  }
}
