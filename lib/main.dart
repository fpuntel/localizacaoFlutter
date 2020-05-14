import 'package:flutter/material.dart';
//import 'package:flutter_map/flutter_map.dart';
//import 'package:latlong/latlong.dart';
import 'textStyle.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MaterialApp(
    home: FlutterMap(),
  ));
}

class FlutterMap extends StatefulWidget {
  @override
  _FlutterMap createState() => _FlutterMap();
}

class _FlutterMap extends State<FlutterMap> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position minhaPosicao;
  String cidade = "",
      pais = "",
      codPostal = "",
      bairro = "",
      estado = "",
      rua = "";
  double altura = 300.0, largura = 450.0;

  _pegarLocalizacao() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position posicao) {
      setState(() {
        minhaPosicao = posicao;
        _pegarEndereco();
      });
    });
  }

  _pegarEndereco() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          minhaPosicao.latitude, minhaPosicao.longitude);
      Placemark local = p[0];

      setState(() {
        altura = 300.0;
        bairro = local.subLocality.toString();
        rua = local.thoroughfare.toString();
        cidade = local.locality.toString();
        estado = local.administrativeArea.toString();
        pais = local.country.toString();
        codPostal = local.postalCode.toString();

        //largura = 450.0;
      });
    } catch (e) {
      print("Error: " + e.toString());
    }
  }

  Column infLocalizacao() {
    return Column(
      children: <Widget>[
        Text(" LAT: ${minhaPosicao.latitude} LON: ${minhaPosicao.longitude}",
            style: Style.textApp),
        //if (cidade != ""){
        Text("Codigo Postal: ${codPostal}", style: Style.textApp),
        Text("Rua: ${rua}", style: Style.textApp),
        Text("Bairro: ${bairro}", style: Style.textApp),
        Text("Cidade: ${cidade}", style: Style.textApp),
        Text("Estado: ${estado}", style: Style.textApp),
        Text("Pais: ${pais}", style: Style.textApp),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('LOCALIZAÇÃO', style: Style.appBar),
          centerTitle: true,
          backgroundColor: Colors.amber[800]),
      body: Column(
        children: <Widget>[
          Container(
            height: altura,
            width: largura,
            alignment: Alignment.center,
            padding: EdgeInsets.all(15.0),
            child: Card(
              child: Column(
                children: <Widget>[
                  Text("Sua Localização:", style: Style.textAppTitulo),
                  new Divider(),
                  if (minhaPosicao != null) infLocalizacao(),
                  new Divider(),
                  Container(
                      alignment: Alignment.center,
                      color: Colors.amber[800],
                      child: FlatButton(
                        child: Text(
                          "Obter localização",
                          style: Style.baseTextStyle,
                        ),
                        onPressed: () {
                          _pegarLocalizacao();
                        },
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    //);
  }
}

/*
Ref utilizadas:
- Flutter: Getting a User's Location with the Geolocator Plugin: https://do.co/35WeQ29
 */
