import 'package:flutter/material.dart';

class ShoppingBagScreen extends StatefulWidget {
  const ShoppingBagScreen({super.key});

  @override
  State<ShoppingBagScreen> createState() => _ShoppingBagScreenState();
}

class _ShoppingBagScreenState extends State<ShoppingBagScreen> {
  // Mock data based on the HTML provided
  final List<Map<String, dynamic>> _items = [
    {
      'title': 'Silk Slip Dress',
      'variant': 'Onyx / Small',
      'price': 450.00,
      'quantity': 1,
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuCZjpqA9u4ieaL1JnzzjEW0QGSFqjCkTX45zA_uTRj3uZ1s9DvVv-wsEesYiclzVEFd4nRcuVAMPhdcCOHq2iyQusItnivZ3LxyZdCwB5-sfsG9cWTFmTAQ0Bq8leBqXmBrbKKlcYdyFd1p_1pipTVBmk4X5QDB7eEd5IYtjO_z1HP_MseH6_rwRGXV3NVoZ5K7nF22rEjnJwBFU4G0Ov6YJjI78bmuvfhAiJ_lSqbRAxx8l_q-HUsUMak-WVdbnDZDHpHbrHpfvMw',
    },
    {
      'title': 'Cashmere Cardigan',
      'variant': 'Pearl / Medium',
      'price': 890.00,
      'quantity': 1,
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBh-BRaQ7XibHKdvgUPXeGdo-e38KVbFnz8a58d__37yQH3sSVwzVLcv2yYyTifzplm34FhLskvPDa7Hdc7oJgPRHK5Dd40lBgY5HnIGRgeTjnS_9n0E9LvNinJV7-7lvdMHR58-xzXkbZAz2mFsenNuDT2SfMiNwJ5gnRWZaYZuvlXPtwnkkeeoDhxE3-Gl6kJV5LQ_9dih0dpokap-TIDSCIrS2jTkISKd2yorqduZSIWwvEbnsm9SXdynZWsRcTnnmEJvWsfSlc',
    },
    {
      'title': 'Leather Tote',
      'variant': 'Noir / One Size',
      'price': 1200.00,
      'quantity': 1,
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuCN047ydhAf8icCXWCNnEylyXyPU2huq0a5oDi4YGS7GnSiFYX-iEYBpL-ePTvb5-0AcCl9Ox9v8j2pKcKOOPSMlbFri1oxLXo3WGR6FWono8IzpGWoNiajEVOOtE2LtFSz0zAjVJMDyjDBBKl2v1jHEjb9lAkAax34C1S7HWXFVlYZITe1HTBm8JwzeO4XM9r-VGqfOOQI-AUrOAXQlOzMQug0jqKOwd_KfKQrwTNOcd8E6Xh9_ORSXctyP3mbT3jspvaNMeuKT2k',
    },
  ];

  void _incrementQuantity(int index) {
    setState(() {
      _items[index]['quantity']++;
    });
  }

  void _decrementQuantity(int index) {
    setState(() {
      if (_items[index]['quantity'] > 1) {
        _items[index]['quantity']--;
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  double get _subtotal {
    return _items.fold(0, (sum, item) => sum + (item['price'] * item['quantity']));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF0F172A); // slate-900
    final subTextColor = isDark ? Colors.grey[400] : const Color(0xFF64748B); // slate-500
    final borderColor = isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9); // slate-800 : slate-100

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Icon(Icons.arrow_back, color: textColor),
                  ),
                  Text(
                    'BAG',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Icon(Icons.more_horiz, color: textColor),
                  ),
                ],
              ),
            ),

            // Content Area
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  // Section Header
                  Container(
                    padding: const EdgeInsets.only(top: 16, bottom: 32),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: borderColor)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Your Selection',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          '${_items.length} ITEMS',
                          style: TextStyle(
                            color: subTextColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Items List
                  ..._items.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: borderColor)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image
                          Container(
                            width: 96,
                            height: 128, // Aspect ratio 3:4 approx
                            decoration: BoxDecoration(
                              color: isDark ? Colors.grey[900] : Colors.grey[100],
                              image: DecorationImage(
                                image: NetworkImage(item['image']),
                                fit: BoxFit.cover,
                                // Adding grayscale filter to match the "grayscale" class in HTML
                                colorFilter: const ColorFilter.mode(
                                  Colors.grey,
                                  BlendMode.saturation,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 24),
                          // Details
                          Expanded(
                            child: SizedBox(
                              height: 128,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Top part: Title, Close
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              item['title'].toString().toUpperCase(),
                                              style: TextStyle(
                                                color: textColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () => _removeItem(index),
                                            child: Icon(Icons.close, color: subTextColor, size: 20),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        item['variant'].toString().toUpperCase(),
                                        style: TextStyle(
                                          color: subTextColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Bottom part: Qty, Price
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      // Quantity Selector
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: isDark ? Colors.grey[800]! : Colors.grey[200]!),
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        child: Row(
                                          children: [
                                            InkWell(
                                              onTap: () => _decrementQuantity(index),
                                              child: Icon(Icons.remove, size: 16, color: textColor),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16),
                                              child: Text(
                                                '${item['quantity']}',
                                                style: TextStyle(
                                                  color: textColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () => _incrementQuantity(index),
                                              child: Icon(Icons.add, size: 16, color: textColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Price
                                      Text(
                                        '\$${(item['price'] * item['quantity']).toStringAsFixed(2)}',
                                        style: TextStyle(
                                          color: textColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: -0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),

                  // Promotion
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: textColor)),
                      ),
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'PROMO CODE',
                                hintStyle: TextStyle(
                                  color: subTextColor,
                                  fontSize: 12,
                                  letterSpacing: 2.0,
                                ),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                              style: TextStyle(
                                color: textColor,
                                fontSize: 12,
                                letterSpacing: 2.0,
                              ),
                            ),
                          ),
                          Text(
                            'APPLY',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Footer Summary
            Container(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: borderColor)),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Subtotal
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'SUBTOTAL',
                        style: TextStyle(
                          color: subTextColor,
                          fontSize: 12,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        '\$${_subtotal.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: subTextColor,
                          fontSize: 12,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Shipping
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'SHIPPING',
                        style: TextStyle(
                          color: subTextColor,
                          fontSize: 12,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        'COMPLIMENTARY',
                        style: TextStyle(
                          color: subTextColor,
                          fontSize: 12,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Total
                  Container(
                    padding: const EdgeInsets.only(top: 12),
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: isDark ? Colors.grey[900]! : Colors.grey[50]!)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'TOTAL',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                          ),
                        ),
                        Text(
                          '\$${_subtotal.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Checkout Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'PROCEED TO CHECKOUT',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24), // Bottom padding
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
