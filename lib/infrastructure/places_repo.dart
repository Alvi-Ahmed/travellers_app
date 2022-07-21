import 'package:clean_api/clean_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../models/i_places_repo.dart';

import '../models/placesModel.dart';

class PlacesRepo extends IPlacesRepo {
  final collection = FirebaseFirestore.instance.collection("places");

  @override
  TaskEither<CleanFailure, IList<Places>> getAllPlaces() => TaskEither.tryCatch(
        () async {
          final docs = await collection.get().then((value) => value.docs);

          final placeList =
              List<Places>.from(docs.map((e) => Places.fromMap(e.data()))).lock;

          return placeList;
        },
        (error, _) => CleanFailure(
            error: error.toString(), tag: 'Error on fetching places'),
      );
}
