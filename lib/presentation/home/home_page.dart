import 'package:car_rent_app/data/db/db_dummy.dart';
import 'package:car_rent_app/data/model/user.dart';
import 'package:car_rent_app/data/repository/user_repository.dart';
import 'package:car_rent_app/presentation/rent/rent_form_page.dart';
import 'package:car_rent_app/core/utils.dart';
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
                  color: Colors.black12,
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
                    return InkWell(
                      onTap: () => grPush(context, RentFormPage()),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                        child: ListTile(
                          style: ListTileStyle.list,
                          title: Text(DbDummy.cars[index].name),
                          subtitle: Text(
                            DbDummy.cars[index].type,
                            style: TextStyle(color: Colors.grey.shade500),
                          ),
                          leading: SizedBox(
                            height: 100,
                            child: Image.asset(DbDummy.cars[index].img),
                          ),

                          trailing: SizedBox(
                            width: 100,
                            child: Text.rich(
                              TextSpan(
                                text:
                                    "Rp ${DbDummy.cars[index].price.toStringAsFixed(0)}",
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
