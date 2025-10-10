import 'package:flutter/material.dart';

class Notes extends StatelessWidget {
  const Notes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 247, 239, 162),
      body: Stack(
        children: [
          SizedBox(
            height: 920,
            child: Image.asset(
              "assets/images/yellow.bg.jpeg",
              color: Colors.white.withOpacity(0.5),
              colorBlendMode: BlendMode.modulate,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70),
                child: Row(
                  children: [
                    const SizedBox(width: 30),
                    const Text(
                      "Notes",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.check, size: 28),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Save clicked!")),
                        );
                      },
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Container(
                    width: 350,
                    height: 670,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: const Offset(4, 4),
                        ),
                      ],
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: TextField(
                        maxLines: null,
                        style: TextStyle(fontSize: 16, height: 2),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Start writing your notes...",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
