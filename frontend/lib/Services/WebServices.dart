import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:worldcup/Constants/Endpoints.dart';
import 'package:worldcup/Models/Reservation.dart';
import 'package:http/http.dart' as http;
import 'HTTPException.dart';

class WebServices {
  Future<void> signUp(
    String firstName,
    String lastName,
    String email,
    String userName,
    String password,
    String passwordConfirmation,
    String gender,
    String role,
    String dateOfBirth,
    String nationality,
  ) async {
    try {
      final response = await Dio().post(
        Constants.baseUrl + Constants.signUp,
        data: json.encode(
          {
            "email": email,
            "username": userName,
            "password": password,
            "passwordConfirm": passwordConfirmation,
            "gender": gender,
            "birthdate": dateOfBirth,
            "firstname": firstName,
            "lastname": lastName,
            "nationality": nationality,
            "role": role
          },
        ),
        options: Options(
          validateStatus: (_) {
            return true;
          },
        ),
      );
      if (response.statusCode != 200) {
        throw HTTPException(response.data['message']).toString();
      }
    } catch (error) {
      throw HTTPException(error).toString();
    }
  }

  Future<Map<String, dynamic>> signIn(String username, String password) async {
    try {
      final response = await Dio().post(
        Constants.baseUrl + Constants.signIn,
        data: json.encode(
          {
            "username": username,
            "password": password,
          },
        ),
        options: Options(
          validateStatus: (_) {
            return true;
          },
        ),
      );
      if (response.statusCode == 400) {
        throw HTTPException("Incorrect Username Or Password");
      } else if (response.statusCode == 401) {
        throw HTTPException("Not Accepted Yet");
      } else if (response.statusCode != 200) {
        throw HTTPException(response.data['message']);
      }
      return response.data;
    } catch (error) {
      throw HTTPException(error.toString());
    }
  }

  Future<List> fetchPendingUsers(String token) async {
    try {
      final response = await http.get(
        Constants.baseUrl + Constants.getPendingUsers,
        headers: {
          "Authorization": "Bearer " + token,
        },
      );
      if (response.statusCode != 200) {
        throw HTTPException(jsonDecode(response.body)['message']).toString();
      }
      return jsonDecode(response.body)['users'] as List;
    } catch (error) {
      throw HTTPException(error).toString();
    }
  }

  Future<List> fetchAllUsers(String token) async {
    try {
      final response = await http.get(
        Constants.baseUrl + Constants.getAllUsers,
        headers: {
          "Authorization": "Bearer " + token,
        },
      );
      if (response.statusCode != 200) {
        throw HTTPException(jsonDecode(response.body)).toString();
      }
      return jsonDecode(response.body)['data']['data'] as List;
    } catch (error) {
      throw HTTPException(error).toString();
    }
  }

  Future<bool> updatePending(
    String token,
    String userId,
    bool accepted,
  ) async {
    try {
      final response = await Dio().post(
        Constants.baseUrl + Constants.updatePending,
        options: Options(
          validateStatus: (_) {
            return true;
          },
          headers: {
            "Authorization": "Bearer " + token,
          },
        ),
        data: jsonEncode(
          {
            "id": userId,
            "active": accepted,
          },
        ),
      );
      if (response.statusCode != 200) {
        throw HTTPException(response.data['message']).toString();
      }
      return true;
    } catch (error) {
      throw HTTPException(error).toString();
    }
  }

  Future<bool> deleteUser(
    String token,
    String userId,
  ) async {
    try {
      final response = await Dio().post(
        Constants.baseUrl + Constants.deleteUser,
        options: Options(
          validateStatus: (_) {
            return true;
          },
          headers: {
            "Authorization": "Bearer " + token,
          },
        ),
        data: jsonEncode(
          {
            "id": userId,
          },
        ),
      );
      if (response.statusCode != 200) {
        throw HTTPException(response.data['message']).toString();
      }
      return true;
    } catch (error) {
      throw HTTPException(error).toString();
    }
  }

