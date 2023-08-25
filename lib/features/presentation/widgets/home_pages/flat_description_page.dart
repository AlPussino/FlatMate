import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../core/utiles.dart';

class FlatDescriptionPage extends StatefulWidget {
  const FlatDescriptionPage({super.key});

  @override
  State<FlatDescriptionPage> createState() => _FlatDescriptionPageState();
}

class _FlatDescriptionPageState extends State<FlatDescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          "Royal Ambassador",
          style: TextStyle(
            color: Color(0xff000000),
            fontFamily: 'Dosis',
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 10,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                physics: BouncingScrollPhysics(),
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
                  Text(
                    "Location",
                    style: TextStyle(
                      color: Color(0xff000000),
                      fontFamily: 'Dosis',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Hlaing Township , Yangon",
                    style: TextStyle(
                      color: Color(0xff534F4F),
                      fontFamily: 'Dosis',
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "No.69, In Sein Road, Thu Kha Bus Stop",
                    style: TextStyle(
                      color: Color(0xff534F4F),
                      fontFamily: 'Dosis',
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Contact",
                    style: TextStyle(
                      color: Color(0xff000000),
                      fontFamily: 'Dosis',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "3  Months , 6 Months , Nego",
                    style: TextStyle(
                      color: Color(0xff534F4F),
                      fontFamily: 'Dosis',
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Description",
                    style: TextStyle(
                      color: Color(0xff000000),
                      fontFamily: 'Dosis',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Stepping into the vibrant hostel, a sense of adventure fills the air. Backpackers from around the globe gather in the common area, sharing stories and laughter. The walls adorned with colorful maps and travel memorabilia spark conversations and inspire new journeys. Dorm rooms exude a cozy camaraderie, with bunk beds draped in curtains for privacy.Stepping into the vibrant hostel, a sense of adventure fills the air. Backpackers from around the globe gather in the common area, sharing stories and laughter. The walls adorned with colorful maps and travel memorabilia spark conversations and inspire new journeys. Dorm rooms exude a cozy camaraderie, with bunk beds draped in curtains for privacy.",
                    style: TextStyle(
                      color: Color(0xff534F4F),
                      fontFamily: 'Dosis',
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    tileColor: const Color(0xffE8E8E8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    contentPadding: const EdgeInsets.only(top: 5, bottom: 5),
                    leading: Hero(
                      tag: 'ProfileImageTag1',
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80",
                        imageBuilder: (context, imageProvider) => Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(
                          color: Color(0xffF2AE00),
                          backgroundColor: Colors.white,
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    title: Text(
                      "Aung Khant Kyaw",
                      style: TextStyle(
                        color: Color(0xff000000),
                        fontFamily: 'Dosis',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "09-987654321",
                      style: TextStyle(
                        color: Color(0xff000000),
                        fontFamily: 'Dosis',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Material(
              color: Colors.white,
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "100000/m ",
                        style: TextStyle(
                          color: Color(0xff000000),
                          fontFamily: 'Dosis',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          _openPhoneDialer("0987654321");
                        },
                        child: Container(
                          width: 120,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.black),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  "Call now",
                                  style: TextStyle(
                                    color: Color(0xffFFFFFF),
                                    fontFamily: 'Dosis',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 6),
                                child: CircleAvatar(
                                  radius: 19,
                                  backgroundColor: Color(0xffF2AE00),
                                  child: Icon(
                                    Icons.phone,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openPhoneDialer(String phoneNumber) async {
    final String url = "tel:$phoneNumber";
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
