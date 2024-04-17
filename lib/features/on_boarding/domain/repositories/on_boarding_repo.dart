
abstract class OnBoardingRepo{
  const OnBoardingRepo();
  Future<void> cacheFirstTimer();
  Future<bool> checkIfUserIsFirstTimer();
}