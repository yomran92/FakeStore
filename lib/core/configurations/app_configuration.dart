

class AppConfigurations {

  static String BaseUrl = 'https://fakestoreapi.com/';
   static int PageSize = 4;
   static int ListLimit = 20;

  static const Map<String, String> BaseHeaders = {
    'accept': 'text/plain',
    'Content-Type': 'application/json',
  };

 }
enum RequestType { GET, POST, PUT, DELETE, PATCH }