  Future<bool> updateAllPending(
    String token,
    bool accepted,
  ) async {
    try {
      final response = await Dio().post(
        Constants.baseUrl + Constants.updateAllPending,
        options: Options(
          validateStatus: (_) {
            return true;
          },
          headers: {
            "Authorization": "Bearer " + token,
          },
        ),
        data: jsonEncode(
          {
            "accepted": accepted,
          },
        ),
      );
      if (response.statusCode != 200) {
        throw HTTPException(response.data['message']).toString();
      }
      return true;
    } catch (error) {
      throw HTTPException(error).toString();
    }
  }

  Future<List<dynamic>> getTeams() async {
    try {
      final response = await Dio().get(
        Constants.baseUrl + Constants.getTeams,
        options: Options(
          validateStatus: (_) {
            return true;
          },
        ),
      );
      if (response.statusCode != 200) {
        throw HTTPException(response.data['message']);
      }

      return response.data['data']['data'];
    } catch (error) {
      throw HTTPException(error.toString());
    }
  }

  Future<List<dynamic>> getStadiums() async {
    try {
      final response = await Dio().get(
        Constants.baseUrl + Constants.getStadiums,
        options: Options(
          validateStatus: (_) {
            return true;
          },
        ),
      );
      if (response.statusCode != 200) {
        throw HTTPException(response.data['message']);
      }

      return response.data['data']['data'];
    } catch (error) {
      throw HTTPException(error.toString());
    }
  }

  Future<List> getAllMatches() async {
    try {
      final response = await http.get(
        Constants.baseUrl + Constants.getMatches,
      );
      if (response.statusCode != 200) {
        throw HTTPException(jsonDecode(response.body)['message']).toString();
      }
      return jsonDecode(response.body)['data']['data'] as List;
    } catch (error) {
      throw HTTPException(error.toString());
    }
  }

  Future<List> getAllReservations(String token) async {
    try {
      final response = await http.get(
        Constants.baseUrl + Constants.getReservations,
        headers: {
          "Authorization": "Bearer " + token,
        },
      );
      if (response.statusCode != 200) {
        throw HTTPException(jsonDecode(response.body)['message']).toString();
      }
      return jsonDecode(response.body)['data'] as List;
    } catch (error) {
      throw HTTPException(error.toString());
    }
  }

  Future<Map<String, dynamic>> addStadium(
      String name, int rows, int numberOfSeatsPerRow, String token) async {
    try {
      final response = await Dio().post(
        Constants.baseUrl + Constants.addStadium,
        data: json.encode(
          {
            "name": name,
            "rows": rows,
            "columns": numberOfSeatsPerRow,
          },
        ),
        options: Options(
          headers: {
            "Authorization": "Bearer " + token,
          },
          validateStatus: (_) {
            return true;
          },
        ),
      );
      if (response.statusCode != 200) {
        throw HTTPException(response.data['message']);
      }
      return response.data['data']['data'];
    } catch (error) {
      throw HTTPException(error.toString());
    }
  }

  Future<void> bookTickets(
      List<String> seatsIds, String token, String matchId) async {
    try {
      final response = await Dio().post(
        Constants.baseUrl + Constants.bookMatch,
        data: json.encode(
          {
            "seats": seatsIds,
            "match": matchId,
          },
        ),
        options: Options(
          headers: {
            "Authorization": "Bearer " + token,
          },
          validateStatus: (_) {
            return true;
          },
        ),
      );
      if (response.statusCode != 200) {
        throw HTTPException(response.data['message']);
      }
      return response.data;
    } catch (error) {
      throw HTTPException(error.toString());
    }
  }

  Future<void> signOut(String token) async {
    try {
      final response = await Dio().post(
        Constants.baseUrl + Constants.signOut,
        options: Options(
          headers: {
            "Authorization": "Bearer " + token,
          },
          validateStatus: (_) {
            return true;
          },
        ),
      );
      if (response.statusCode != 200) {
        throw HTTPException(response.data['message']);
      }
      return response.data;
    } catch (error) {
      throw HTTPException(error.toString());
    }
  }

