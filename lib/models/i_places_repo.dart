import 'package:clean_api/clean_api.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:travellers_app/models/placesModel.dart';

abstract class IPlacesRepo {
  TaskEither<CleanFailure, IList<Places>> getAllPlaces();
}
