import 'package:flutter/material.dart';
import '../models/item.dart';
import '../services/storage_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final StorageService _storageService = StorageService();
  late TabController _tabController;

  // State for Lab 9.1
  List<Item> _assetItems = [];

  // State for Lab 9.2 & 9.3
  List<Item> _localItems = [];
  List<Item> _filteredItems = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadAllData();
    _searchController.addListener(_filterItems);
  }

  Future<void> _loadAllData() async {
    final assetData = await _storageService.loadItemsFromAssets();
    final localData = await _storageService.loadItemsFromStorage();
    setState(() {
      _assetItems = assetData;
      _localItems = localData;
      _filteredItems = localData;
    });
  }

  void _filterItems() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems = _localItems.where((item) {
        return item.name.toLowerCase().contains(query) ||
               item.description.toLowerCase().contains(query);
      }).toList();
    });
  }

  // CRUD Operations
  Future<void> _addOrEditItem({Item? item}) async {
    final nameController = TextEditingController(text: item?.name);
    final descController = TextEditingController(text: item?.description);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(item == null ? 'Add Item' : 'Edit Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Name')),
            TextField(controller: descController, decoration: const InputDecoration(labelText: 'Description')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                setState(() {
                  if (item == null) {
                    // Create
                    final newId = _localItems.isEmpty ? 1 : _localItems.map((e) => e.id).reduce((a, b) => a > b ? a : b) + 1;
                    _localItems.add(Item(id: newId, name: nameController.text, description: descController.text));
                  } else {
                    // Update
                    item.name = nameController.text;
                    item.description = descController.text;
                  }
                  _filterItems(); // Update filtered list
                });
                _storageService.saveItemsToStorage(_localItems); // Auto-save
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved successfully!')));
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteItem(int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Item'),
        content: const Text('Are you sure you want to delete this item?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete', style: TextStyle(color: Colors.red))),
        ],
      ),
    );

    if (confirm == true) {
      setState(() {
        _localItems.removeWhere((element) => element.id == id);
        _filterItems();
      });
      _storageService.saveItemsToStorage(_localItems);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 9 - JSON Storage'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Assets (9.1)', icon: Icon(Icons.file_open)),
            Tab(text: 'CRUD (9.2 & 9.3)', icon: Icon(Icons.storage)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // 9.1 Asset View
          _buildAssetList(),
          // 9.2 & 9.3 CRUD View
          _buildCRUDView(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditItem(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildAssetList() {
    return _assetItems.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: _assetItems.length,
            itemBuilder: (context, index) {
              final item = _assetItems[index];
              return ListTile(
                leading: CircleAvatar(child: Text(item.id.toString())),
                title: Text(item.name),
                subtitle: Text(item.description),
              );
            },
          );
  }

  Widget _buildCRUDView() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              labelText: 'Search items...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredItems.length,
            itemBuilder: (context, index) {
              final item = _filteredItems[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ListTile(
                  title: Text(item.name),
                  subtitle: Text(item.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(icon: const Icon(Icons.edit, color: Colors.blue), onPressed: () => _addOrEditItem(item: item)),
                      IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => _deleteItem(item.id)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
