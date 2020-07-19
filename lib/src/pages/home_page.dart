import 'package:flutter/material.dart';
import 'package:getapp/src/providers/productos_provider.dart';
//Importaciones propias
import 'package:getapp/src/widgets/card_swiper_widget.dart';
import 'package:getapp/src/widgets/productos_horizontal.dart';

class HomePage extends StatelessWidget {
  final productosProvider = new ProductosProvider();

  @override
  Widget build(BuildContext context) {
    productosProvider.getPopulares();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Get it App'),
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            // _encabezado(context),
            _swiperTarjetas(),
            _footer(context),
            _botones(context)
          ],
        ),
      ),
    );
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: productosProvider.getNuevos(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(productos: snapshot.data);
        } else {
          return Container(
              height: 400.0,
              child: Center(
                child: CircularProgressIndicator(),
              ));
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('Productos Populares',
                style: Theme.of(context).textTheme.subtitle1),
          ),
          SizedBox(height: 5.0),
          StreamBuilder(
            stream: productosProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return ProductosHorizontal(
                  productos: snapshot.data,
                  siguientePagina: productosProvider.getPopulares,
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _botones(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'login');
              },
              textColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10.0),
              color: Colors.blueAccent,
              child: Container(
                child: const Text('Iniciar Sesion',
                    style: TextStyle(fontSize: 20)),
              )),
          RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'registro');
              },
              textColor: Colors.white,
              color: Colors.blueAccent,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10.0),
              child: Container(
                         child:
                        const Text('Registrarse', style: TextStyle(fontSize: 20)),
              ))
        ],
      ),
    );
  }
}