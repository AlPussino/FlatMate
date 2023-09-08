import 'package:animated_icon/animated_icon.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:finding_apartments_yangon/features/presentation/pages/setting_page.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/profile_pages/create_post_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

final ImagePicker picker = ImagePicker();

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                pinned: true,
                elevation: 1,
                automaticallyImplyLeading: false,
                snap: false,
                floating: false,
                expandedHeight: 100,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                  centerTitle: false,
                  title: const Text(
                    "Profile",
                    style: TextStyle(
                      color: Color(0xff000000),
                      fontFamily: 'Dosis',
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  // background: Image.asset(
                  //   "assets/images/rick.jpg",
                  //   fit: BoxFit.cover,
                  // ),
                ),
                actions: [
                  AnimateIcon(
                    toolTip: 'Setting',
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.topToBottom,
                            child: const SettingPage()),
                      );
                    },
                    iconType: IconType.animatedOnTap,
                    height: 70,
                    width: 70,
                    color: Color(0xff000000),
                    animateIcon: AnimateIcons.settings,
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      height: 280,
                      width: MediaQuery.sizeOf(context).width,
                      color: Colors.transparent,
                      child: Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.hardEdge,
                        children: [
                          Positioned(
                            top: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xff534F4F).withOpacity(0.1),
                              ),
                              height: 180,
                              width: MediaQuery.sizeOf(context).width / 1.1,
                              child: CachedNetworkImage(
                                imageUrl:
                                    "https://img.freepik.com/free-photo/gay-couple-love-time-bed_1150-5192.jpg?size=626&ext=jpg",
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => Center(
                                  child: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: const CircularProgressIndicator(
                                      color: Color(0xffF2AE00),
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 125,
                            child: Column(
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  color: Colors.transparent,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80",
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
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
                                    placeholder: (context, url) => SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: const CircularProgressIndicator(
                                        color: Color(0xffF2AE00),
                                        backgroundColor: Colors.white,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xff534F4F),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(Icons.error)),
                                  ),
                                ),
                                Text(
                                  "Oak Oak",
                                  style: TextStyle(
                                    color: Color(0xff000000),
                                    fontFamily: 'Dosis',
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
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
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(top: 8),
                sliver: SliverList.list(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            "Posts",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Dosis',
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 16),
                          InkWell(
                            borderRadius: BorderRadius.circular(10),
                            splashColor: Color(0xffF2AE00).withOpacity(0.4),
                            onTap: () {},
                            onLongPress: () {},
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
                                        placeholder: (context, url) =>
                                            const Center(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        Row(
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
                          const SizedBox(height: 16),
                          InkWell(
                            borderRadius: BorderRadius.circular(10),
                            splashColor: Color(0xffF2AE00).withOpacity(0.4),
                            onTap: () {},
                            onLongPress: () {},
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
                                        placeholder: (context, url) =>
                                            const Center(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        Row(
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
                          const SizedBox(height: 16),
                          InkWell(
                            borderRadius: BorderRadius.circular(10),
                            splashColor: Color(0xffF2AE00).withOpacity(0.4),
                            onTap: () {},
                            onLongPress: () {},
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
                                        placeholder: (context, url) =>
                                            const Center(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        Row(
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
                          const SizedBox(height: 16),
                          InkWell(
                            borderRadius: BorderRadius.circular(10),
                            splashColor: Color(0xffF2AE00).withOpacity(0.4),
                            onTap: () {},
                            onLongPress: () {},
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
                                        placeholder: (context, url) =>
                                            const Center(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        Row(
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
                          const SizedBox(height: 16),
                          InkWell(
                            borderRadius: BorderRadius.circular(10),
                            splashColor: Color(0xffF2AE00).withOpacity(0.4),
                            onTap: () {},
                            onLongPress: () {},
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
                                        placeholder: (context, url) =>
                                            const Center(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        Row(
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
                          const SizedBox(height: 16),
                          InkWell(
                            borderRadius: BorderRadius.circular(10),
                            splashColor: Color(0xffF2AE00).withOpacity(0.4),
                            onTap: () {},
                            onLongPress: () {},
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
                                        placeholder: (context, url) =>
                                            const Center(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        Row(
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
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Color(0xffF2AE00),
        enableFeedback: true,
        isExtended: true,
        onPressed: () async {
          // final List<XFile?> image = await picker.pickMultiImage();
          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                child: const CreatePostPage()),
          );
        },
        tooltip: 'Add Item',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
