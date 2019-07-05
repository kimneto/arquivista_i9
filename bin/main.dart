import 'dart:io';
import 'carteiro.dart';

void main() {
  final origem = Directory('c:\\alvo\\origem');
  final destino = Directory('c:\\alvo\\dest');
  Carteiro c = Carteiro();

  //c.gravaOrigemDestino(dest: destino, orig: origem);
  
  c.moveArquivo();
     
}
