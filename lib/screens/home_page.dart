import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _tripType = 'One-way';
  int _selectedIndex = 0;
  TextEditingController _dateController = TextEditingController();
  TextEditingController _fromController = TextEditingController();
  TextEditingController _toController = TextEditingController();
  int _adults = 1;
  int _children = 0;
  int _infants = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Add navigation logic if needed
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue,
            hintColor: Colors.blue,
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null && selectedDate != DateTime.now()) {
      setState(() {
        _dateController.text = DateFormat('MMMM d, yyyy').format(selectedDate);
      });
    }
  }

  void _showTravelerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Travelers'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDropdown('Adults', _adults, (int value) {
                setState(() {
                  _adults = value;
                });
              }),
              _buildDropdown('Children', _children, (int value) {
                setState(() {
                  _children = value;
                });
              }),
              _buildDropdown('Infants', _infants, (int value) {
                setState(() {
                  _infants = value;
                });
              }),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDropdown(
      String label, int currentValue, ValueChanged<int> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        DropdownButton<int>(
          value: currentValue,
          onChanged: (int? newValue) {
            if (newValue != null) {
              onChanged(newValue);
            }
          },
          items: List.generate(10, (index) => index).map((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text(value.toString()),
            );
          }).toList(),
        ),
      ],
    );
  }

  String _getTravelerText() {
    return '$_adults Adult${_adults > 1 ? 's' : ''}, $_children Child${_children > 1 ? 'ren' : ''}, $_infants Infant${_infants > 1 ? 's' : ''}';
  }

  void _swapLocations() {
    setState(() {
      String temp = _fromController.text;
      _fromController.text = _toController.text;
      _toController.text = temp;
    });
  }

  List<String> _getSuggestions(String query) {
    // This should ideally fetch data from an API or a local database
    List<String> allSuggestions = [
      'New York, USA',
      'Los Angeles, USA',
      'London, UK',
      'Paris, France',
      'Tokyo, Japan',
      // Add more cities as needed
    ];

    return allSuggestions
        .where((suggestion) =>
            suggestion.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200.h),
        child: AppBar(
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.chevron_left,
                            color: Colors.white, size: 32.sp),
                        onPressed: () {},
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Search Flights',
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 48.w),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Discover',
                    style: TextStyle(
                      fontSize: 34.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'a new world',
                    style: TextStyle(
                      fontSize: 34.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'One-way',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      leading: Radio<String>(
                        value: 'One-way',
                        groupValue: _tripType,
                        onChanged: (value) {
                          setState(() {
                            _tripType = value!;
                          });
                        },
                        activeColor: Colors.blue,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Round-trip',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      leading: Radio<String>(
                        value: 'Round-trip',
                        groupValue: _tripType,
                        onChanged: (value) {
                          setState(() {
                            _tripType = value!;
                          });
                        },
                        activeColor: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Text(
                'From',
                style: TextStyle(fontSize: 16.sp),
              ),
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.flight_takeoff, size: 24.sp, color: Colors.blue),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: TypeAheadField<String>(
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: _fromController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                        suggestionsCallback: (pattern) {
                          return _getSuggestions(pattern);
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text(suggestion),
                          );
                        },
                        onSuggestionSelected: (suggestion) {
                          _fromController.text = suggestion;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Text(
                    'To',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Transform.rotate(
                      angle: 90 * 3.14159 / 180,
                      child: Icon(Icons.swap_horiz,
                          size: 24.sp, color: Colors.blue),
                    ),
                    onPressed: _swapLocations,
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.flight_land, size: 24.sp, color: Colors.blue),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: TypeAheadField<String>(
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: _toController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                        suggestionsCallback: (pattern) {
                          return _getSuggestions(pattern);
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text(suggestion),
                          );
                        },
                        onSuggestionSelected: (suggestion) {
                          _toController.text = suggestion;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Departure Date',
                style: TextStyle(fontSize: 16.sp),
              ),
              SizedBox(height: 10.h),
              GestureDetector(
                onTap: () {
                  _selectDate(context);
                },
                child: AbsorbPointer(
                  child: TextField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      prefixIcon:
                          Icon(Icons.calendar_today, color: Colors.blue),
                      hintText: 'Select date',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Travelers',
                style: TextStyle(fontSize: 16.sp),
              ),
              SizedBox(height: 10.h),
              GestureDetector(
                onTap: _showTravelerDialog,
                child: AbsorbPointer(
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person, color: Colors.blue),
                      hintText: _getTravelerText(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add search logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'Search Flights',
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.blue),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.blue),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: Colors.blue),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
