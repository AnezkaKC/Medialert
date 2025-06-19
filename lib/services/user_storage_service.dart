// lib/services/user_storage_service.dart
import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb; // Importante para detectar si es web
import 'dart:io' show File; // Solo se importa para plataformas no web
import 'package:path_provider/path_provider.dart'; // Para Android/iOS/Desktop
import 'package:shared_preferences/shared_preferences.dart'; // Para Web
import '../models/user.dart';

class UserStorageService {
  // Para path_provider (nativa)
  static const String _fileName = 'users.json';
  // Para shared_preferences (web)
  static const String _usersSharedPreferencesKey = 'users_data';

  // --- Métodos de acceso al archivo/prefs según la plataforma ---

  // Obtiene el contenido del JSON como string, sea de archivo o de SharedPreferences
  Future<String?> _getUsersJsonString() async {
    if (kIsWeb) {
      // Lógica para Web (shared_preferences)
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_usersSharedPreferencesKey);
    } else {
      // Lógica para Plataformas Nativas (path_provider)
      try {
        final directory = await getApplicationDocumentsDirectory();
        final file = File('${directory.path}/$_fileName');
        if (!await file.exists()) {
          print("Archivo de usuario no existe en el sistema de archivos nativo.");
          return null;
        }
        return await file.readAsString();
      } catch (e) {
        print("Error al leer el archivo de usuarios nativo: $e");
        return null;
      }
    }
  }

  // Guarda el string JSON en archivo o SharedPreferences
  Future<void> _saveUsersJsonString(String jsonString) async {
    if (kIsWeb) {
      // Lógica para Web (shared_preferences)
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_usersSharedPreferencesKey, jsonString);
      print("Usuarios guardados exitosamente en SharedPreferences (Web).");
    } else {
      // Lógica para Plataformas Nativas (path_provider)
      try {
        final directory = await getApplicationDocumentsDirectory();
        final file = File('${directory.path}/$_fileName');
        await file.writeAsString(jsonString);
        print("Usuarios guardados exitosamente en $_fileName (Nativo).");
      } catch (e) {
        print("Error al guardar usuarios en el archivo nativo: $e");
      }
    }
  }

  // --- Métodos principales (readUsers, saveUsers, registerUser, authenticateUser) ---

  // Reads all users
  Future<List<User>> readUsers() async {
    try {
      final usersJsonString = await _getUsersJsonString();
      if (usersJsonString == null || usersJsonString.isEmpty) {
        return [];
      }
      final List<dynamic> jsonList = jsonDecode(usersJsonString);
      return jsonList.map((json) => User.fromJson(json)).toList();
    } catch (e) {
      print("Error al decodificar JSON de usuarios: $e");
      return [];
    }
  }

  // Saves a list of users
  Future<void> saveUsers(List<User> users) async {
    final List<Map<String, dynamic>> jsonList = users.map((user) => user.toJson()).toList();
    final String jsonString = jsonEncode(jsonList);
    await _saveUsersJsonString(jsonString);
  }

  // Adds a new user, ensuring uniqueness by email
  Future<bool> registerUser(User newUser) async {
    List<User> existingUsers = await readUsers();

    if (existingUsers.any((user) => user.email == newUser.email)) {
      print("Registro fallido: El correo electrónico '${newUser.email}' ya existe.");
      return false;
    }

    existingUsers.add(newUser);
    await saveUsers(existingUsers);
    return true;
  }

  // Authenticates a user by email and password
  Future<User?> authenticateUser(String email, String password) async {
    List<User> users = await readUsers();
    try {
      User? foundUser = users.firstWhere(
        (user) => user.email == email && user.password == password,
      );
      print("Usuario con correo electrónico '${foundUser.email}' autenticado exitosamente.");
      return foundUser;
    } catch (e) {
      print("Autenticación fallida: Correo electrónico o contraseña inválidos para '$email'.");
      return null;
    }
  }
}