import 'package:dotted_border/dotted_border.dart';
import 'package:finding_apartments_yangon/features/presentation/pages/intro_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splashImg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, right: 24),
                  child: RichText(
                    textWidthBasis: TextWidthBasis.longestLine,
                    textAlign: TextAlign.right,
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'FIND\n',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontFamily: 'Dosis',
                          ),
                        ),
                        TextSpan(
                          text: 'YOUR\n',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontFamily: 'Dosis',
                          ),
                        ),
                        TextSpan(
                          text: 'STAY\n',
                          style: TextStyle(
                            fontFamily: 'Dosis',
                            color: Colors.white,
                            fontSize: 48,
                          ),
                        ),
                        TextSpan(
                          text: 'Apartments and Hostels in Yangon',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Dosis',
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: DottedBorder(
                    color: const Color(0xff534F4F),
                    dashPattern: const [20, 20],
                    borderType: BorderType.Circle,
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: Center(
                        child: DottedBorder(
                          color: const Color(0xff534F4F),
                          dashPattern: const [20, 20],
                          borderType: BorderType.Circle,
                          child: SizedBox(
                            width: 120,
                            height: 120,
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: IntroPage()),
                                  );
                                },
                                child: const CircleAvatar(
                                  backgroundColor: Colors.black,
                                  radius: 30,
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
