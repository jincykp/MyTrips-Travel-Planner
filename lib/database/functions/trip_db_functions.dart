import 'package:flutter/material.dart';
import 'package:my_trips/database/functions/user_db_functions.dart';
import 'package:my_trips/database/model/trip_model.dart';
import 'package:hive/hive.dart';

ValueNotifier<List<TripModel>> tripListNotifier = ValueNotifier([]);
Future<void> AddTrips(TripModel value) async {
  final tripDataBox = await Hive.openBox<TripModel>('trip_data');
  value.id = await tripDataBox.add(value);
  tripDataBox.put(value.id, value);
  tripListNotifier.value.add(value);
  print(tripDataBox.values.length);
  print(value.image);
  tripListNotifier.notifyListeners();
  print("trip added");
}

Future<void> updateTrip() async {
  try {
    final tripDataBox = await Hive.openBox<TripModel>('trip_data');
    tripListNotifier.value.clear();
    tripListNotifier.value.addAll(tripDataBox.values);
  } catch (e) {
    print(e);
  }
  tripListNotifier.notifyListeners();
}

Future<void> deleteTrip(int id) async {
  final tripDataBox = await Hive.openBox<TripModel>('trip_data');
  print(id);
  // tripDataBox.clear();
  tripDataBox.delete(id);
  updateTrip();
}

Future<void> editTrip(TripModel editedTrips) async {
  print("here reached");
  final tripDataBox = await Hive.openBox<TripModel>('trip_data');
  if (tripDataBox.containsKey(editedTrips.id)) {
    tripDataBox.put(editedTrips.id, editedTrips);
    print("updated");
  } else {
    print("id ${editedTrips.id} does not match");
  }
  updateTrip();
}
