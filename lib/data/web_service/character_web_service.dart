import 'package:block_practice/constants/strings.dart';
import 'package:block_practice/data/models/characters.dart';
import 'package:dio/dio.dart';

class CharactersWebService {
 late Dio dio;

  CharactersWebService() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 100,
    );
    dio = Dio(baseOptions);
    dio.interceptors.add(LogInterceptor(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
    ));
  }
  //method to get all characters from api (convert json object  to list of character model)
Future<List<dynamic>> getAllCharacters() async{
    try{
      Response response=await dio.get('characters');
      print(response.data.toString());
      return response.data;
    }
    catch(e){
      print(e.toString());
      return [];
    }

}
  Future<List<dynamic>> getAllQuotes(String charName) async{
    try{
      Response response=await dio.get('quote', queryParameters: {'author':charName});
      print(response.data.toString());
      return response.data;
    }
    catch(e){
      print('error*****');
      print(e.toString());
      return [];
    }

  }
}
