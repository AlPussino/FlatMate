import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PostOwnerProfilePage extends StatefulWidget {
  const PostOwnerProfilePage({super.key});

  @override
  State<PostOwnerProfilePage> createState() => _PostOwnerProfilePageState();
}

class _PostOwnerProfilePageState extends State<PostOwnerProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              foregroundColor: Colors.black,
              automaticallyImplyLeading: true,
              backgroundColor: Colors.white,
              pinned: true,
              snap: false,
              floating: false,
              expandedHeight: 50,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.all(0),
                centerTitle: false,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Aung Khant Kyaw",
                              style: TextStyle(
                                color: Color(0xff000000),
                                fontFamily: 'Dosis',
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 16),
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
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SvgPicture.asset(
                                  'assets/svgs/facebook_logo.svg',
                                ),
                                const SizedBox(width: 10),
                                SvgPicture.asset(
                                  'assets/svgs/instagram_logo.svg',
                                ),
                              ],
                            ),
                          ],
                        ),
                        CachedNetworkImage(
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
                          errorWidget: (context, url, error) => Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff534F4F).withOpacity(0.5),
                              ),
                              child: const Icon(Icons.error)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            SliverList.list(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
