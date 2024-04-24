import 'package:flutter/material.dart';
import 'package:my_trips/database/model/memories_model.dart';
import 'package:hive/hive.dart';

ValueNotifier<List<MemoryModel>> memoryNotifier = ValueNotifier([]);
Future<void> addMemories(MemoryModel mm) async {
  final memoryDataBox = await Hive.openBox<MemoryModel>('memo_data');
  mm.id = await memoryDataBox.add(mm);
  memoryDataBox.put(mm.id, mm);
  memoryNotifier.value.add(mm);
  memoryNotifier.notifyListeners();
  print("mm added");
}

Future<void> updateMemories() async {
  final memoryDataBox = await Hive.openBox<MemoryModel>('memo_data');
  memoryNotifier.value.clear();
  memoryNotifier.value.addAll(memoryDataBox.values);
  memoryNotifier.notifyListeners();
}

Future<void> deleteMemory(int id) async {
  final memoryDatabox = await Hive.openBox<MemoryModel>('memo_data');
  memoryDatabox.delete(id);
  // memoryDatabox.clear();
  //updateMemories();
}
