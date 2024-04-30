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
  try {
    final memoryDataBox = await Hive.openBox<MemoryModel>('memo_data');
    memoryNotifier.value.clear();
    memoryNotifier.value.addAll(memoryDataBox.values);
    memoryNotifier.notifyListeners();
  } on Exception catch (e) {
    print(e);
  }
}

Future<void> deleteMemory(int id) async {
  final memoryDatabox = await Hive.openBox<MemoryModel>('memo_data');
  memoryDatabox.delete(id);
  // memoryDatabox.clear();
  updateMemories();
}

Future<void> editMemories(MemoryModel editedmemos) async {
  try {
    print(editedmemos.id);
    print("m edit reached");
    final memoryDatabox = await Hive.openBox<MemoryModel>('memo_data');
    await memoryDatabox.put(editedmemos.id, editedmemos);
    await updateMemories();
  } catch (e) {
    print(e);
  }
}
