import 'package:flutter/material.dart';

class LakshmiDeviScreen extends StatefulWidget {
  const LakshmiDeviScreen({super.key});

  @override
  _LakshmiDeviScreenState createState() => _LakshmiDeviScreenState();
}

class _LakshmiDeviScreenState extends State<LakshmiDeviScreen> {
  String? _selectedProduct;
  String _price = '';
  String _quantity = '';
  String _description = '';
  final List<Map<String, String>> _listedItems = [];

  final List<String> _productNames = [
    'Cattles',
    'Containers',
    'Milk Coolers',
    'Packaging',
    'Transportation',
    'Fodder',
  ];

  final Map<String, String> _productImages = {
    'Cattles': 'assets/cattles.jpg',
    'Containers': 'assets/containers.jpg',
    'Milk Coolers': 'assets/milk_coolers.jpg',
    'Packaging': 'assets/packaging.jpg',
    'Transportation': 'assets/transportation.jpg',
    'Fodder': 'assets/fodder.jpg',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lakshmi Devi'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Profile Section
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/image23.jpg'),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Lakshmi Devi',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 16),
                        Text('Lakshmi dairies'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.phone, size: 16),
                        Text('9073845378'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),

            // Product Details Input
            DropdownButtonFormField<String>(
              value: _selectedProduct,
              items: _productNames.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedProduct = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Product name:',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              onChanged: (value) {
                setState(() {
                  _price = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Price:',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              onChanged: (value) {
                setState(() {
                  _quantity = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Quantity:',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Implement image upload logic here
              },
              child: Text('Upload image'),
            ),
            SizedBox(height: 10),
            TextField(
              onChanged: (value) {
                setState(() {
                  _description = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            // List Out Button
            ElevatedButton(
              onPressed: () {
                if (_selectedProduct != null) {
                  setState(() {
                    _listedItems.add({
                      'product': _selectedProduct!,
                      'price': _price,
                      'quantity': _quantity,
                      'description': _description,
                    });
                  });
                }
              },
              child: Text('+ List out'),
            ),
            SizedBox(height: 20),

            // Listed Items Display with Images
            Text('Your products',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _listedItems.map((item) {
                String product = item['product']!;
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Image.asset(
                      _productImages[product] ?? 'assets/image4.jpg',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(product),
                    subtitle: Text(
                        'Price: ₹${item['price']}, Quantity: ${item['quantity']}\n${item['description']}'),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),

            // Product Categories
            Text('Dairy Products',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('Avg cattle price - ₹42,500'),
            Text('Avg buffalo price - ₹48,000'),
            Text('Cattle & buffalo for sale - Healthy & high milk yield'),
            SizedBox(height: 10),

            Text('Livestock & Farming Supplies',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('Cattle feed - ₹1,150 per 50kg'),
            Text('Mineral mixture - ₹650 per 5kg'),
            Text('Premium silage bales - ₹400 per 20kg'),
            Text('Fodder seeds - ₹180 per kg'),
            SizedBox(height: 10),

            Text('Waste Management',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('Dried cow dung cakes - ₹50 per 10 pieces'),
            Text('Organic manure (Gobarkhad) - ₹300 per 25kg'),
          ],
        ),
      ),
    );
  }
}
