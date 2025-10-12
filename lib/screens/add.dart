import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  String? selectedValue;
  File? _image;
  final ImagePicker _picker = ImagePicker();

  final List<String> items = [
    "Starters",
    "Snacks",
    "Curry",
    "Rice",
    "Breads",
    "Salads",
    "Soups",
    "Desserts",
    "Drinks",
    "Grill",
    "Pasta",
    "Fast Food",
    "Seafood",
    "Sides",
  ];

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 217, 226, 236),
      body: Padding(
        padding: EdgeInsets.only(left: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),

              Padding(
                padding: EdgeInsets.only(left: 300),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 72, 71, 71),
                    backgroundColor: const Color.fromARGB(255, 245, 246, 247),
                  ),
                  child: Text("Save"),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,

                      image: _image != null
                          ? DecorationImage(
                              image: FileImage(_image!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: _image == null
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo,
                                  size: 40,
                                  color: Color.fromARGB(255, 90, 90, 90),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Add Image",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 90, 90, 90),
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : null,
                  ),
                ),
              ),

              Container(
                height: 60,
                width: 350,
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: DropdownButton<String>(
                  value: selectedValue,
                  hint: Text("Select Category"),
                  isExpanded: true,
                  underline: SizedBox(),
                  items: items.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                ),
              ),

              const SizedBox(height: 30),

              Container(
                height: 60,
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Type recipe name",
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30),

              Container(
                height: 390,
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: TextStyle(fontSize: 16, height: 2),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Start writing your recipe here...",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
