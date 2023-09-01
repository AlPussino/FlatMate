import 'package:finding_apartments_yangon/features/presentation/widgets/home_pages/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slider/carousel.dart';
import '../../../core/utiles.dart';

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
                      SizedBox(
                        height: 190,
                        child: Carousel(
                          autoScroll: false,
                          animationPageCurve: Curves.linear,
                          activateIndicatorColor: const Color(0xffF2AE00),
                          indicatorBarColor: Colors.transparent,
                          isCircle: false,
                          indicatorHeight: 5,
                          indicatorWidth: 20,
                          items: [
                            Utils.headerImagesSlide(
                              "https://images.unsplash.com/photo-1620332372374-f108c53d2e03?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=872&q=80",
                              context,
                            ),
                            Utils.headerImagesSlide(
                              "https://images.unsplash.com/photo-1623625434462-e5e42318ae49?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2071&q=80",
                              context,
                            ),
                            Utils.headerImagesSlide(
                              "https://images.unsplash.com/photo-1520277739336-7bf67edfa768?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1332&q=80",
                              context,
                            ),
                          ],
                        ),
                      ),
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
