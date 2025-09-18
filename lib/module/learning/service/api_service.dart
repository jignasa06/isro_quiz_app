import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/centre_model.dart';
import '../model/customer_satellite_model.dart';
import '../model/launcher_model.dart';
import '../model/spacecraft_model.dart';

class ApiService {
  final String baseUrl = "https://isro.vercel.app/api";

  Future<List<Spacecraft>> fetchSpacecrafts() async {
    final response = await http.get(Uri.parse("$baseUrl/spacecrafts"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['spacecrafts'] as List)
          .map((e) => Spacecraft.fromJson(e))
          .toList();
    } else {
      throw Exception("Failed to load spacecrafts");
    }
  }

  Future<List<Launcher>> fetchLaunchers() async {
    final response = await http.get(Uri.parse("$baseUrl/launchers"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['launchers'] as List)
          .map((e) => Launcher.fromJson(e))
          .toList();
    } else {
      throw Exception("Failed to load launchers");
    }
  }

  Future<List<CustomerSatellite>> fetchCustomerSatellites() async {
    final response = await http.get(Uri.parse("$baseUrl/customer_satellites"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['customer_satellites'] as List)
          .map((e) => CustomerSatellite.fromJson(e))
          .toList();
    } else {
      throw Exception("Failed to load customer satellites");
    }
  }

  Future<List<Centre>> fetchCentres() async {
    final response = await http.get(Uri.parse("$baseUrl/centres"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['centres'] as List).map((e) => Centre.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load centres");
    }
  }
}
