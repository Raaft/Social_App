import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/cubit/social_cubit/cubit.dart';
import 'package:socialapp/cubit/social_cubit/states.dart';
import 'package:socialapp/shared/componnatnts.dart';
import 'package:socialapp/shared/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var textController = TextEditingController();
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SocialCubit.get(context);

          return Scaffold(
            appBar:
                defaultAppBar(context: context, title: ' Crate Post', actions: [
              defaultTextButton(
                  function: () {
                    if (cubit.postImage == null) {
                      cubit.createNewPost(
                          text: textController.text.toString(),
                          dateTime: DateTime.now().toString());
                    } else {
                      cubit.upLoadPostImage(
                          text: textController.text,
                          dateTime: DateTime.now().toString());
                    }
                  },
                  text: "Post")
            ]),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (state is SocialCreatePostLoadingState)
                    LinearProgressIndicator(),
                  SizedBox(height: 15),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(cubit.userModel.image),
                        radius: 30,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(cubit.userModel.name,
                            style: Theme.of(context).textTheme.bodyText1),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Expanded(
                      child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                        hintText: ' What is on your mind ...',
                        border: InputBorder.none),
                  )),
                  SizedBox(height: 15),
                  if (cubit.postImage != null)
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          height: 250,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                4.0,
                              ),
                              topRight: Radius.circular(
                                4.0,
                              ),
                            ),
                            image: DecorationImage(
                              image: FileImage(cubit.postImage),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: CircleAvatar(
                            radius: 20.0,
                            child: Icon(
                              Icons.close,
                              size: 16.0,
                            ),
                          ),
                          onPressed: () {
                            SocialCubit.get(context).closeImage();
                          },
                        ),
                      ],
                    ),
                  SizedBox(height: 15),
                  TextButton(
                      onPressed: () {
                        cubit.getPostImage();
                      },
                      child: Row(
                        children: [
                          Icon(IconBroken.Image),
                          SizedBox(width: 5),
                          Text('Add photo')
                        ],
                      ))
                ],
              ),
            ),
          );
        });
  }
}
