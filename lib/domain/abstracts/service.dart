import 'package:patealo/domain/entities/pictogram.dart';

abstract class Service {
  Future<Pictogram> getPictogram(int id);

  Future<List<Pictogram>> getPictograms();
}
