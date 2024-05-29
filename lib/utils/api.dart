class Api {
  static const String baseUrl = 'https://103.193.74.150';

  // Visitors
  static const String getVisitors = '$baseUrl/maxsociety/visitors';
  static const String getVisitorsById = '$baseUrl/maxsociety/visitors/';
  static const String getVisitorsByMobileNo =
      '$baseUrl/maxsociety/visitors/mobileNo/';
  static const String createVisitor = '$baseUrl/maxsociety/visitors';
  static const String updateVisitors = '$baseUrl/maxsociety/visitors/';
  static const String deleteVisitors = '$baseUrl/maxsociety/visitors/';

  // Visitor Log
  static const String getVisitorLogs = '$baseUrl/maxsociety/visitorLogs';
  static const String getVisitorsLogsById = '$baseUrl/maxsociety/visitorLogs/';
  static const String getVisitorsLogsByVisitorId =
      '$baseUrl/maxsociety/visitorLogs/visitor/';
  static const String getVisitorsLogsByMobileNo =
      '$baseUrl/maxsociety/visitorLogs/mobileNo/';
  static const String createVisitorLogs = '$baseUrl/maxsociety/visitorLogs';
  static const String updateVisitorLogs = '$baseUrl/maxsociety/visitorLogs/';
  static const String deleteVisitorLog = '$baseUrl/maxsociety/visitorLogs/';
}
