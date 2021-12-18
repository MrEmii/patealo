import 'package:patealo/domain/entities/pictogram.dart';

mixin PictogramsRepository {

  Future<Pictogram> getPictogram(int id);

  Future<List<Pictogram>> getPictograms();

}