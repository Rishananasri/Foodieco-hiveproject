import 'dart:io';
import 'dart:developer'; 
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pr/models/recipe_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  String? selectedValue;
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final _nameController = TextEditingController();
  final _recipeController = TextEditingController();

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
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        log("Image picked: ${pickedFile.path}", name: "AddRecipe");
      }
    } catch (e) {
      log("Error picking image: $e", name: "AddRecipe", level: 1000);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error picking image: $e")));
    }
  }

  Future<String> _saveImageToAppDir(File imageFile) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');
    log("Image saved to app dir: ${savedImage.path}", name: "AddRecipe");
    return savedImage.path;
  }

  void _resetForm() {
    setState(() {
      _nameController.clear();
      _recipeController.clear();
      selectedValue = null;
      _image = null;
    });
    log("Form reset", name: "AddRecipe");
  }

  Future<void> _saveRecipe() async {
    if (_image == null ||
        selectedValue == null ||
        _nameController.text.trim().isEmpty ||
        _recipeController.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("Incomplete"),
          content: Text("Please fill all fields and pick an image."),
          actions: [
            TextButton(
              child:  Text("OK"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
      log("Save attempted with incomplete form", name: "AddRecipe", level: 900);
      return;
    }

    try {
      final savedImagePath = await _saveImageToAppDir(_image!);

      final prefs = await SharedPreferences.getInstance();
      final currentUser = prefs.getString('currentUsername') ?? '';

      final recipe = RecipeModel(
        imagePath: savedImagePath,
        name: _nameController.text.trim(),
        category: selectedValue!,
        description: _recipeController.text.trim(),
        username: currentUser,
      );

      final box = Hive.box<RecipeModel>('recipe_db');
      await box.add(recipe);

      log("Recipe saved successfully: ${recipe.name}", name: "AddRecipe");

      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title:  Text("Saved"),
          content:  Text("The recipe has been saved successfully."),
          actions: [
            TextButton(
              child:  Text("OK"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );

      _resetForm();
    } catch (e) {
      log("Error saving recipe: $e", name: "AddRecipe", level: 1000);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error saving recipe: $e")));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _recipeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("AddRecipe screen built", name: "AddRecipe");

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
                padding:  EdgeInsets.only(left: 300),
                child: ElevatedButton(
                  onPressed: _saveRecipe,
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
                              children:  [
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
                padding:  EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: DropdownButton<String>(
                  value: selectedValue,
                  hint:  Text("Select Category"),
                  isExpanded: true,
                  underline:  SizedBox(),
                  items: items.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() {
                    selectedValue = value;
                  }),
                ),
              ),
               SizedBox(height: 30),
              Container(
                height: 60,
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _nameController,
                    decoration:  InputDecoration(
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
                    controller: _recipeController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style:TextStyle(fontSize: 16, height: 2),
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
