import 'package:car_rent_app/core/app_theme.dart';
import 'package:car_rent_app/data/db/db_dummy.dart';
import 'package:car_rent_app/data/model/user.dart';
import 'package:car_rent_app/data/repository/user_repository.dart';
import 'package:car_rent_app/presentation/rent/rent_form_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final int userId;
  const HomePage({super.key, required this.userId});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _repo = UserRepository();
  User? _user;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    try {
      final user = await _repo.getUserById(widget.userId);
      setState(() {
        _user = user;
      });
    } catch (e) {
      debugPrint('Failed to load users: $e');
    }
  }

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
                "Selamat datang,",
                style: TextStyle(color: Colors.grey.shade500, fontSize: 15),
              ),
              _user == null
                  ? const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  : Text(
                      _user!.username,
                      style: TextStyle(
                        color: AppTheme.primaryBlue,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(
                    image: AssetImage('assets/img/banner.jpg'),
                    fit: BoxFit.cover,
                  ),
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
                      color: AppTheme.primaryBlue,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.swap_vert, color: AppTheme.primaryBlue),
                  ),
                ],
              ),

              SizedBox(height: 10),

              Expanded(
                child: ListView.builder(
                  itemCount: DbDummy.cars.length,
                  itemBuilder: (context, index) {
                    final selectedCar = DbDummy.cars[index];
                    return InkWell(
                      onTap: () {
                        if (_user != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  RentFormPage(car: selectedCar, user: _user!),
                            ),
                          );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: AppTheme.greyOutline),
                          ),
                        ),
                        child: ListTile(
                          style: ListTileStyle.list,
                          title: Text(DbDummy.cars[index].carName),
                          subtitle: Text(
                            DbDummy.cars[index].carType,
                            style: TextStyle(color: Colors.grey),
                          ),
                          leading: SizedBox(
                            height: 100,
                            child: Image.asset(DbDummy.cars[index].carImg),
                          ),
                          trailing: SizedBox(
                            width: 100,
                            child: Text.rich(
                              TextSpan(
                                text: "Rp ${DbDummy.cars[index].price}",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 14,
                                ),
                                children: [
                                  TextSpan(
                                    text: " / hari",
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
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
