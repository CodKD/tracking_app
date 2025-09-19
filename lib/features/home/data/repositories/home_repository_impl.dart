import 'package:tracking_app/features/home/domain/repositories/home_repository.dart';
import 'package:tracking_app/features/home/data/data_sources/home_data_source.dart';



/// HomeRepositoryImpl is the concrete implementation of the HomeRepository
/// interface.
/// This class implements the methods defined in HomeRepository to interact
/// with data. It acts as a bridge between the domain layer
/// (use cases) and the data layer (data sources).
class HomeRepositoryImpl implements HomeRepository {
      
   final HomeDataSource  homeDataSource;
   HomeRepositoryImpl(this.homeDataSource);
}