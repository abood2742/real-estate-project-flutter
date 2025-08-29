
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:property_system/l10n/app_localizations.dart';

class Property {
  final String name;
  final double lat;
  final double lng;

  Property({required this.name, required this.lat, required this.lng});
}

class MapPage extends StatelessWidget {
  final List<Property> properties = [
    Property(
      name: 'النخبة - ريف دمشق السيدة زينب',
      lat: 33.4440,
      lng: 36.3189,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.translate('interactive_map_syria'),
          style: const TextStyle(color: Colors.blue, fontFamily: 'Pacifico'),
        ),
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(33.5138, 36.2765),
          initialZoom: 8,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: properties.map((prop) {
              return Marker(
                point: LatLng(prop.lat, prop.lng),
                width: 40,
                height: 40,
                child: Icon(Icons.location_on, size: 40, color: Colors.red),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}