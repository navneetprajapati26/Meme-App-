import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:meme_app/model/memeModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class MemeProvider with ChangeNotifier {
  MemeModel? _meme;
  MemeModel? get meme => _meme!;
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


  Future<void> shareImage(String imageUrl) async {
    final tempDir = await getTemporaryDirectory();
    final file = await new File('${tempDir.path}/image.png').create();
    final response = await http.get(Uri.parse(imageUrl));
    await file.writeAsBytes(response.bodyBytes);
    await Share.shareFiles(
      [file.path],
      text: 'Check out this cool image!',
    );
    notifyListeners();
  }

}
