import 'package:tracking_app/features/home/domain/repositories/home_repository.dart';



/// use case is a class responsible for encapsulating a specific piece of business logic or 
/// a particular operation that your application needs to perform.
/// It acts as a bridge between the presentation
/// layer and the data layer.
class HomeUseCase {
	  
   final HomeRepository homeRepository;
   HomeUseCase(this.homeRepository);
}