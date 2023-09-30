import 'package:cached_network_image/cached_network_image.dart';
import 'package:finding_apartments_yangon/features/data/models/post_owner.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/home_pages/post_owner_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:page_transition/page_transition.dart';

class SearchedUserCard extends StatefulWidget {
  final PostOwner postOwner;
  const SearchedUserCard({super.key, required this.postOwner});

  @override
  State<SearchedUserCard> createState() => _SearchedUserCardState();
}

class _SearchedUserCardState extends State<SearchedUserCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeft,
              child: PostOwnerProfilePage(userId: widget.postOwner.id!),
            ),
          );
        },
        child: Animate(
          child: SizedBox(
            height: 100,
            width: MediaQuery.sizeOf(context).width,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              elevation: 0.5,
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.transparent,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(0xffF2AE00),
                        child: CachedNetworkImage(
                          imageUrl: widget.postOwner.profileUrl ??
                              "https://img.freepik.com/free-vector/mysterious-gangster-character_23-2148483453.jpg?w=740&t=st=1694579352~exp=1694579952~hmac=fb3ade8ee793f7b89b94ff12fa773da23e827fb82279da7c36ffd3eb3033d98f",
                          imageBuilder: (context, imageProvider) => Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          progressIndicatorBuilder: (context, url, progress) {
                            return const CircularProgressIndicator(
                              color: Color(0xffF2AE00),
                              backgroundColor: Colors.white,
                            );
                          },
                          errorWidget: (context, url, error) => Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff534F4F),
                              ),
                              child: const Icon(Icons.error)),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.postOwner.username!,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            widget.postOwner.mobileNumber!,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ).animate().shimmer(
              duration: Duration(seconds: 2),
              color: Color.fromARGB(20, 242, 173, 0),
            ),
      ),
    );
  }
}
