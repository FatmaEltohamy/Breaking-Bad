import 'package:block_practice/data/models/characters.dart';
import 'package:block_practice/data/models/qoute.dart';
import 'package:block_practice/data/web_service/character_web_service.dart';

class CharacterRepositry{
  CharactersWebService charactersWebService;

  CharacterRepositry(this.charactersWebService);
  Future<List<Character>> characterList () async{
  final characters= await charactersWebService.getAllCharacters();
  return characters.map((character) => Character.fromJson(character)).toList();
  }

  Future<List<Quote>> quoteList (String charName) async{
    final quotes= await charactersWebService.getAllQuotes(charName);
    return quotes.map((quote) => Quote.fromJson(quote)).toList();
  }
}