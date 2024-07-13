import 'dart:convert';
import 'package:http/http.dart' as http;

class TimbuApi {
  final String apiKey = 'e4ad902aa1bf43839911a3c02ab2e82020240708072159806930';
  final String appId = 'RPEC1OTF2R16R5M';
  final String organizationId = '2aa362aa6f7c46158731de4c7af18790';
  final String baseUrl = 'https://api.timbu.cloud/products';
  final String imageBaseUrl = 'https://api.timbu.cloud/images/';

  Future<List<Products>> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse(
            '$baseUrl?organization_id=$organizationId&Appid=$appId&Apikey=$apiKey'),
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> productsJson = json.decode(response.body);
        if (productsJson.containsKey('items') &&
            productsJson['items'] is List) {
          final List<dynamic> productlist = productsJson['items'];
          return productlist
              .map((json) => Products.fromJson(json, imageBaseUrl))
              .toList();
        } else {
          throw Exception('Invalid or missing "items" field in response');
        }
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error fetching products: $e');
      rethrow;
    }
  }
}

class Products {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final price;
  final double quantity;
  bool available;

  Products(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.description,
      required this.price,
      required this.quantity,
      required this.available});

  factory Products.fromJson(Map<String, dynamic> json, String imageBaseUrl) {
    String extractImageUrl(List<dynamic> photos) {
      if (photos.isNotEmpty) {
        final url = photos.firstWhere((photo) => photo['url'] != null,
            orElse: () => null)?['url'];
        return url != null
            ? imageBaseUrl + url
            : 'https://placehold.co/600x400/png';
      }
      return 'https://placehold.co/600x400/png';
    }

    double extractPrice(List<dynamic>? currentPrice) {
      if (currentPrice != null && currentPrice.isNotEmpty) {
        final priceMap = currentPrice.firstWhere(
          (price) => price is Map<String, dynamic> && price.containsKey('NGN'),
          orElse: () => null,
        );
        if (priceMap != null && priceMap['NGN'] is List) {
          final priceList = priceMap['NGN'] as List;
          final nonNullPrice = priceList.firstWhere(
            (price) => price != null && price is num,
            orElse: () => 0.00,
          );
          return (nonNullPrice as num).toDouble();
        }
      }
      return 0.00;
    }

    return Products(
        id: json['unique_id'],
        name: json['name'],
        imageUrl: extractImageUrl(json['photos']),
        description: json['description'] ?? 'No Description',
        price: extractPrice(json['current_price']),
        quantity: json['available_quantity'],
        available: json['is_available']);
  }
}
