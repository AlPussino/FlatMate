import 'package:finding_apartments_yangon/features/data/models/divisions_and_townships.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

String selectedRegion = "စစ်ကိုင်းတိုင်းဒေသကြီး";
String? selectedTownship;
List<MyanmarData> myanmarData = [];

class _CreatePostState extends State<CreatePost> {
  @override
  void initState() {
    load();
    // myanmarData = context.read<UserProvider>().myanmarData;
    super.initState();
  }

  Future<void> load() async {
    List<MyanmarData> data =
        await context.read<PostProvider>().loadMyanmarData();
    print(data);
    setState(() {
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
                  selectedTownship = null;

                  print(selectedRegion);

                  myanmarData
                      .firstWhere(
                        (element) => element.name == selectedRegion,
                      )
                      .townships
                      .map((e) => print("Towns: ${e.name}"))
                      .toList();
                });
              },
              items: myanmarData.map((data) {
                return DropdownMenuItem(
                  value: data.name,
                  child: Text(data.name),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            DropdownButton<String>(
              value: selectedTownship,
              onChanged: (newValue) {
                setState(() {
                  selectedTownship = newValue!;
                });
              },
              items: myanmarData
                  .firstWhere((data) => data.name == selectedRegion)
                  .townships
                  .map((township) {
                return DropdownMenuItem<String>(
                  value: township.name,
                  child: Text(township.name),
                );
              }).toList(),
            ),
            TextFormField()
          ],
        ),
      ),
    );
  }
}
