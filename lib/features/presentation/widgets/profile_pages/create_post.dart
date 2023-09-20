import 'dart:developer';

import 'package:finding_apartments_yangon/features/data/models/divisions_and_townships.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

String selectedRegion = 'ကချင်ပြည်နယ်';
String selectedTownship = 'ကန်ပိုက်တီ မြို့';
List<MyanmarData> myanmarData = [];

class _CreatePostState extends State<CreatePost> {
  @override
  void initState() {
    super.initState();
    loadMyanmarData();
  }

  void loadMyanmarData() async {
    final data = await context.read<UserProvider>().loadMyanmarData();
    setState(() {
      log('asfd');
      myanmarData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Myanmar Regions'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(
              value: selectedRegion,
              onChanged: (newValue) {
                setState(() {
                  selectedRegion = newValue!;
                  selectedTownship = ''; // Reset township selection
                });
              },
              items: myanmarData.map((data) {
                return DropdownMenuItem(
                  value: data.name.toString(),
                  child: Text(data.name),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            DropdownButton<String>(
              value: selectedTownship,
              onChanged: (String? newValue) {
                setState(() {
                  selectedTownship = newValue ?? '';
                });
              },
              items: myanmarData
                  .firstWhere((data) => data.name == selectedRegion)
                  .townships
                  .map((township) {
                return DropdownMenuItem<String>(
                  value: township,
                  child: Text(township),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
