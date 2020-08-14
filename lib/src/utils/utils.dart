import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';



import 'package:qr_reader/src/models/scan_model.dart';

abrirScan(BuildContext context,ScanModel scanModel) async {
  if(scanModel.tipo=='http'){


  
  if (await canLaunch(scanModel.valor)) {
    await launch(scanModel.valor);
  } else {

    throw 'No se puede abrir ${scanModel.valor}';
  }
  }else{
    Navigator.pushNamed(context, 'mapa',arguments: scanModel);
    print('Codigo de GEO');
  }
}

