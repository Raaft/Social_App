import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialapp/Screens/login_Screen.dart';
import 'package:socialapp/Screens/navBar/newpost_screen.dart';
import 'package:socialapp/cubit/social_cubit/cubit.dart';
import 'package:socialapp/cubit/social_cubit/states.dart';
import 'package:socialapp/network/chash_helper.dart';
import 'package:socialapp/shared/componnatnts.dart';
import 'package:socialapp/shared/icon_broken.dart';

class LayOutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(listener: (context, state) {
    /*  if (state is SocialInitialState ||
          state is SocialChangeBottomNavState ||
          state is SocialGetUserLoadingState) {
        SocialCubit.get(context).getUserData();
      }*/

      if (state is SocialNewPostState) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => NewPostScreen()));
      }
    }, builder: (context, state) {
      var cubit = SocialCubit.get(context);

      return Scaffold(
        appBar: AppBar(
          title: Text(cubit.titles[cubit.currentIndex]),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(IconBroken.Search)),
            IconButton(
                onPressed: () {
                  cubit.logOut().then((value) {
                    uId = '';
                    CacheHelper.clearData(key: 'uId');
                    navigateTo(context, LoginScreen());
                  });
                },
                icon: Icon(IconBroken.Logout)),
          ],
        ),
        body: cubit.screens[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: cubit.currentIndex,
          onTap: (index) {
            cubit.changeBottomNav(index);
          },
          items: [
            BottomNavigationBarItem(icon: Icon(IconBroken.Home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(IconBroken.Chat), label: "Chat"),
            BottomNavigationBarItem(
                icon: Icon(IconBroken.Paper_Upload), label: "Post"),
            BottomNavigationBarItem(
                icon: Icon(IconBroken.Location), label: "Users"),
            BottomNavigationBarItem(
                icon: Icon(IconBroken.Setting), label: "Settings"),
          ],
        ),
      );
    });
  }
}
