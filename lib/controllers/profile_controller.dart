import '../models/driver_model.dart';
import '../services/profile_service.dart';

class ProfileController {
  final ProfileService _profileService = ProfileService();

  Future<void> saveProfile(Driver driver) async {
    await _profileService.saveDriverProfile(driver);
  }
}
