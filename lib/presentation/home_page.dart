import 'package:car_rent_app/data/db/db_dummy.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Selamat Datang,",
                style: TextStyle(color: Colors.grey.shade500, fontSize: 15),
              ),
              const Text(
                "rakamaulana",
                style: TextStyle(
                  color: Color(0xFF3C4048),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.amberAccent,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),

              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Daftar Mobil",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3C4048),
                    ),
                  ),

                  IconButton(onPressed: () {}, icon: Icon(Icons.swap_vert)),
                ],
              ),

              SizedBox(height: 10),

              Expanded(
                child: ListView.builder(
                  itemCount: DbDummy.cars.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 100,
                                child: Image.asset(DbDummy.cars[index].img),
                              ),

                              SizedBox(
                                width: 150,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(DbDummy.cars[index].name),
                                    Text(DbDummy.cars[index].type),
                                    Text(
                                      "Rp ${DbDummy.cars[index].price.toString()}",
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(
                                width: 50,
                                child: Icon((Icons.navigate_next)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
