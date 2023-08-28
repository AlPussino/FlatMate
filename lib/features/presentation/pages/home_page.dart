import 'package:cached_network_image/cached_network_image.dart';
import 'package:finding_apartments_yangon/features/presentation/pages/setting_page.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/home_pages/flat_description_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:page_transition/page_transition.dart';
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
              pinned: false,
              snap: false,
              floating: true,
              expandedHeight: 60,
              flexibleSpace: const FlexibleSpaceBar(
                titlePadding: EdgeInsets.all(16),
                centerTitle: false,
              ),
              title: const Text(
                "Find Your Stay",
                style: TextStyle(
                  color: Color(0xffF2AE00),
                  fontFamily: 'Dosis',
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.topToBottom,
                            child: const SettingPage()),
                      );
                    },
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.black,
                    ))
              ],
            ),
            SliverList.list(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Recent",
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
                      InkWell(
                        borderRadius: BorderRadius.circular(10),
                        splashColor: Color(0xffF2AE00).withOpacity(0.4),
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: const FlatDescriptionPage()),
                          );
                        },
                        child: SizedBox(
                          height: 100,
                          child: Row(
                            children: [
                              SizedBox(
                                height: 100,
                                width: 100,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "https://images.unsplash.com/photo-1620332372374-f108c53d2e03?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=872&q=80",
                                    placeholder: (context, url) => const Center(
                                      child: SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: CircularProgressIndicator(
                                          color: Color(0xffF2AE00),
                                          backgroundColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Royal Ambassador",
                                      style: TextStyle(
                                        color: Color(0xff000000),
                                        fontFamily: 'Dosis',
                                        fontSize: 16,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          size: 15,
                                          color: Color(0xff534F4F),
                                        ),
                                        Text(
                                          "Hlaing Township , Yangon",
                                          style: TextStyle(
                                            color: Color(0xff534F4F),
                                            fontFamily: 'Dosis',
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Row(
                                      children: [
                                        Icon(
                                          Icons.phone,
                                          size: 15,
                                          color: Color(0xff534F4F),
                                        ),
                                        Text(
                                          "09-87654321",
                                          style: TextStyle(
                                            color: Color(0xff534F4F),
                                            fontFamily: 'Dosis',
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "100000/m",
                                          style: TextStyle(
                                            color: Color(0xff000000),
                                            fontFamily: 'Dosis',
                                            fontSize: 22,
                                          ),
                                        ),
                                        Container(
                                          height: 30,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "3 left",
                                              style: TextStyle(
                                                color: Color(0xffFFFFFF),
                                                fontFamily: 'Dosis',
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
