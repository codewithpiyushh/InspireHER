// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:geolocator/geolocator.dart';

// // Business Preferences class for storing selected business
// class BusinessPreferences {
//   static Future<void> saveSelectedBusiness(String business) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('selected_business', business);
//     print("Saved Business: $business");
//   }

//   static Future<String> getSelectedBusiness() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('selected_business') ?? "Dairy";
//   }
// }

// // Category Screen
// class CategoryScreen extends StatelessWidget {
//   final String category;
//   final String businessType;

//   const CategoryScreen({
//     Key? key,
//     required this.category,
//     required this.businessType,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('$businessType - $category'),
//         backgroundColor: Colors.blue,
//       ),
//       body: ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: 10,
//         itemBuilder: (context, index) {
//           return Card(
//             margin: const EdgeInsets.only(bottom: 16),
//             child: ListTile(
//               contentPadding: const EdgeInsets.all(16),
//               leading: Container(
//                 width: 60,
//                 height: 60,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8),
//                   image: DecorationImage(
//                     image: AssetImage(
//                       _getCategoryItemImage(index),
//                     ),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               title: Text(
//                 '$category Item ${index + 1}',
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               subtitle: Text(
//                 'This is a $businessType $category item description. Tap to see more details.',
//                 style: const TextStyle(
//                   color: Colors.grey,
//                 ),
//               ),
//               trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//               onTap: () {
//                 // Show item details
//                 showModalBottomSheet(
//                   context: context,
//                   isScrollControlled: true,
//                   shape: const RoundedRectangleBorder(
//                     borderRadius:
//                         BorderRadius.vertical(top: Radius.circular(20)),
//                   ),
//                   builder: (context) {
//                     return DraggableScrollableSheet(
//                       initialChildSize: 0.9,
//                       minChildSize: 0.5,
//                       maxChildSize: 0.95,
//                       expand: false,
//                       builder: (context, scrollController) {
//                         return SingleChildScrollView(
//                           controller: scrollController,
//                           child: Padding(
//                             padding: const EdgeInsets.all(20),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Center(
//                                   child: Container(
//                                     width: 50,
//                                     height: 5,
//                                     decoration: BoxDecoration(
//                                       color: Colors.grey[300],
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 20),
//                                 Text(
//                                   '$category Item ${index + 1}',
//                                   style: const TextStyle(
//                                     fontSize: 24,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 20),
//                                 Container(
//                                   height: 200,
//                                   width: double.infinity,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(12),
//                                     image: DecorationImage(
//                                       image: AssetImage(
//                                         _getCategoryItemImage(index),
//                                       ),
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 20),
//                                 const Text(
//                                   'Description',
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 10),
//                                 Text(
//                                   'This is a detailed description of the $businessType $category item ${index + 1}. '
//                                   'It includes all the specifications and features that would be relevant to a potential buyer or supplier. '
//                                   'The description is comprehensive and provides all necessary information about the product.',
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     height: 1.5,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 20),
//                                 const Text(
//                                   'Specifications',
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 // const SizedBox(height: 10),
//                                 // _buildSpecificationItem(
//                                 //     'Type', '$businessType $category'),
//                                 // _buildSpecificationItem('Quality', 'Premium'),
//                                 // _buildSpecificationItem(
//                                 //     'Availability', 'In Stock'),
//                                 // _buildSpecificationItem(
//                                 //     'Delivery', 'Available'),
//                                 // _buildSpecificationItem(
//                                 //     'Price Range', '\$100 - \$500'),
//                                 const SizedBox(height: 30),
//                                 SizedBox(
//                                   width: double.infinity,
//                                   child: ElevatedButton(
//                                     onPressed: () {},
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: const Color(0xFF1A237E),
//                                       padding: const EdgeInsets.symmetric(
//                                           vertical: 16),
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(8),
//                                       ),
//                                     ),
//                                     child: const Text(
//                                       'Contact Supplier',
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }

