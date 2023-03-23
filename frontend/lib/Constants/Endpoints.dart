class Constants {
  static String baseUrl = "https://tazkarti-clone.onrender.com/api/v1";
  static String signUp = "/users/signup";
  static String signIn = "/users/login";
  static String signOut = "/users/logout";
  static String changePassword = "/users/updateMyPassword";
  static String getPendingUsers = "/users/pendingUsers";
  static String getAllUsers = "/users";
  static String updatePending = "/users/updatePending";
  static String updateAllPending = "/users/updateAllPending";
  static String deleteUser = "/users/deleteUser";
  static String addStadium = "/stadiums";
  static String addMatch = "/matches";
  static String editMatch = "/matches/editMatch";
  static String getTeams = "/teams";
  static String getMatches = "/matches";
  static String getStadiums = "/stadiums";
  static String getReservations = "/users/myReservations";
  static String cancelReservation = "/bookings/cancelBooking";
  static String bookMatch = "/bookings";
  static String editProfile = "/users/updateMe";
  static String getProfile = "/users/me";
}

enum Status {
  loading,
  success,
  failed,
  empty,
}
