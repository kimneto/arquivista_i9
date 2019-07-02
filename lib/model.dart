import 'dart:async';
import 'dart:convert';
import 'dart:io';
//import 'package:path_provider/path_provider.dart';

class Model {
  List prancheta = [];

  Future<File> pegaJson() async {
    final local = await Directory.current;
    return File("${local.path}/prancheta.json");
  }

  Future<File> salvarDados() async {
    String data = json.encode(prancheta);
    final arquivo = await pegaJson();
    return arquivo.writeAsString(data);
  }

  Future<String> pegarDados() async {
    try{
      final arquivo = await pegaJson();
      return arquivo.readAsString();
    }catch(e){print(e);return null;}
  }
}