//   String _getCategoryItemImage(int index) {
//     String categoryLower = category.toLowerCase();
//     return "assets/images/${businessType.toLowerCase()}/$categoryLower.png";
//   }
// }

// // Location Screen (placeholder)
// class LocationScreen extends StatelessWidget {
//   final String businessType;

//   const LocationScreen({
//     Key? key,
//     required this.businessType,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('$businessType Locations'),
//         backgroundColor: Colors.blue,
//       ),
//       body: Center(
//         child: Text('Location screen for $businessType'),
//       ),
//     );
//   }
// }

// // Home Screen
// class HomeScreen extends StatefulWidget {
//   final String businessType;

//   const HomeScreen({
//     Key? key,
//     this.businessType = "Dairy",
//   }) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   late String currentBusiness;
//   final TextEditingController _searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     currentBusiness = widget.businessType;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               // Search Bar
//               Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                 color: Colors.lightBlue[100],
//                 child: TextField(
//                   controller: _searchController,
//                   decoration: InputDecoration(
//                     hintText: 'What are you looking for',
//                     filled: true,
//                     fillColor: Colors.grey[200],
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       borderSide: BorderSide.none,
//                     ),
//                     suffixIcon: const Icon(Icons.mic),
//                     contentPadding: const EdgeInsets.symmetric(horizontal: 16),
//                   ),
//                 ),
//               ),

