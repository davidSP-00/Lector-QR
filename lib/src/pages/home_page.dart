import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_reader/src/bloc/scans_bloc.dart';

import 'package:qr_reader/src/pages/direcciones_page.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:qr_reader/src/providers/db_provider.dart';
import 'package:qr_reader/src/utils/utils.dart' as utils;

import 'mapas_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scansBloc = new ScansBloc();

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: [
          IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: () {
                scansBloc.borrarScanTODOS();
              })
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearBottonNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.filter_center_focus,
        ),
        onPressed: _scanQR,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  _scanQR() async {
    print('Scan....');
    // https://www.google.com.pe
    // geo:-11.96225141696142,-77.06820860346683

    String futureString = 'https://www.google.com.pe';

/*     try {
      futureString=await BarcodeScanner.scan();
    } catch (e) {
      futureString=e.toString();
    }

    print('futureString: '+ futureString);
    */
    if (futureString != null) {
      final scan = ScanModel(valor: futureString);

      scansBloc.agregarScan(scan);

      final scan2 =
          ScanModel(valor: 'geo:-11.96225141696142,-77.06820860346683');

      scansBloc.agregarScan(scan2);

      if(Platform.isIOS){
        Future.delayed(Duration(milliseconds: 750),(){
utils.abrirScan(context,scan);
        });
      }else{
utils.abrirScan(context,scan);
      }

      
    }
  }

  Widget _crearBottonNavigationBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.map), title: Text('Mapas')),
        BottomNavigationBarItem(
            icon: Icon(Icons.brightness_5), title: Text('Direcciones')),
      ],
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
          print(currentIndex);
        });
      },
    );
  }

  Widget _callPage(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return MapasPage();
      case 1:
        return DireccionesPage();

      default:
        return MapasPage();
    }
  }
}
