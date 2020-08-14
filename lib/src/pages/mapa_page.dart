import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';



import 'package:qr_reader/src/models/scan_model.dart';


class MapaPage extends StatefulWidget {

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final MapController map=new MapController();

  String tipoMapa='mapbox-traffic-v1';

  @override
  Widget build(BuildContext context) {

    final ScanModel scan=ModalRoute.of(context).settings.arguments;

    return Scaffold(
          appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: [
          IconButton(icon: Icon(Icons.my_location), onPressed: (){
            map.move(scan.getLatLng(), 15);
          })
        ],
      ),
      body:_crearFlutterMap(scan),
      floatingActionButton: _crearBotonFlotante(context),
    );
  }

  Widget _crearBotonFlotante(BuildContext context){

    return FloatingActionButton(
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: (){
        if(tipoMapa=='satellite'){
          tipoMapa='mapbox-traffic-v1';
          
        }else{
        tipoMapa='satellite';
        }
        setState(() {
          
        });

      },
    );
  }

  Widget _crearFlutterMap(ScanModel scan){

return FlutterMap(
  mapController: map,
  options: MapOptions(
    center: scan.getLatLng(),
    zoom: 15
  ),
  layers: [
    _crearMapa(),
    _crearMarcadores(scan)
      ],
    );
      }

    _crearMapa(){
    return TileLayerOptions(
      urlTemplate: "https://api.mapbox.com/v4/{id}/{z}/{x}/{y}@2x.png?access_token=pk.eyJ1IjoiZGF2aWRzcDAwIiwiYSI6ImNrZHVlaWV1NTAwYTEycm54dHljN3JpbGUifQ.gddx_frurF4JNyZPx5AglQ",
      additionalOptions: {
        'accessToken':'pk.eyJ1IjoiZGF2aWRzcDAwIiwiYSI6ImNrZHVlaWV1NTAwYTEycm54dHljN3JpbGUifQ.gddx_frurF4JNyZPx5AglQ',
        'id':'mapbox.$tipoMapa'
      }
    );
    
    }

      _crearMarcadores(ScanModel scan) {

        return MarkerLayerOptions(
          markers: [
            Marker(
              width: 100.0,
              height: 100.0,
              point: scan.getLatLng(),
              builder: (context){
                return Container(
                  child: Icon(Icons.add_alert,size: 30,
                  color: Theme.of(context).primaryColor,),
                );
              },
            )
          ]

        );
      }
}