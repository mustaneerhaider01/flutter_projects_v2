import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/add_place_screen.dart';
import '../providers/great_places.dart';
import '../widgets/place_item.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  Future<void> _refreshPlaces(BuildContext context) async {
    await Provider.of<GreatPlaces>(context, listen: false).fetchAndSetPlaces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: FutureBuilder(
        future: _refreshPlaces(context),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : RefreshIndicator(
                onRefresh: () => _refreshPlaces(context),
                child: Consumer<GreatPlaces>(
                  child: const Center(
                    child: Text(
                      'Got no places yet, Start adding some!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  builder: (ctx, greatPlaces, ch) => greatPlaces.items.isEmpty
                      ? ch!
                      : ListView.separated(
                          padding: const EdgeInsets.all(10),
                          itemCount: greatPlaces.items.length,
                          itemBuilder: (_, i) => PlaceItem(
                            id: greatPlaces.items[i].id,
                            title: greatPlaces.items[i].title,
                            image: greatPlaces.items[i].image,
                            address: greatPlaces.items[i].location.address!,
                          ),
                          separatorBuilder: (_, i) =>
                              const SizedBox(height: 16),
                        ),
                ),
              ),
      ),
    );
  }
}
