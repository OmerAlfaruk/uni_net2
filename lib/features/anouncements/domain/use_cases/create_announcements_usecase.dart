import 'package:uni_link/features/anouncements/domain/entities/anouncements.dart';
import 'package:uni_link/features/anouncements/domain/repositories/announcement_repository.dart';

class CreateAnnouncementsUseCase {
  final AnnouncementRepository repository;

  CreateAnnouncementsUseCase({required this.repository});

  Future<void> call(AnnouncementsEntity news) {
    return repository.createAnnouncements(news);
  }
}