import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:http/http.dart' as http;
import '../../data/models/products_model.dart';

class ProductController extends GetxController {
  List<Product>? products;
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse('https://fakestoreapi.com/products'),
      );
      debugPrint("Fetching...");

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // If the server returns a 200 OK response, parse the products.
        List<dynamic> data = jsonDecode(response.body);
        products = data.map((json) => Product.fromJson(json)).toList();
        debugPrint("Products: ${products!.length}");
        return products!;
      } else {
        // If the server did not return a 200 OK response,
        // throw an exception.
        throw Exception('Failed to load products');
      }
    } catch (error) {
      // Handle any errors that occurred during the HTTP request.
      debugPrint('Error fetching products: $error');
      throw Exception('Failed to fetch products');
    }
  }
}
