import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import '../l10n/app_localizations.dart';

class NearbyShopsScreen extends StatefulWidget {
  const NearbyShopsScreen({super.key});

  @override
  _NearbyShopsScreenState createState() => _NearbyShopsScreenState();
}

class _NearbyShopsScreenState extends State<NearbyShopsScreen> {
  GoogleMapController? _controller;
  LatLng? _currentLocation;
  final Set<Marker> _markers = {};
  String _selectedBusiness = "dairy";
  List<Map<String, dynamic>> _shops = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    setState(() => _isLoading = true);
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception("Location services are disabled.");
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception("Location permission denied.");
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception("Location permissions are permanently denied.");
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
      });

      if (_controller != null) {
        _controller!.animateCamera(CameraUpdate.newLatLng(_currentLocation!));
      }
    } catch (e) {
      _showSnackbar("Error: ${e.toString()}");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _fetchNearbyShops() async {
    if (_currentLocation == null) {
      _showSnackbar("Location not available. Please try again.");
      return;
    }

    setState(() => _isLoading = true);

    // Replace with your actual backend URL
    final url = Uri.parse("http://172.16.1.15:5003/find_shops");
    print(_currentLocation!.latitude);
    print(_currentLocation!.longitude);
    print(_selectedBusiness);

    try {
      // print("2");
      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              "latitude": _currentLocation!.latitude,
              "longitude": _currentLocation!.longitude,
              "business": _selectedBusiness,
            }),
          )
          .timeout(const Duration(seconds: 10));
      // print(jsonDecode(response.toString())); // Add a timeout

      if (response.statusCode == 200) {
        print(response.body);
        List<dynamic> data = json.decode(response.body);

        setState(() {
          _shops = List<Map<String, dynamic>>.from(data);
          _markers.clear();
          for (var shop in _shops) {
            _markers.add(
              Marker(
                markerId: MarkerId(shop["name"]),
                position: LatLng(shop["latitude"], shop["longitude"]),
                infoWindow: InfoWindow(
                  title: shop["name"],
                  snippet: "${shop["distance"].toStringAsFixed(2)} km away",
                ),
              ),
            );
          }
        });

        _showSnackbar("Found ${_shops.length} shops nearby!");
      } else {
        throw Exception("Error fetching shops: ${response.statusCode}");
      }
    } catch (e) {
      _showSnackbar("Failed to fetch shops: ${e.toString()}");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showSnackbar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.nearbyShops)),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _currentLocation ?? const LatLng(0, 0),
                zoom: 14.0,
              ),
              onMapCreated: (controller) {
                _controller = controller;
                if (_currentLocation != null) {
                  _controller!
                      .animateCamera(CameraUpdate.newLatLng(_currentLocation!));
                }
              },
              markers: _markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: _selectedBusiness,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedBusiness = newValue!;
                      });
                    },
                    items: <String>[
                      'dairy',
                      'bakery',
                      'supermarket',
                      'convenience'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                ElevatedButton(
                  onPressed: _isLoading ? null : _fetchNearbyShops,
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(AppLocalizations.of(context)!.search),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _shops.length,
              itemBuilder: (context, index) {
                final shop = _shops[index];
                return ListTile(
                  title: Text(shop["name"]),
                  subtitle:
                      Text("${shop["distance"].toStringAsFixed(2)} km away"),
                  onTap: () {
                    _controller?.animateCamera(CameraUpdate.newLatLng(
                      LatLng(shop["latitude"], shop["longitude"]),
                    ));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
