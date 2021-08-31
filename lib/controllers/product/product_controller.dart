import 'package:get/get.dart';
import 'package:skitoboxes/models/box.dart';

class ProductController extends GetxController {
  var favoriteBoxes = <Box>[].obs;
  List<Box> boxesList = [
    Box(
      id: 1,
      name: 'FabFitFun',
      image:
          'https://specials-images.forbesimg.com/imageserve/605b86dfdb1f21935c430522/Angled-view-of-orange-Bokksu-subscription-box-surrounded-by-various-snacks-/960x0.jpg?fit=scale',
      price: 3000,
      category: Category.Beauty,
      description:
          'FabFitFun ships you trendy lifestyle items each quarter that are themed for the season.',
      items: [
        'Item 1',
        'Item 2',
        'Item 3',
        'Item 4',
      ],
    ),
    Box(
      id: 2,
      name: 'Every Plate',
      image:
          'https://specials-images.forbesimg.com/imageserve/605b86dfdb1f21935c430522/Angled-view-of-orange-Bokksu-subscription-box-surrounded-by-various-snacks-/960x0.jpg?fit=scale',
      price: 1300,
      category: Category.Snacks,
      description:
          'Every Plate wants to take the stress out of meal planning for you with its delicious and affordable rotating weekly menu of 13 mouthwatering recipes.',
      items: [
        'Item 1',
        'Item 2',
        'Item 3',
        'Item 4',
      ],
    ),
    Box(
      id: 3,
      name: 'Breo Box',
      image:
          'https://specials-images.forbesimg.com/imageserve/605b86dfdb1f21935c430522/Angled-view-of-orange-Bokksu-subscription-box-surrounded-by-various-snacks-/960x0.jpg?fit=scale',
      price: 2200,
      category: Category.Snacks,
      description:
          'Breo Box is for people who love technology and can\'t resist stocking up on cool gadgets.',
      items: [
        'Item 1',
        'Item 2',
        'Item 3',
        'Item 4',
      ],
    ),
    Box(
      id: 4,
      name: 'Blueland',
      image:
          'https://specials-images.forbesimg.com/imageserve/605b86dfdb1f21935c430522/Angled-view-of-orange-Bokksu-subscription-box-surrounded-by-various-snacks-/960x0.jpg?fit=scale',
      price: 800,
      category: Category.Snacks,
      description:
          'Blueland helps you say bye-bye to plastic with reusable bottles and nifty cleaning tablets that dissolve in water. Now, you can clean your house and help the planet at the same time.',
      items: [
        'Item 1',
        'Item 2',
        'Item 3',
        'Item 4',
      ],
    ),
    Box(
      id: 5,
      name: 'Hunt A Killer',
      image:
          'https://specials-images.forbesimg.com/imageserve/605b86dfdb1f21935c430522/Angled-view-of-orange-Bokksu-subscription-box-surrounded-by-various-snacks-/960x0.jpg?fit=scale',
      price: 1500,
      category: Category.Health,
      description:
          'Hunt A Killer lets you channel your inner detective by giving you the chance to solve a crime.',
      items: [
        'Item 1',
        'Item 2',
        'Item 3',
        'Item 4',
      ],
    ),
    Box(
      id: 6,
      name: 'KnitCrate',
      image:
          'https://specials-images.forbesimg.com/imageserve/605b86dfdb1f21935c430522/Angled-view-of-orange-Bokksu-subscription-box-surrounded-by-various-snacks-/960x0.jpg?fit=scale',
      price: 6000,
      category: Category.Fashion,
      description:
          'KnitCrate is for fiber artists who are hooked on leveling up their craft each month.',
      items: [
        'Item 1',
        'Item 2',
        'Item 3',
        'Item 4',
      ],
    ),
    Box(
      id: 7,
      name: 'SinglesSwag',
      image:
          'https://specials-images.forbesimg.com/imageserve/605b86dfdb1f21935c430522/Angled-view-of-orange-Bokksu-subscription-box-surrounded-by-various-snacks-/960x0.jpg?fit=scale',
      price: 1000,
      category: Category.SelfCare,
      description:
          'SinglesSwag wants you to treat \'yo self with a collection of goodies geared towards self-care and self-love.',
      items: [
        'Item 1',
        'Item 2',
        'Item 3',
        'Item 4',
      ],
    ),
    Box(
      id: 8,
      name: 'Short Story Box ',
      image:
          'https://specials-images.forbesimg.com/imageserve/605b86dfdb1f21935c430522/Angled-view-of-orange-Bokksu-subscription-box-surrounded-by-various-snacks-/960x0.jpg?fit=scale',
      price: 4000,
      category: Category.Fashion,
      description:
          'Short Story Box makes finding clothes that *actually* fit a little easier if you\'re 5\'4" or under. You\'ll even be able to take a quiz to let your stylist know which clothing items you have the most trouble finding the right fit for.',
      items: [
        'Item 1',
        'Item 2',
        'Item 3',
        'Item 4',
      ],
    ),
    Box(
      id: 9,
      name: 'Toy Box Monthly ',
      image:
          'https://specials-images.forbesimg.com/imageserve/605b86dfdb1f21935c430522/Angled-view-of-orange-Bokksu-subscription-box-surrounded-by-various-snacks-/960x0.jpg?fit=scale',
      price: 2500,
      category: Category.Stationery,
      description:
          'Toy Box Monthly gives your kids something to look forward to by sending them their own little box of toys each month.',
      items: [
        'Item 1',
        'Item 2',
        'Item 3',
        'Item 4',
      ],
    ),
    Box(
      id: 10,
      name: ' Loot Crate',
      image:
          'https://specials-images.forbesimg.com/imageserve/605b86dfdb1f21935c430522/Angled-view-of-orange-Bokksu-subscription-box-surrounded-by-various-snacks-/960x0.jpg?fit=scale',
      price: 2000,
      category: Category.Stationery,
      description:
          'Loot Crate is the gift that keeps on giving for anyone obsessed with gaming, sports, entertainment, or pop culture.',
      items: [
        'Item 1',
        'Item 2',
        'Item 3',
        'Item 4',
      ],
    ),
  ];

  List<Box> get boxes => boxesList;
}
