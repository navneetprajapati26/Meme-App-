import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:meme_app/model/memeModel.dart';

class MemeProvider with ChangeNotifier {
  MemeModel? _meme;
  MemeModel get meme => _meme!;

  late String memeUrl;

  final String memeApi = "https://meme-api.com/gimme";
  Future<void> getMeme() async {
    final response = await http.get(Uri.parse(memeApi));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      _meme = MemeModel.fromJson(json);
      memeUrl = _meme!.url!;
      notifyListeners();
    } else {
      throw Exception('Failed to load meme');
    }
  }



  List<String> _memelist = [];
  List<String> get memelist => _memelist;

  void addMemeUrlInList(){
    _memelist.add(memeUrl);
    notifyListeners();
  }

}
