import 'package:flutter/widgets.dart';
import 'package:patealo/domain/entities/pictogram.dart';
import 'package:patealo/domain/repositories/pictograms_repository.dart';
import 'package:provider/provider.dart';

class PictrogramsLocalImpl extends ChangeNotifier with PictogramsRepository {
  static PictrogramsLocalImpl of(BuildContext context) => Provider.of<PictrogramsLocalImpl>(context, listen: false);

  List<Pictogram> _pictograms = [];

  List<Pictogram> get pictograms => _pictograms;

  set pictograms(List<Pictogram> pictograms) {
    _pictograms = pictograms;
    notifyListeners();
  }

  Pictogram? _pictogram;

  Pictogram? get pictogram => _pictogram;

  set pictogram(Pictogram? pictogram) {
    _pictogram = pictogram;
    notifyListeners();
  }

  // por maxi firtman https://github.com/firtman/charlalo
  List<Map<String, String>> pictrogramsJson = [
    {"archivo": "ciego.png", "nombre": "ciego"},
    {"archivo": "sordo.png", "nombre": "sordo"},
    {"archivo": "ambulancia.png", "nombre": "ambulancia"},
    {"archivo": "borracho.png", "nombre": "borracho"},
    {"archivo": "choque.png", "nombre": "choque"},
    {"archivo": "doctor.png", "nombre": "doctor"},
    {"archivo": "dolor_brazo.png", "nombre": "dolor de brazo"},
    {"archivo": "dolor_cabeza.png", "nombre": "dolor de cabeza"},
    {"archivo": "dolor_espalda.png", "nombre": "dolor de espalda"},
    {"archivo": "dolor_estomago.png", "nombre": "dolor de estómago"},
    {"archivo": "dolor_garganta.png", "nombre": "dolor de garganta"},
    {"archivo": "dolor_muela.png", "nombre": "dolor de muela"},
    {"archivo": "dolor_oidos.png", "nombre": "dolor de oídos"},
    {"archivo": "enfermera.png", "nombre": "enfermera"},
    {"archivo": "fiebre.png", "nombre": "fiebre"},
    {"archivo": "incendio.png", "nombre": "incendio"},
    {"archivo": "inyeccion.png", "nombre": "inyección"},
    {"archivo": "lastimadura.png", "nombre": "lastimadura"},
    {"archivo": "pelea.png", "nombre": "pelea"},
    {"archivo": "policia.png", "nombre": "policía"},
    {"archivo": "resfrio.png", "nombre": "resfrío"},
    {"archivo": "robo.png", "nombre": "robo"}
  ];

  @override
  Future<Pictogram> getPictogram(int id) {
    // TODO: implement getPictogram
    throw UnimplementedError();
  }

  @override
  Future<List<Pictogram>> getPictograms() {
    // TODO: implement getPictograms
    throw UnimplementedError();
  }
}
