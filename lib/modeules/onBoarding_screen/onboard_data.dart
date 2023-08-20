class OnBoarding {
  final String title;
  final String image;
  final String desc;

  OnBoarding({
    required this.title,
    required this.desc,
    required this.image,
  });
}

List<OnBoarding> onboardingContents = [
  OnBoarding(
    title: 'Consult a Doctor',
    image: 'assets/lottie/onBoard1.json',
    desc: 'Talk to the pharmacist and consult the doctor about your medication by sending picture of the prescription'
  ),
  OnBoarding(
    title: 'Buy Drugs online ',
    image: 'assets/lottie/onBoard3.json',
      desc: 'Buy Original Drugs and Other Medical items of Different Category from your Home online'
  ),
  OnBoarding(
    title: 'Pharmacy ALl The Time',
    image: 'assets/lottie/onBoard2.json',
      desc: 'Discover Pharmacies around you 24 hour service Order what you want at any time '
  ),

];