//               // Banner Image - Horizontally Scrollable
//               Container(
//                 height: 200,
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: [
//                       Image.network(
//                         "https://img.freepik.com/premium-vector/hand-drawn-grocery-store-instagram-posts_23-2151042213.jpg",
//                         height: 200,
//                         width: MediaQuery.of(context).size.width,
//                         fit: BoxFit.cover,
//                       ),
//                       Image.network(
//                         "https://i.pinimg.com/474x/36/48/c4/3648c44041bf1f579b97b5eac5e40399.jpg",
//                         height: 200,
//                         width: MediaQuery.of(context).size.width,
//                         fit: BoxFit.cover,
//                       ),
//                       Image.network(
//                         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTt7VNxqKK25-EmjN_glyuiE4LNnBTIqnxWKA&s",
//                         height: 200,
//                         width: MediaQuery.of(context).size.width,
//                         fit: BoxFit.cover,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               // Become a Supplier Button
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF1A237E),
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: const Text(
//                     'Become a Supplier',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),

//               // Business Type Title
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: Text(
//                   '$currentBusiness Goods',
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),

//               // Categories - First Row
//               // ✅ First Row - Categories
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     _buildCategoryItem(
//                       context,
//                       _getCategoryName(0),
//                       _getCategoryIcon(0),
//                     ),
//                     _buildCategoryItem(
//                       context,
//                       _getCategoryName(1),
//                       _getCategoryIcon(1),
//                     ),
//                     _buildCategoryItem(
//                       context,
//                       _getCategoryName(2),
//                       _getCategoryIcon(2),
//                     ),
//                   ],
//                 ),
//               ),

// // ✅ Second Row - Categories
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     _buildCategoryItem(
//                       context,
//                       _getCategoryName(3), // ✅ Fixed missing category name
//                       _getCategoryIcon(3),
//                     ),
//                     _buildCategoryItem(
//                       context,
//                       _getCategoryName(4),
//                       _getCategoryIcon(4),
//                     ),
//                     _buildCategoryItem(
//                       context,
//                       _getCategoryName(5),
//                       _getCategoryIcon(5),
//                     ),
//                   ],
//                 ),
//               ),

//               // Places to setup your business
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Places to setup your business',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 LocationScreen(businessType: currentBusiness),
//                           ),
//                         );
//                       },
//                       child: Container(
//                         height: 200,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           image: const DecorationImage(
//                             image: NetworkImage(
//                               'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/image-PCx1rdmyCVfvYSfGqUrmLhCM0kokTK.png',
//                             ),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCategoryItem(
//       BuildContext context, String title, String imageUrl) {
//     print("Category: $title, Image Path: $imageUrl"); // ✅ Debug print

//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => CategoryScreen(
//               category: title,
//               businessType: currentBusiness,
//             ),
//           ),
//         );
//       },
//       child: Column(
//         children: [
//           Container(
//             width: 80,
//             height: 80,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               image: DecorationImage(
//                 image: AssetImage(imageUrl), // Ensure AssetImage is used
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             title,
//             textAlign: TextAlign.center,
//             style: const TextStyle(fontSize: 14),
//           ),
//         ],
//       ),
//     );
//   }

//   String _getCategoryName(int index) {
//     List<String> dairyCategories = [
//       "Cattles",
//       "Containers",
//       "Milk Coolers",
//       "Packaging",
//       "Transportation",
//       "Fodder"
//     ];

//     return (index >= 0 && index < dairyCategories.length)
//         ? dairyCategories[index]
//         : "Unknown";
//   }

//   String _getCategoryIcon(int index) {
//     List<String> dairyIcons = [
//       "assets/Cattles.webp",
//       "assets/Containers.jpeg",
//       "assets/Milk Coolers.jpeg",
//       "assets/Packaging.jpeg",
//       "assets/Transportation.jpeg",
//       "assets/Fodder.jpeg"
//     ];

//     return (index >= 0 && index < dairyIcons.length)
//         ? dairyIcons[index]
//         : ""; // Returns empty if index is invalid
//   }
// }

// class NearbyShopsScreen extends StatefulWidget {
//   const NearbyShopsScreen({super.key});

//   @override
//   _NearbyShopsScreenState createState() => _NearbyShopsScreenState();
// }

// class _NearbyShopsScreenState extends State<NearbyShopsScreen> {
//   GoogleMapController? _controller;
//   LatLng? _currentLocation;
//   final Set<Marker> _markers = {};

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }

//   Future<void> _getCurrentLocation() async {
//     try {
//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);
//       setState(() =>
//           _currentLocation = LatLng(position.latitude, position.longitude));
//       _controller?.animateCamera(CameraUpdate.newLatLng(_currentLocation!));
//       _fetchNearbyShops();
//     } catch (e) {
//       _showSnackbar("Error: ${e.toString()}");
//     } finally {}
//   }

//   Future<void> _fetchNearbyShops() async {
//     if (_currentLocation == null) return;

//     final url = Uri.parse("http://192.168.1.9:5003/find_shops");
//     try {
//       final response = await http
//           .post(
//             url,
//             headers: {'Content-Type': 'application/json'},
//             body: jsonEncode({
//               "latitude": _currentLocation!.latitude,
//               "longitude": _currentLocation!.longitude,
//             }),
//           )
//           .timeout(const Duration(seconds: 10));

//       if (response.statusCode == 200) {
//         List<dynamic> data = json.decode(response.body);
//         setState(() {
//           _markers.clear();
//           for (var shop in data) {
//             _markers.add(
//               Marker(
//                 markerId: MarkerId(shop["name"]),
//                 position: LatLng(shop["latitude"], shop["longitude"]),
//                 infoWindow: InfoWindow(
//                     title: shop["name"],
//                     snippet: "${shop["distance"]} km away"),
//               ),
//             );
//           }
//         });
//       }
//     } catch (e) {
//       _showSnackbar("Failed to fetch shops: ${e.toString()}");
//     } finally {}
//   }

//   void _showSnackbar(String message) {
//     if (mounted) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text(message)));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Nearby Shops")),
//       body: _currentLocation == null
//           ? const Center(child: CircularProgressIndicator())
//           : GoogleMap(
//               initialCameraPosition:
//                   CameraPosition(target: _currentLocation!, zoom: 14.0),
//               onMapCreated: (controller) => _controller = controller,
//               markers: _markers,
//               myLocationEnabled: true,
//               myLocationButtonEnabled: true,
//             ),
//     );
//   }
// }
