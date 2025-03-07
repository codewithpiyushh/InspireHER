import 'package:flutter/material.dart';
// import 'setup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import '../l10n/app_localizations.dart';
import 'supplier.dart';
// Business Preferences class for storing selected business

class CategoryScreen extends StatelessWidget {
  final String category;
  final String businessType;

  CategoryScreen({
    super.key,
    required this.category,
    required this.businessType,
  });

  // Sample supplier data categorized
  final Map<String, List<Map<String, String>>> suppliersData = {
    "Cattles": [
      {
        "name": "Suresh Cattle",
        "image": "assets/cattles1.jpeg",
        "description": "Leading supplier of high-quality cattle."
      },
      {
        "name": "Mahesh Cattles",
        "image": "assets/cattles2.jpeg",
        "description": "Best breed of cattle at affordable prices."
      },
      {
        "name": "Rajesh Livestock",
        "image": "assets/cattles1.jpeg",
        "description": "Trusted provider of premium livestock breeds."
      },
      {
        "name": "Vikram Dairy Farms",
        "image": "assets/cattles2.jpeg",
        "description": "Healthy and high-yield cattle at great prices."
      }
    ],
    "Containers": [
      {
        "name": "Fashion Trends",
        "image": "assets/containers1.jpeg",
        "description": "Stylish and trendy clothing supplier."
      },
      {
        "name": "WearWell Ltd.",
        "image": "assets/containers2.jpeg",
        "description": "Quality fabrics for all seasons."
      },
      {
        "name": "Style Hub",
        "image": "assets/containers1.jpeg",
        "description": "Your go-to destination for the latest fashion trends."
      },
      {
        "name": "Elite Fabrics",
        "image": "assets/containers2.jpeg",
        "description": "Premium-quality fabrics for every occasion."
      }
    ],
    "Milk Coolers": [
      {
        "name": "HomeStyle Furnishings",
        "image": "assets/coolers1.jpeg",
        "description": "Elegant and durable furniture."
      },
      {
        "name": "WoodCrafters",
        "image": "assets/coolers2.jpeg",
        "description": "Handcrafted wooden furniture."
      },
      {
        "name": "Elegant Living",
        "image": "assets/coolers1.jpeg",
        "description": "Stylish and long-lasting home furniture."
      },
      {
        "name": "Timber Artisans",
        "image": "assets/coolers2.jpeg",
        "description": "Exquisite handcrafted wooden pieces."
      }
    ],
    "Packaging": [
      {
        "name": "Mother Milk Packagers",
        "image": "assets/packaging1.jpeg",
        "description": "Premium packaging solutions for dairy products."
      },
      {
        "name": "Rutu Packagers",
        "image": "assets/packaging2.jpeg",
        "description": "Reliable and eco-friendly packaging materials."
      },
      {
        "name": "PurePack Dairy",
        "image": "assets/packaging1.jpeg",
        "description": "High-quality packaging for fresh dairy products."
      },
      {
        "name": "EcoWrap Solutions",
        "image": "assets/packaging2.jpeg",
        "description": "Sustainable and durable packaging materials."
      }
    ],
    "Transportation": [
      {
        "name": "Speedy Logistics",
        "image": "assets/Transportation1.jpeg",
        "description": "Reliable and fast transport services."
      },
      {
        "name": "Safe Haul Movers",
        "image": "assets/Transportation2.jpeg",
        "description": "Secure and efficient cargo handling."
      },
      {
        "name": "Swift Transit",
        "image": "assets/Transportation1.jpeg",
        "description": "Fast and dependable transportation solutions."
      },
      {
        "name": "Guardian Freight",
        "image": "assets/Transportation2.jpeg",
        "description": "Safe and efficient cargo logistics."
      }
    ],
    "Fooder": [
      {
        "name": "Green Harvest",
        "image": "assets/Fooder1.jpeg",
        "description": "Organic and fresh fodder for livestock."
      },
      {
        "name": "AgroFeed Supply",
        "image": "assets/Fooder2.jpeg",
        "description": "Nutrient-rich feed for better livestock health."
      },
      {
        "name": "FreshGraze",
        "image": "assets/Fooder1.jpeg",
        "description": "High-quality organic fodder for healthier livestock."
      },
      {
        "name": "NutriFeed Solutions",
        "image": "assets/Fooder2.jpeg",
        "description": "Premium nutrient-rich feed for optimal animal growth."
      }
    ],
  };

