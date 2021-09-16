import 'package:block_practice/business_logic/character_cubit.dart';
import 'package:block_practice/data/models/characters.dart';
import 'package:block_practice/data/web_service/character_web_service.dart';
import 'package:block_practice/presentation/screens/characters_screen.dart';
import 'package:block_practice/presentation/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'data/repositry/character_repositry.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  late CharacterRepositry characterRepositry;
  late CharacterCubit characterCubit;

  AppRouter() {
    characterRepositry = CharacterRepositry(CharactersWebService());
    characterCubit = CharacterCubit(characterRepositry);
  }

  Route? generateRout(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => characterCubit,
                  child: CharactersScreen(),
                ));
      case 'details_screen':
        final character = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => CharacterCubit(CharacterRepositry(CharactersWebService())),
            child: DetailsCharacterScreen(character: character),
          ),
        );
    }
  }
}
