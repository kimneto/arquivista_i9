import 'dart:ffi';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:dart/model.dart';
import 'dart:convert';

class Carteiro {
  List<dynamic> dadosJson = List();
  Model banco = Model();
  List jsons = [];

  gravaOrigemDestino({Directory orig, Directory dest}) {
    //Lista de Arquivos
    List listaorigem = orig.listSync();

    //Lista final
    for (var arqePastas in listaorigem) {
      if (arqePastas is File) {
        Map<String, dynamic> novoArquivo = Map();
        novoArquivo["nome"] = p.basename(arqePastas.path);
        novoArquivo["origem"] = p.dirname(arqePastas.path).toString();
        novoArquivo["destino"] = dest.path;
        jsons.add(novoArquivo);

        /* //Move para pasta
        print(dest.path);
        arqePastas.rename(dest.path+"//"+p.basename(arqePastas.path));
        //_moveArquivo(arqePastas, dest.path);//"c:\\alvo\\dest\\" + p.basename(arqePastas.path)
       */
      }
    }
    banco.prancheta.add(jsons);
    banco.salvarDados();
    //print(map.toString());
  }

  moveArquivo() async {
    dadosJson = json.decode(await banco.pegarDados());
    File arquivo;
    print("Movimentando arquivos para o destino");

    for (int i = 0; i < dadosJson.length; i++) {
      arquivo = File(dadosJson[i]["origem"] + "\\" + dadosJson[i]["nome"]);
      await arquivo.rename(dadosJson[i]["destino"] + "\\" + dadosJson[i]["nome"]);
      print(dadosJson[i]["nome"]);
     
    }
  }

  devolveArquivo() async{
    dadosJson = json.decode(await banco.pegarDados());
    File arquivo;
    print("Movimentando arquivos para a origem");

    for (int i = 0; i < dadosJson.length; i++) {
      arquivo = File(dadosJson[i]["destino"] + "\\" + dadosJson[i]["nome"]);
      await arquivo.rename(dadosJson[i]["origem"] + "\\" + dadosJson[i]["nome"]);
      print(dadosJson[i]["nome"]);
     
    }

  }
}
