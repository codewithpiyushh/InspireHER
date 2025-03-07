// import 'package:flutter/material.dart';

// class CategoryScreen extends StatelessWidget {
//   final String category;
//   final String businessType;

//   const CategoryScreen({
//     super.key,
//     required this.category,
//     required this.businessType,
//   });

//   @override
//   Widget build(BuildContext context) {
//     List<Map<String, String>> suppliers = _getSuppliersForCategory(category);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('$businessType - $category Suppliers'),
//         backgroundColor: Colors.blue,
//       ),
//       body: ListView.builder(
//         itemCount: suppliers.length,
//         itemBuilder: (context, index) {
//           return Card(
//             child: ListTile(
//               leading: Container(
//                 width: 60,
//                 height: 60,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage(suppliers[index]['image']!),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               title: Text(
//                 suppliers[index]['name']!,
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text(suppliers[index]['description']!),
//               trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//               onTap: () {
//                 showModalBottomSheet(
//                   context: context,
//                   isScrollControlled: true,
//                   shape: const RoundedRectangleBorder(
//                     borderRadius:
//                         BorderRadius.vertical(top: Radius.circular(20)),
//                   ),
//                   builder: (context) {
//                     return DraggableScrollableSheet(
//                       expand: false,
//                       builder: (context, scrollController) {
//                         return SingleChildScrollView(
//                           controller: scrollController,
//                           child: Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   suppliers[index]['name']!,
//                                   style: const TextStyle(
//                                     fontSize: 24,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 10),
//                                 Container(
//                                   height: 200,
//                                   width: double.infinity,
//                                   decoration: BoxDecoration(
//                                     image: DecorationImage(
//                                       image: AssetImage(
//                                           suppliers[index]['image']!),
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 10),
//                                 const Text(
//                                   'Description',
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 Text(suppliers[index]['description']!),
//                                 const SizedBox(height: 20),
//                                 ElevatedButton(
//                                   onPressed: () {
//                                     // Add supplier contact action
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: const Color(0xFF1A237E),
//                                   ),
//                                   child: const Text(
//                                     'Contact Supplier',
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
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

//   // Function to get suppliers based on category
//   List<Map<String, String>> _getSuppliersForCategory(String category) {
//     Map<String, List<Map<String, String>>> supplierData = {
//       "Cattles": [
//         {
//           "name": "Suresh Cattle",
//           "image": "assets/cattles1.jpeg",
//           "description": "Leading supplier of electronic goods."
//         },
//         {
//           "name": "Mahesh Cattles",
//           "image": "assets/cattles2.jpeg",
//           "description": "Best quality gadgets at affordable prices."
//         },
//       ],
//       "Containers": [
//         {
//           "name": "Fashion Trends",
//           "image": "assets/containers1.jpeg",
//           "description": "Stylish and trendy clothing supplier."
//         },
//         {
//           "name": "WearWell Ltd.",
//           "image": "assets/containers2.jpeg",
//           "description": "Quality fabrics for all seasons."
//         },
//       ],
//       "Milk Coolers": [
//         {
//           "name": "HomeStyle Furnishings",
//           "image": "assets/coolers1.jpeg",
//           "description": "Elegant and durable furniture."
//         },
//         {
//           "name": "WoodCrafters",
//           "image": "assets/coolers2.jpeg",
//           "description": "Handcrafted wooden furniture."
//         },
//       ],
//       "Transportation": [
//         {
//           "name": "HomeStyle Furnishings",
//           "image": "assets/Transportation1.jpeg",
//           "description": "Elegant and durable furniture."
//         },
//         {
//           "name": "WoodCrafters",
//           "image": "assets/Transportation2.jpeg",
//           "description": "Handcrafted wooden furniture."
//         },
//       ],
//       "Fooder": [
//         {
//           "name": "HomeStyle Furnishings",
//           "image": "assets/Fooder1.jpeg",
//           "description": "Elegant and durable furniture."
//         },
//         {
//           "name": "WoodCrafters",
//           "image": "assets/Fooder2.jpeg",
//           "description": "Handcrafted wooden furniture."
//         },
//       ],
//     };

//     return supplierData[category] ?? [];
//   }
// }
