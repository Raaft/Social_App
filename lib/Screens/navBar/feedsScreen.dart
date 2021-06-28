import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/cubit/social_cubit/cubit.dart';
import 'package:socialapp/cubit/social_cubit/states.dart';
import 'package:socialapp/models/post_model.dart';
import 'package:socialapp/shared/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {
        //  SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[])
        },
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          return (cubit.posts.length == 0)
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 10,
                        margin:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Image(
                              image: NetworkImage(
                                  "https://expertphotography.com/wp-content/uploads/2020/05/photo-of-woman-wearing-yellow.jpg"),
                              fit: BoxFit.cover,
                              height: height / 4,
                              width: width,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Communicate with your friends',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                      ListView.builder(
                        itemBuilder: (context, index) => createPost(
                            context, height, width, cubit.posts[index], cubit,index),
                        itemCount: cubit.posts.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                      )
                    ],
                  ),
                );
        });
  }

  Card createPost(
      BuildContext context, double height, double width, PostModel model,SocialCubit cubit,index) {
    return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10,
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(model.image),
                    radius: 28,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(model.name,
                                style: Theme.of(context).textTheme.bodyText1),
                            SizedBox(
                              width: 7,
                            ),

                          ],
                        ),
                        Text(
                          model.dateTime,
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(height: 1.4),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 15),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_horiz,
                        size: 16,
                      ))
                ],
              ),
              Divider(),
              Text(
                model.text,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(height: 10),
              if (model.postImage != "")
                Container(
                  height: height / 3.9,
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          image: NetworkImage(
                              model.postImage),
                          fit: BoxFit.cover)),
                ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {

                      },
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Heart,
                            color: Colors.red,
                          ),
                          Text('${cubit.likes[index]}',
                              style: Theme.of(context).textTheme.caption)
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Chat,
                            color: Colors.amber,
                          ),
                          Text("0 comments",
                              style: Theme.of(context).textTheme.caption)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        cubit.userModel.image   ),
                    radius: 20,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Text("write a comment ... ",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              .copyWith(color: Colors.grey)),
                    ),
                  ),
                  TextButton(
                    onPressed: (){cubit.likePost(SocialCubit.get(context).postsId[index]);},
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          color: Colors.red,
                        ),
                        Text("like",
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(fontSize: 15))
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
