import 'dart:io';
import 'package:path/path.dart' as p;
import 'model.dart';

void main() {
  
  
  Model banco = Model();

  Map<String, dynamic> novoArquivo = Map();

  novoArquivo["nome"] = "porno.vid";
  novoArquivo["origem"] = "porno.vid";
  novoArquivo["destino"] = "porno.vid";
  banco.prancheta.add(novoArquivo);
  banco.salvarDados();
  banco.prancheta.add(novoArquivo);
  banco.salvarDados();
  banco.prancheta.add(novoArquivo);
  banco.salvarDados();


  
  
  //PASTA DESTINO
  final pasta = Directory("c:\\alvo\\");

  print("-----------------*------------------");
  List contents = pasta.listSync();
  for (var fileOrDir in contents) {
    if (fileOrDir is File) {

      novoArquivo["nome"] = p.basename(fileOrDir.path);

      
     
      if (fileOrDir.path.contains('@') == true){
        print("Documentos Possivelmente Assinados Detectado");
        print(fileOrDir.path);
      
       moveArquivo(fileOrDir, "c:\\alvo\\dest\\"+p.basename(fileOrDir.path));
       var levajunto = (fileOrDir.path).replaceAll(RegExp('@'), '');
     
          for (var fileOrDir2 in contents) {
            if (fileOrDir2.path.contains(levajunto) == true){
              moveArquivo(fileOrDir2, "c:\\alvo\\dest\\"+p.basename(fileOrDir2.path));
            }
          }
  
      }
      
    }
  }
}



//Funcao move arquivo
Future<File> moveArquivo(File sourceFile, String newPath) async {
  try {
    // prefer using rename as it is probably faster
    return await sourceFile.rename(newPath);
  } on FileSystemException catch (e) {
    // if rename fails, copy the source file and then delete it
    final newFile = await sourceFile.copy(newPath);
    await sourceFile.delete();
    return newFile;
  }
  
}