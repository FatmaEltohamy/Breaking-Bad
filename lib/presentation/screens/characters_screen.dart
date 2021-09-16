import 'package:block_practice/business_logic/character_cubit.dart';
import 'package:block_practice/constants/my_colors.dart';
import 'package:block_practice/data/models/characters.dart';
import 'package:block_practice/presentation/widgets/character_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  _CharactersScreenState createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharacters;
  List<Character> searchedList = [];
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharacterCubit>(context).getCharactersList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        title: _isSearching ? buildSearchField() : _buildAppbarTitle(),
        actions: _buildAppbarActions(),
        leading: _isSearching
            ? BackButton(
                color: MyColors.myGrey,
              )
            : Container(),
      ),
      body:
      // OfflineBuilder(
      //   child: showLoadingIndicator(),
      //   connectivityBuilder: (
      //     BuildContext context,
      //     ConnectivityResult connectivity,
      //     Widget child,
      //   ) {
      //     final bool connected = connectivity != ConnectivityResult.none;
      //     if (connected) {
      //       return buildBlocWidget();
      //     } else {
      //       return buildNoInternetWidget();
      //     }
      //   },
      // ),

      buildBlocWidget(),
    );
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharacterCubit, CharacterState>(
        builder: (context, state) {
      if (state is CharactersLoaded) {
        allCharacters = (state).characters;
        return buildLoadedListWidget();
      } else {
        return showLoadingIndicator();
      }
    });
  }

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [
            buildCharacretList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharacretList() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: _searchTextController.text.isEmpty
            ? allCharacters.length
            : searchedList.length,
        itemBuilder: (ctx, index) {
          //ToDo: not done
          return CharacterCard(
            character: _searchTextController.text.isEmpty
                ? allCharacters[index]
                : searchedList[index],
          );
        });
  }

  Widget showLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  Widget buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColors.myGrey,
      decoration: InputDecoration(
        hintText: 'Find A Character',
        hintStyle: TextStyle(
          color: MyColors.myGrey,
          fontSize: 20,
        ),
      ),
      style: TextStyle(
        color: MyColors.myGrey,
        fontSize: 20,
      ),
      onChanged: (searchedCharacter) {
        addSearchedItemsToSearchedList(searchedCharacter);
      },
    );
  }

  void addSearchedItemsToSearchedList(String searchedCharacter) {
    searchedList = allCharacters
        .where((character) =>
            character.name.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppbarActions() {
    if (_isSearching) {
      return [
        IconButton(
            onPressed: () {
              _clearSearch();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.clear,
              color: MyColors.myGrey,
            ))
      ];
    } else {
      return [
        IconButton(
            onPressed: _startSearch,
            icon: Icon(
              Icons.search,
              color: MyColors.myGrey,
            ))
      ];
    }
  }

  Widget _buildAppbarTitle() {
    return Text(
      'Characters',
      style: TextStyle(color: MyColors.myGrey),
    );
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearch));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        color: MyColors.myWhite,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Can\'t connect...check internet',
              style: TextStyle(fontSize: 22, color: MyColors.myGrey),
            ),
            Image.asset('assets/images/no_internet.svg'),
          ],
        ),
      ),
    );
  }
}
