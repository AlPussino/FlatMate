import 'package:flutter/material.dart';
import '../widgets/home_pages/post_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              pinned: true,
              snap: false,
              floating: false,
              expandedHeight: 100,
              flexibleSpace: const FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                centerTitle: false,
                title: const Text(
                  "Find Your Stay",
                  style: TextStyle(
                    color: Color(0xffF2AE00),
                    fontFamily: 'Dosis',
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            SliverList.list(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Hlaing",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Dosis',
                                  fontSize: 18,
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Row(
                                  children: [
                                    Text(
                                      "see all",
                                      style: TextStyle(
                                        color: Color(0xff534F4F),
                                        fontFamily: 'Dosis',
                                        fontSize: 16,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Color(0xff534F4F),
                                      size: 15,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PostCard(),
                                PostCard(),
                                PostCard(),
                                PostCard(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
