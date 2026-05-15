import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import '../models/item.dart';

class StorageService {
  static const String assetPath = 'assets/data/items.json';
  static const String fileName = 'local_items.json';

  // Lab 9.1: Read from Assets
  Future<List<Item>> loadItemsFromAssets() async {
    final String response = await rootBundle.loadString(assetPath);
    final data = json.decode(response) as List;
    return data.map((e) => Item.fromJson(e)).toList();
  }

  // Lab 9.2: Local Storage Persistence
  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$fileName');
  }

  Future<List<Item>> loadItemsFromStorage() async {
    try {
      final file = await _localFile;
      if (!await file.exists()) {
        // Initial load from assets if local storage is empty
        final items = await loadItemsFromAssets();
        await saveItemsToStorage(items);
        return items;
      }
      final String contents = await file.readAsString();
      final data = json.decode(contents) as List;
      return data.map((e) => Item.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  // Lab 9.3: CRUD Save
  Future<File> saveItemsToStorage(List<Item> items) async {
    final file = await _localFile;
    final String jsonString = json.encode(items.map((e) => e.toJson()).toList());
    return file.writeAsString(jsonString);
  }
}
