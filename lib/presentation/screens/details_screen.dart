import 'dart:math';

import 'package:block_practice/business_logic/character_cubit.dart';
import 'package:block_practice/constants/my_colors.dart';
import 'package:block_practice/data/models/characters.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class DetailsCharacterScreen extends StatelessWidget {
  final Character character;



  const DetailsCharacterScreen({Key? key, required this.character,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharacterCubit>(context).getQuotesList(character.name);
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppbar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    characterInfo(
                      'Job : ',
                      character.occupation.join(' / '),
                    ),
                    buildDivider(332),
                    characterInfo(
                      'Appeared in : ',
                      character.categoryForTwoSeries,
                    ),
                    buildDivider(266),
                    characterInfo(
                      'Seasons : ',
                      character.apperance.join(' / '),
                    ),
                    buildDivider(290),
                    characterInfo(
                      'Status : ',
                      character.statusAliveOrDeath,
                    ),
                    buildDivider(305),
                    character.betterCallSaulApperance.isEmpty
                        ? Container()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              characterInfo(
                                'Better call saul seasons : ',
                                character.betterCallSaulApperance.join(' / '),
                              ),
                              buildDivider(160),
                            ],
                          ),
                    SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<CharacterCubit, CharacterState>(
                        builder: (context, state) {
                      return checkIfQouteIsLoaded(state);
                    }),
                  ],
                ),
              ),
              SizedBox(
                height: 500,
              )
            ]),
          )
        ],
      ),
    );
  }

  Widget buildSliverAppbar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        //centerTitle: true,
        title: Text(
          '${character.nickname}',
          style: TextStyle(
            color: MyColors.myWhite,
          ),
          //textAlign: TextAlign.start,
        ),
        background: Hero(
          tag: character.charId,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(children: [
          TextSpan(
              text: title,
              style: TextStyle(
                color: MyColors.myWhite,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
          TextSpan(
            text: value,
            style: TextStyle(
              color: MyColors.myWhite,
              fontSize: 16,
            ),
          ),
        ]));
  }

  Widget checkIfQouteIsLoaded(CharacterState state) {
    if (state is QoutesLoaded) {
      print(state);
      print('ssssssssssssssssssssss');
      return displayRandomQouteOrEmptySpace(state);
    } else {
      print(state);
      print('ssssssssssssssssssssss');
      return showProgressIndicator();
    }
  }

  Widget displayRandomQouteOrEmptySpace(QoutesLoaded state) {
    var quotes = (state).quotes;
    quotes.forEach((element) {
      print(element.quote);
    });
    print('yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
    if (quotes.length != 0) {
      int randomIndex = Random().nextInt(quotes.length - 1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: MyColors.myWhite,
            shadows: [
              Shadow(
                blurRadius: 7,
                color: MyColors.myYellow,
                offset: Offset(0, 0),
              )
            ],
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(quotes[randomIndex].quote),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget showProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }
}

Widget buildDivider(double endIndent) {
  return Divider(
    height: 30,
    color: MyColors.myYellow,
    endIndent: endIndent,
    thickness: 2,
  );
}
