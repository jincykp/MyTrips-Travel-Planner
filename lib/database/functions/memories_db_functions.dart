import 'package:flutter/material.dart';
import 'package:my_trips/database/model/memories_model.dart';
import 'package:hive/hive.dart';

ValueNotifier<List<MemoryModel>> memoryNotifier = ValueNotifier([]);

Future<void> addMemories(MemoryModel mm) async {
  try {
    final memoryDataBox = await Hive.openBox<MemoryModel>('memo_data');

    // Add the memory to Hive and get the key
    final key = await memoryDataBox.add(mm);

    // Set the id to the key returned by Hive
    mm.id = key;

    // Update the entry with the correct id
    await memoryDataBox.put(key, mm);

    // Update the notifier
    await updateMemories();

    print("Memory added with ID: $key");
  } catch (e) {
    print("Error adding memory: $e");
    rethrow;
  }
}

Future<void> updateMemories() async {
  try {
    final memoryDataBox = await Hive.openBox<MemoryModel>('memo_data');

    // Clear the current list
    memoryNotifier.value.clear();

    // Add all memories from Hive
    memoryNotifier.value.addAll(memoryDataBox.values.toList());

    // Notify listeners
    memoryNotifier.notifyListeners();

    print("Memories updated. Total count: ${memoryNotifier.value.length}");
  } catch (e) {
    print("Error updating memories: $e");
  }
}

Future<void> deleteMemory(int id) async {
  try {
    final memoryDataBox = await Hive.openBox<MemoryModel>('memo_data');

    // Check if the key exists before deleting
    if (memoryDataBox.containsKey(id)) {
      await memoryDataBox.delete(id);
      print("Memory with ID $id deleted successfully");

      // Update the memories list
      await updateMemories();
    } else {
      print("Memory with ID $id not found");
    }
  } catch (e) {
    print("Error deleting memory: $e");
  }
}

Future<void> editMemories(MemoryModel editedMemos) async {
  try {
    if (editedMemos.id == null) {
      print("Error: Memory ID is null, cannot edit");
      return;
    }

    print("Editing memory with ID: ${editedMemos.id}");

    final memoryDataBox = await Hive.openBox<MemoryModel>('memo_data');

    // Check if the memory exists
    if (memoryDataBox.containsKey(editedMemos.id)) {
      await memoryDataBox.put(editedMemos.id!, editedMemos);
      print("Memory updated successfully");

      // Update the memories list
      await updateMemories();
    } else {
      print("Memory with ID ${editedMemos.id} not found");
    }
  } catch (e) {
    print("Error editing memory: $e");
  }
}

// Additional helper functions
Future<void> initializeMemories() async {
  try {
    await updateMemories();
    print("Memories initialized");
  } catch (e) {
    print("Error initializing memories: $e");
  }
}

Future<void> clearAllMemories() async {
  try {
    final memoryDataBox = await Hive.openBox<MemoryModel>('memo_data');
    await memoryDataBox.clear();
    await updateMemories();
    print("All memories cleared");
  } catch (e) {
    print("Error clearing all memories: $e");
  }
}

Future<MemoryModel?> getMemoryById(int id) async {
  try {
    final memoryDataBox = await Hive.openBox<MemoryModel>('memo_data');
    return memoryDataBox.get(id);
  } catch (e) {
    print("Error getting memory by ID: $e");
    return null;
  }
}

// Function to get all memory IDs for debugging
Future<List<dynamic>> getAllMemoryIds() async {
  try {
    final memoryDataBox = await Hive.openBox<MemoryModel>('memo_data');
    return memoryDataBox.keys.toList();
  } catch (e) {
    print("Error getting memory IDs: $e");
    return [];
  }
}
