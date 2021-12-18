import 'package:flutter/widgets.dart';
import 'package:patealo/application/services/http_service.dart';
import 'package:patealo/domain/entities/pictogram.dart';
import 'package:patealo/domain/repositories/pictograms_repository.dart';
import 'package:provider/provider.dart';

class PictogramsRepositoryImpl extends ChangeNotifier with PictogramsRepository {
  static PictogramsRepositoryImpl of(BuildContext context) => Provider.of<PictogramsRepositoryImpl>(context, listen: false);

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

  @override
  Future<Pictogram> getPictogram(int id) async {
    try {
      Pictogram pict = await HttpService.fetch.getPictogram(id);

      pictogram = pict;

      return pictogram!;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Pictogram>> getPictograms() async {
    try {
      List<Pictogram> picts = await HttpService.fetch.getPictograms();

      pictograms = picts;

      return pictograms;
    } catch (e) {
      rethrow;
    }
  }
}
