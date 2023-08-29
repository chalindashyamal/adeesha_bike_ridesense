import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWithLocationName extends StatefulWidget {
  @override
  _MapWithLocationNameState createState() => _MapWithLocationNameState();
}

class _MapWithLocationNameState extends State<MapWithLocationName> {
  GoogleMapController? _controller;
  LatLng? _selectedLatLng;
  String? _locationName;

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  void _onMapTap(LatLng latLng) async {
    setState(() {
      _selectedLatLng = latLng;
      _locationName = null; // Reset location name when new lat/lng is selected
    });

    // Get the location name (address) using geocoding
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latLng.latitude, latLng.longitude
      );

      if (placemarks.isNotEmpty) {
        setState(() {
          _locationName = placemarks[0].name;
        });
      }
    } catch (e) {
      print('Error getting location name: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map with Location Name'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        onTap: _onMapTap,
        initialCameraPosition: CameraPosition(
          target: LatLng(6.9271, 79.8612), // Coordinates for a location in Sri Lanka
          zoom: 8,
        ),
        markers: _selectedLatLng != null
            ? {
                Marker(
                  markerId: MarkerId('selectedMarker'),
                  position: _selectedLatLng!,
                )
              }
            : {},
      ),
      floatingActionButton: _selectedLatLng != null
          ? FloatingActionButton.extended(
              onPressed: () {
                if (_locationName != null) {
                  print('Location Name: $_locationName');
                } else {
                  print('Location name not available.');
                }
              },
              label: Text('Get Location Name'),
              icon: Icon(Icons.location_on),
            )
          : null,
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MapWithLocationName(),
  ));
}