  Future<void> cancelReservation(Reservation reservation, String token) async {
    try {
      final response = await Dio().post(
        Constants.baseUrl + Constants.cancelReservation,
        data: json.encode(
          {
            "reservationId": reservation.id,
          },
        ),
        options: Options(
          headers: {
            "Authorization": "Bearer " + token,
          },
          validateStatus: (_) {
            return true;
          },
        ),
      );

      if (response.statusCode != 200) {
        throw HTTPException(response.data['message']);
      }
      return response.data;
    } catch (error) {
      throw HTTPException(error.toString());
    }
  }

  Future<void> addMatch(
      String homeTeam,
      String awayTeam,
      String matchVenue,
      String mainReferee,
      String linesman1,
      String linesman2,
      String date,
      String time,
      String token) async {
    try {
      final response = await Dio().post(
        Constants.baseUrl + Constants.addMatch,
        data: json.encode(
          {
            "firstTeam": homeTeam,
            "secondTeam": awayTeam,
            "stadium": matchVenue,
            "startDate": date,
            "startTime": time,
            "mainReferee": mainReferee,
            "firstLineman": linesman1,
            "secondLineman": linesman2,
          },
        ),
        options: Options(
          headers: {
            "Authorization": "Bearer " + token,
          },
          validateStatus: (_) {
            return true;
          },
        ),
      );
      if (response.statusCode != 200) {
        throw HTTPException(response.data['message']);
      }
    } catch (error) {
      throw HTTPException(error.toString());
    }
  }

  Future<void> changePassword(
    String oldPassword,
    String newPassword,
    String confirmPassword,
    String token,
  ) async {
    try {
      final response = await Dio().post(
        Constants.baseUrl + Constants.changePassword,
        data: json.encode(
          {
            "passwordCurrent": oldPassword,
            "password": newPassword,
            "passwordConfirm": newPassword,
          },
        ),
        options: Options(
          headers: {
            "Authorization": "Bearer " + token,
          },
          validateStatus: (_) {
            return true;
          },
        ),
      );
      if (response.statusCode != 200) {
        throw HTTPException(response.data['message']);
      }
    } catch (error) {
      throw HTTPException(error.toString());
    }
  }

  Future<void> editProfile(
    String firstName,
    String lastName,
    String dateOfBirth,
    String gender,
    String nationality,
    String token,
  ) async {
    try {
      final response = await Dio().post(
        Constants.baseUrl + Constants.editProfile,
        data: json.encode(
          {
            "firstName": firstName,
            "lastName": lastName,
            "birthdate": dateOfBirth,
            "gender": gender,
            "nationality": nationality,
          },
        ),
        options: Options(
          headers: {
            "Authorization": "Bearer " + token,
          },
          validateStatus: (_) {
            return true;
          },
        ),
      );
      if (response.statusCode != 200) {
        throw HTTPException(response.data['message']);
      }
    } catch (error) {
      throw HTTPException(error.toString());
    }
  }

  Future<void> editMatch(
      String matchVenue,
      String linesman1,
      String linesman2,
      String mainReferee,
      String date,
      String time,
      String id,
      String token) async {
    try {
      final response = await Dio().post(
        Constants.baseUrl + Constants.editMatch,
        data: json.encode(
          {
            "stadium": matchVenue,
            "firstLineman": linesman1,
            "secondLineman": linesman2,
            "mainReferee": mainReferee,
            "startTime": time,
            "startDate": date,
            "_id": id,
          },
        ),
        options: Options(
          headers: {
            "Authorization": "Bearer " + token,
          },
          validateStatus: (_) {
            return true;
          },
        ),
      );
      if (response.statusCode != 200) {
        throw HTTPException(response.data['message']);
      }
    } catch (error) {
      throw HTTPException(error.toString());
    }
  }

  Future<Map<String, dynamic>> fetchMyProfile(String token) async {
    try {
      final response = await http.get(
        Constants.baseUrl + Constants.getProfile,
        headers: {
          "Authorization": "Bearer " + token,
        },
      );
      if (response.statusCode != 200) {
        throw HTTPException(jsonDecode(response.body)['message']).toString();
      }
      return jsonDecode(response.body);
    } catch (error) {
      throw HTTPException(error).toString();
    }
  }
}
