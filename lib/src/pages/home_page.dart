import 'package:flutter/material.dart';
import 'package:qr_reader/src/pages/direcciones_page.dart';

import 'mapas_page.dart';


class HomePage extends StatefulWidget {
  
 
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('QR Scanner'),
      actions: [
        IconButton(icon: Icon(Icons.delete_forever), onPressed: (){})
      ],),
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearBottonNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: (){},
      ),
    );
  }

 Widget _crearBottonNavigationBar() {

   return BottomNavigationBar(
     items: [
       BottomNavigationBarItem(
         icon: Icon(Icons.map),
         title: Text('Mapas')
       ),
       BottomNavigationBarItem(
         icon: Icon(Icons.brightness_5),
         title: Text('Direcciones')
       ),
       
      
     ],
     currentIndex:currentIndex,
     onTap: (index){
       setState(() {
         currentIndex=index;
         print(currentIndex);
       });
     },
   );
 }

 Widget _callPage(int paginaActual) {
switch(paginaActual){
  case 0:return MapasPage();
  case 1:return DireccionesPage();

  default: return MapasPage();
}

 }
}