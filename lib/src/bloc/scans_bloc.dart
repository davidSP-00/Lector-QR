

import 'dart:async';

import 'package:qr_reader/src/bloc/validator.dart';
import 'package:qr_reader/src/providers/db_provider.dart';

class ScansBloc with Validators {

  static final ScansBloc _singleton=new ScansBloc._internal();

  factory ScansBloc(){
    return _singleton;
  }

  ScansBloc._internal(){
    //Obtener Scans de la Base de datos



  }


final _scansController =StreamController<List<ScanModel>>.broadcast();

Stream<List<ScanModel>> get scansStream     =>_scansController.stream.transform(validarGeo);
Stream<List<ScanModel>> get scansStreamHttp =>_scansController.stream.transform(validarHttp);

dispose(){

  _scansController?.close();
}



obtenerScans() async {
  _scansController.sink.add(await DBProvider.db.getTodosScans());
}

agregarScan(ScanModel scan) async {

await DBProvider.db.nuevoScan(scan);

obtenerScans();

}

borrarScan(int id) async{
  await DBProvider.db.deleteScan(id);

obtenerScans();

}

borrarScanTODOS() async{
await DBProvider.db.deleteAll();

_scansController.sink.add([]);

}
inicializarScan() async{

_scansController.sink.add( await []);

}
}