  @override
  Widget build(BuildContext context) {
    final suppliers = suppliersData[category] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('$businessType - $category'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: suppliers.length,
        itemBuilder: (context, index) {
          final supplier = suppliers[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(supplier["image"]!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(
                supplier["name"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                supplier["description"]!,
                style: const TextStyle(color: Colors.grey),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Show supplier details
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) {
                    return DraggableScrollableSheet(
                      initialChildSize: 0.9,
                      minChildSize: 0.5,
                      maxChildSize: 0.95,
                      expand: false,
                      builder: (context, scrollController) {
                        return SingleChildScrollView(
                          controller: scrollController,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Container(
                                    width: 50,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  supplier["name"]!,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  height: 200,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: AssetImage(supplier["image"]!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Description',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  supplier["description"]!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    height: 1.5,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF1A237E),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text(
                                      'Contact Supplier',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

Future<void> saveSelectedBusiness(String business) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('selected_business', business);
}

Future<String?> getSelectedBusiness() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('selected_business');
}

class LocationScreen extends StatefulWidget {
  final String businessType;

  const LocationScreen({super.key, required this.businessType});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  GoogleMapController? _controller;
  LatLng? _currentLocation;
  final Set<Marker> _markers = {};
  bool _isLoading = false;
  List<Map<String, dynamic>> _shops = [];

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
    final url = Uri.parse("http://192.168.1.4:5003/find_shops");

    try {
      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              "latitude": _currentLocation!.latitude,
              "longitude": _currentLocation!.longitude,
              "business": widget.businessType, // Using widget's businessType
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        // Use WidgetsBinding to avoid UI rendering errors
        WidgetsBinding.instance.addPostFrameCallback((_) {
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
        });
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
      appBar: AppBar(title: Text('${widget.businessType} Locations')),
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
                if (_controller != null && _currentLocation != null) {
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
            child: ElevatedButton(
              onPressed: _isLoading ? null : _fetchNearbyShops,
              child: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(AppLocalizations.of(context)!.search),
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

// Home Screen
class HomeScreen extends StatefulWidget {
  final String businessType;

  const HomeScreen({
    super.key,
    this.businessType = "dairy",
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String currentBusiness;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    currentBusiness = widget.businessType;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Search Bar
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                color: Colors.lightBlue[100],
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText:
                        AppLocalizations.of(context)!.whatAreYouLookingFor,
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: const Icon(Icons.mic),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),

              // Banner Image - Horizontally Scrollable
              SizedBox(
                height: 200,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Image.network(
                        "https://img.freepik.com/premium-vector/hand-drawn-grocery-store-instagram-posts_23-2151042213.jpg",
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                      Image.network(
                        "https://i.pinimg.com/474x/36/48/c4/3648c44041bf1f579b97b5eac5e40399.jpg",
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                      Image.network(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTt7VNxqKK25-EmjN_glyuiE4LNnBTIqnxWKA&s",
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),

              // Become a Supplier Button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LakshmiDeviScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A237E),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.becomeasupplier,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Business Type Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  '$currentBusiness Goods',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Categories - First Row
              // ✅ First Row - Categories
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildCategoryItem(
                      context,
                      _getCategoryName(0),
                      _getCategoryIcon(0),
                    ),
                    _buildCategoryItem(
                      context,
                      _getCategoryName(1),
                      _getCategoryIcon(1),
                    ),
                    _buildCategoryItem(
                      context,
                      _getCategoryName(2),
                      _getCategoryIcon(2),
                    ),
                  ],
                ),
              ),

// ✅ Second Row - Categories
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildCategoryItem(
                      context,
                      _getCategoryName(3), // ✅ Fixed missing category name
                      _getCategoryIcon(3),
                    ),
                    _buildCategoryItem(
                      context,
                      _getCategoryName(4),
                      _getCategoryIcon(4),
                    ),
                    _buildCategoryItem(
                      context,
                      _getCategoryName(5),
                      _getCategoryIcon(5),
                    ),
                  ],
                ),
              ),

              // Places to setup your business
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.placestosetup,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                LocationScreen(businessType: currentBusiness),
                          ),
                        );
                      },
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: const DecorationImage(
                            image: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDy37R6KSjshz59vpkun2AO1bZC2VGtuwnvw&s',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(
      BuildContext context, String title, String imageUrl) {
    print("Category: $title, Image Path: $imageUrl"); // ✅ Debug print

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryScreen(
              category: title,
              businessType: currentBusiness,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(imageUrl), // Ensure AssetImage is used
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  String _getCategoryName(int index) {
    List<String> dairyCategories = [
      AppLocalizations.of(context)!.cattles,
      AppLocalizations.of(context)!.containers,
      AppLocalizations.of(context)!.milkCoolers,
      AppLocalizations.of(context)!.packaging,
      AppLocalizations.of(context)!.transportation,
      AppLocalizations.of(context)!.fodder,
    ];

    return (index >= 0 && index < dairyCategories.length)
        ? dairyCategories[index]
        : "Unknown";
  }

  String _getCategoryIcon(int index) {
    List<String> dairyIcons = [
      "assets/Cattles.webp",
      "assets/Containers.jpeg",
      "assets/Milk Coolers.jpeg",
      "assets/Packaging.jpeg",
      "assets/Transportation.jpeg",
      "assets/Fodder.jpeg"
    ];

    return (index >= 0 && index < dairyIcons.length)
        ? dairyIcons[index]
        : ""; // Returns empty if index is invalid
  }
}
