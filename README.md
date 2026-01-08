A responsive Flutter e-commerce app built with Clean Architecture and Bloc, using the FakeStore API
//////////////////////////////////////////////////////////////
Responsive Design
  - flutter_screenutil for scaling UI across devices.
  - Flexible layouts: Row, Column, Expanded, GridView.
//////////////////////////////////////////////////////////////
Clean Architecture with three layers:
  - Presentation: Blocs (ProductBloc, ProductDetailBloc,CategoryBloc,CartBloc), pages, widgets.
  - Domain: Entities, use cases, repository interfaces. 
  - Data: Remote (Dio),  models, repository implementations.
//////////////////////////////////////////////////////////////
 
## � Demo

You can download the APK for testing from the following location:

- [Download APK](demo/app-release.apk) *(Place your generated APK in the `/demo` directory)*

## ⚙️ App Configuration
- **PageSize**: Set to `5` by default. Controls the number of products fetched per page during pagination.
- **ListLimit**: Set to `20` by default. Defines the maximum number of items to be loaded in the list.
