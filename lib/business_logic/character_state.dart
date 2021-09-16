part of 'character_cubit.dart';

@immutable
abstract class CharacterState {}

class CharacterInitial extends CharacterState {

}
class CharactersLoaded extends CharacterState{
  final List<Character> characters;
  CharactersLoaded(this.characters);
}

class QoutesLoaded extends CharacterState{
  late final List<Quote> quotes;
  QoutesLoaded(this.quotes);
}