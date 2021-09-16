import 'package:bloc/bloc.dart';
import 'package:block_practice/data/models/characters.dart';
import 'package:block_practice/data/models/qoute.dart';
import 'package:block_practice/data/repositry/character_repositry.dart';
import 'package:meta/meta.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final CharacterRepositry characterRepositry;
  List<Character> characters = [];
  List<Quote> quotes=[];

  CharacterCubit(this.characterRepositry) : super(CharacterInitial());

  List<Character> getCharactersList() {
    characterRepositry.characterList().then((characters) {
      // start ui
      emit(CharactersLoaded(characters));
      this.characters = characters;
    });
    return characters;
  }

  void getQuotesList(String charName) {
    characterRepositry.quoteList(charName).then((quotes) {
      // start ui
      emit(QoutesLoaded(quotes));
    });
  }
}
