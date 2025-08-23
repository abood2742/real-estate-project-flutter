import 'package:flutter/material.dart';
import 'package:property_system/client/screens/search/resault/property/property_detailes_page.dart';

class ReservedPropertComponents extends StatelessWidget {
   ReservedPropertComponents({super.key,required this.location , required this.forWhat});
  String location, forWhat;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   Navigator.push(context, MaterialPageRoute(builder: (context) {
      //     return PropertyDetailesPage(propertyModel: );
      //   }));
      // },
      child: Card(
        color: const Color.fromARGB(255, 232, 228, 228),
        margin: const EdgeInsets.all(10),
        elevation: 2,
        shadowColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                       location,
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontFamily: 'Pacifico',
                        ),
                      ),
                      Text(
                        forWhat,
                        style: TextStyle(
                          color: Color.fromARGB(255, 43, 152, 134),
                          fontFamily: 'Pacifico',
                          fontSize: 18,
                          //   fontFamily: 'Pacifico',
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text(
                            'هل تريد إلغاء حجز العقار؟',
                            style: TextStyle(
                              fontFamily: 'Pacifico',
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          actionsAlignment: MainAxisAlignment.spaceEvenly,
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'إلغاء',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Pacifico',
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('تم إلغاء الحجز'),
                                  ),
                                );
                              },
                              child: const Text(
                                'تأكيد',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Pacifico',
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 93, 188, 201),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      height: 40,
                      width: 130,
                      child: const Center(
                        child: Text(
                          'إلغاء حجز العقار',
                          style: TextStyle(
                            fontFamily: 'Pacifico',
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(16),
                ),
                height: 250,
                width: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/pic2.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // الزر + النصوص
            ],
          ),
        ),
      ),
    );
  }
}
