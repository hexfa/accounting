
import 'package:accounting/gen/assets.gen.dart';

class SplashItem {
  final String title;
  final int id;
  final String imgUrl;
  final String description;

  SplashItem({
    required this.title,
    required this.imgUrl,
    required this.description,
    required this.id,
  });
}
final List<SplashItem> splashItems = [
  SplashItem(
    id: 1,
    imgUrl: Assets.images.sp1.path,
    title: 'Plan Your Day',
    description: 'Create a clear roadmap for your day with \neasy task creation and categorization.',
  ),

  SplashItem(
    id: 2,
    imgUrl: Assets.images.sp2.path,
    title: 'Stay on Track',
    description: 'Set reminders and deadlines to ensure \nyou never miss an important task.',
  ),

  SplashItem(
    id: 3,
    imgUrl: Assets.images.sp3.path,
    title: 'Achieve More',
    description: 'Track your progress and celebrate your \nachievements as you complete tasks.',
  ),

];

