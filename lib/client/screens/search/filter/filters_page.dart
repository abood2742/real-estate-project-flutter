
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:property_system/client/components/area.dart';
import 'package:property_system/client/components/rectangle.dart';



class FiltersPage extends StatefulWidget {
  const FiltersPage({super.key});

  @override
  State<FiltersPage> createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  List<bool> typeSelection = [true, false]; // سكني، تجاري
  List<bool> actionSelection = [true, false]; // بيع، شراء
  String? selectedPropertyType;
  int? selectedBathroomCount;
  int? selectedBedroomCount; // متغير لتخزين عدد الحمامات المحدد

  @override
  Widget build(BuildContext context) {
    List<Widget> residentialProperties = [
      _buildSelectableProperty("Home", Icons.home),
      _buildSelectableProperty("apartment", Icons.apartment),
      _buildSelectableProperty("villa", Icons.villa),
      _buildSelectableProperty("garage", Icons.garage),
    ];

    List<Widget> commercialProperties = [
      _buildSelectableProperty("Store", Icons.store),
      _buildSelectableProperty("office", Icons.money_off_csred_outlined),
      _buildSelectableProperty("restaurant", Icons.restaurant),
      _buildSelectableProperty("mall", Icons.local_mall),
      _buildSelectableProperty("cafe", Icons.local_cafe),
      _buildSelectableProperty("hotel", Icons.hotel),
      _buildSelectableProperty("warehouse", Icons.warehouse),
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 50,
                alignment: Alignment.centerRight,
                child: Lottie.asset(
                  'assets/filter_amolation.json',
                  repeat: true,
                  animate: true,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'اختر لتصفية العقارات',
                style: TextStyle(fontSize: 18, fontFamily: 'Pacifico'),
                textAlign: TextAlign.right,
              ),
            ),
            const SizedBox(height: 30),

            // ------------------ نوع العقار ------------------
            const Text(
              'نوع العقار',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pacifico',
                color: Color.fromARGB(255, 23, 88, 73),
              ),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ToggleButtons(
                borderRadius: BorderRadius.circular(12),
                isSelected: typeSelection,
                selectedColor: Colors.white,
                fillColor: const Color.fromARGB(255, 21, 129, 217),
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child:
                        Text('سكني', style: TextStyle(fontFamily: 'Pacifico')),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child:
                        Text('تجاري', style: TextStyle(fontFamily: 'Pacifico')),
                  ),
                ],
                onPressed: (int index) {
                  setState(() {
                    for (int i = 0; i < typeSelection.length; i++) {
                      typeSelection[i] = i == index;
                    }
                    selectedPropertyType = null;
                    selectedBathroomCount =
                        null; // إعادة تعيين عدد الحمامات عند تغيير النوع
                  });
                },
              ),
            ),

            const SizedBox(height: 30),

            // ------------------ نوع العملية ------------------
            const Text(
              'نوع العملية',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 23, 88, 73),
                  fontFamily: 'Pacifico'),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ToggleButtons(
                borderRadius: BorderRadius.circular(12),
                isSelected: actionSelection,
                selectedColor: Colors.white,
                fillColor: const Color.fromARGB(255, 21, 129, 217),
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 60),
                    child:
                        Text('بيع', style: TextStyle(fontFamily: 'Pacifico')),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 60),
                    child:
                        Text('شراء', style: TextStyle(fontFamily: 'Pacifico')),
                  ),
                ],
                onPressed: (int index) {
                  setState(() {
                    for (int i = 0; i < actionSelection.length; i++) {
                      actionSelection[i] = i == index;
                    }
                  });
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: typeSelection[0]
                      ? residentialProperties
                      : commercialProperties,
                ),
              ),
            ),

            Container(height: 2, color: Colors.grey),
            const SizedBox(height: 10),

            // ------------------ المدينة ------------------
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: " مدينتك",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.black, width: 1.5),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Icon(
                    Icons.location_city,
                    color: Color.fromARGB(255, 23, 88, 73),
                    size: 38,
                  ),
                ),
              ],
            ),

            // ------------------ المساحة ------------------
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Text(
                'المساحة بالمتر المربع',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pacifico',
                    color: Color.fromARGB(255, 31, 86, 181)),
                textAlign: TextAlign.right,
              ),
            ),
            AreaRangeSelector(),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                children: [
                  Spacer(),
                  Text('أقل سعر', style: TextStyle(fontFamily: 'Pacifico')),
                  Spacer(flex: 2),
                  Text('أعلى سعر', style: TextStyle(fontFamily: 'Pacifico')),
                  Spacer(),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: " 0",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.5),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: " 0",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 23, 88, 73),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: GestureDetector(
                    onTap: (){
                  
                    },
                    child: const Center(
                      child: Text(
                        'بحث',
                        style: TextStyle(
                            fontFamily: 'Pacifico',
                            color: Colors.white,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 50,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: GestureDetector(
                    onTap: (){
                      
                    },
                    child: const Center(
                      child: Text(
                        'إعادة تهيئة ',
                        style: TextStyle(
                            fontFamily: 'Pacifico',
                            color: Colors.white,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // ------------------ زر إظهار الفلاتر المتقدمة ------------------
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {});
                },
                child: const Text(
                  'إظهار الفلترة المتقدمة',
                  style: TextStyle(
                    fontFamily: 'Pacifico',
                    color: Color.fromARGB(255, 23, 88, 73),
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            if (selectedPropertyType != null)
              ..._buildAdvancedFilters(selectedPropertyType!)
          ],
        ),
      ),
    );
  }

  Widget _buildSelectableProperty(String name, IconData icon) {
    final isSelected = selectedPropertyType == name;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPropertyType = name;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Rectangle(name: name, icon: icon),
      ),
    );
  }

  List<Widget> _buildAdvancedFilters(String propertyType) {
    switch (propertyType) {
      case "Home":
        //  case "villa":
        //  case "apartment":
        return [
          const Text(
            'عدد الحمامات',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Pacifico',
              color: Color.fromARGB(255, 23, 88, 73),
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 10),
          Row(
            children: List.generate(
              4,
              (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    selectedBathroomCount = index + 1;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: selectedBathroomCount == index + 1
                          ? Colors.blue[400] // لون عند التحديد
                          : Colors.blue[100], // لون عادي
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: selectedBathroomCount == index + 1
                            ? Colors.blue[800]!
                            : Colors.transparent,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: selectedBathroomCount == index + 1
                              ? Colors.white
                              : Colors.blue[800],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          const Text(
            'عدد غرف النوم ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Pacifico',
              color: Color.fromARGB(255, 23, 88, 73),
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 10),
          Row(
            children: List.generate(
              4,
              (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    selectedBedroomCount = index + 1;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: selectedBedroomCount == index + 1
                          ? Colors.blue[400] // لون عند التحديد
                          : Colors.blue[100], // لون عادي
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: selectedBedroomCount == index + 1
                            ? Colors.blue[800]!
                            : Colors.transparent,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: selectedBedroomCount == index + 1
                              ? Colors.white
                              : Colors.blue[800],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          CheckboxListTile(
            title: const Text('مدخل سيارة', style: TextStyle(fontFamily: 'Pacifico')),
            value: true,
            onChanged: (_) {},
          ),
          const SizedBox(height: 20),
        ];
      case "apartment":
        return [
          CheckboxListTile(
            title: Text('زاوية', style: TextStyle(fontFamily: 'Pacifico')),
            value: true,
            onChanged: (_) {},
          ),
          CheckboxListTile(
            title:
                Text('على شارع عام', style: TextStyle(fontFamily: 'Pacifico')),
            value: false,
            onChanged: (_) {},
          ),
          CheckboxListTile(
            title: Text('يوجد حمام', style: TextStyle(fontFamily: 'Pacifico')),
            value: true,
            onChanged: (_) {},
          ),
          const SizedBox(height: 20),
        ];
      case "Store":
        return [
          CheckboxListTile(
            title: Text('زاوية', style: TextStyle(fontFamily: 'Pacifico')),
            value: true,
            onChanged: (_) {},
          ),
          CheckboxListTile(
            title:
                Text('على شارع عام', style: TextStyle(fontFamily: 'Pacifico')),
            value: false,
            onChanged: (_) {},
          ),
          CheckboxListTile(
            title: Text('يوجد حمام', style: TextStyle(fontFamily: 'Pacifico')),
            value: true,
            onChanged: (_) {},
          ),
          const SizedBox(height: 20),
        ];
      default:
        return [
          const Text(
            'لا توجد فلترة متقدمة لهذا النوع',
            style: TextStyle(fontFamily: 'Pacifico', color: Colors.grey),
          ),
        ];
    }
  }
}
