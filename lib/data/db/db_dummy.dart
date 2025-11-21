import 'package:car_rent_app/data/model/car.dart';

class DbDummy {
  static List<Car> cars = [
    Car(
      id: 1,
      carName: "Toyota Avanza",
      carType: "MPV",
      carImg: "assets/img/car/toyota-avanza.png",
      price: 350000,
    ),
    Car(
      id: 2,
      carName: "Mitsubishi Xpander",
      carType: "MPV",
      carImg: "assets/img/car/mitsubishi-xpander.png",
      price: 450000,
    ),
    Car(
      id: 3,
      carName: "Toyota Innova Reborn",
      carType: "MPV Premium",
      carImg: "assets/img/car/toyota-innova-reborn.png",
      price: 750000,
    ),
    Car(
      id: 4,
      carName: "Honda Brio",
      carType: "City Car",
      carImg: "assets/img/car/honda-brio.png",
      price: 300000,
    ),
    Car(
      id: 5,
      carName: "Toyota Agya",
      carType: "City Car",
      carImg: "assets/img/car/toyota-agya.png",
      price: 250000,
    ),
    Car(
      id: 6,
      carName: "Honda HR-V",
      carType: "SUV",
      carImg: "assets/img/car/honda-hrv.png",
      price: 600000,
    ),
    Car(
      id: 7,
      carName: "Toyota Fortuner",
      carType: "SUV Premium",
      carImg: "assets/img/car/toyota-fortuner.png",
      price: 1200000,
    ),
    Car(
      id: 8,
      carName: "Mitsubishi Pajero Sport",
      carType: "SUV Premium",
      carImg: "assets/img/car/mitsubishi-pajero.png",
      price: 1250000,
    ),
    Car(
      id: 9,
      carName: "Honda Civic Turbo",
      carType: "Sedan",
      carImg: "assets/img/car/honda-civic.png",
      price: 1500000,
    ),
    Car(
      id: 10,
      carName: "Toyota Hiace",
      carType: "Minibus",
      carImg: "assets/img/car/toyota-hiace.png",
      price: 1100000,
    ),
  ];

  static Car getCarById(int id) {
    return cars.firstWhere((car) => car.id == id);
  }
}
