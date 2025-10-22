import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pr/models/recipe_model.dart';
import 'package:pr/service/functions.dart';

class Editrecipe extends StatefulWidget {
  final RecipeModel recipe;
  final dynamic recipeKey;

  const Editrecipe({super.key, required this.recipe, required this.recipeKey});

  @override
  State<Editrecipe> createState() => _EditrecipeState();
}

class _EditrecipeState extends State<Editrecipe> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  String imagePath = '';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.recipe.name);
    _descriptionController =
        TextEditingController(text: widget.recipe.description);
    imagePath = widget.recipe.imagePath;

    log("EditRecipe page initialized for: ${widget.recipe.name}", name: "EditRecipe");
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    log("EditRecipe page disposed", name: "EditRecipe");
    super.dispose();
  }

  Future<void> _pickImage() async {
    log("Picking image...", name: "EditRecipe");
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (pickedFile != null) {
        setState(() {
          imagePath = pickedFile.path;
        });
        log("Image picked: ${pickedFile.path}", name: "EditRecipe");
      } else {
        log("Image picking cancelled", name: "EditRecipe", level: 800);
      }
    } catch (e) {
      log("Error picking image: $e", name: "EditRecipe", level: 1000);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error picking image: $e")));
    }
  }

  void _saveRecipe() async {
    log("Attempting to save recipe...", name: "EditRecipe");

    if (_nameController.text.isEmpty || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar( SnackBar(content: Text("Please fill all fields")));
      log("Save failed: fields empty", name: "EditRecipe", level: 900);
      return;
    }

    try {
      final updatedRecipe = RecipeModel(
        name: _nameController.text,
        description: _descriptionController.text,
        imagePath: imagePath,
        category: widget.recipe.category,
        username: widget.recipe.username,
      );

      await editRecipe(widget.recipeKey, updatedRecipe);

      log("Recipe updated successfully: ${updatedRecipe.name}", name: "EditRecipe");

      Navigator.of(context).pop(updatedRecipe);
    } catch (e) {
      log("Error saving recipe: $e", name: "EditRecipe", level: 1000);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error saving recipe: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    log("EditRecipe screen built", name: "EditRecipe");

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 217, 226, 236),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 217, 226, 236),
        title: Text(
          'Edit Recipe',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(icon: Icon(Icons.check), onPressed: _saveRecipe),
        ],
      ),
      body: Padding(
        padding:  EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: imagePath.isNotEmpty && File(imagePath).existsSync()
                      ? Image.file(
                          File(imagePath),
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          height: 200,
                          width: 200,
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.camera_alt,
                            size: 50,
                            color: Colors.grey,
                          ),
                        ),
                ),
              ),
               SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Recipe Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (val) =>
                    log("Recipe name changed: $val", name: "EditRecipe"),
              ),
               SizedBox(height: 20),
              TextField(
                controller: _descriptionController,
                maxLines: 6,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (val) =>
                    log("Recipe description changed", name: "EditRecipe"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
