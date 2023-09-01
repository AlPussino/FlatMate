import 'package:cached_network_image/cached_network_image.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/setting/view_profile_image_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _fbAccountNameController = TextEditingController();
  final _fbAccountLinkController = TextEditingController();
  final _igAccountNameController = TextEditingController();
  final _igAccountLinkController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    _fbAccountNameController.dispose();
    _fbAccountLinkController.dispose();
    _igAccountNameController.dispose();
    _igAccountLinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          "Edit profile",
          style: TextStyle(
            color: Color(0xff000000),
            fontFamily: 'Dosis',
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: ViewProfileImagePage(
                            imgUrl:
                                "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80",
                            imgTag: "ProfileImageTag",
                          ),
                        ),
                      );
                    },
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Hero(
                          tag: 'ProfileImageTag',
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
                            errorWidget: (context, url, error) => Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff534F4F).withOpacity(0.5),
                                ),
                                child: const Icon(Icons.error)),
                          ),
                        ),
                        Positioned(
                          right: -10,
                          bottom: -8,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {},
                                icon: const Icon(
                                  Icons.add_circle_sharp,
                                  size: 20,
                                  color: Color(0xffF2AE00),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Full name",
                style: TextStyle(
                  color: Color(0xff534F4F),
                  fontFamily: 'Dosis',
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                tileColor: const Color(0xffE8E8E8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                contentPadding: const EdgeInsets.only(right: 10, left: 20),
                title: const Text(
                  "Aung Khant Kyaw",
                  style: TextStyle(
                    color: Color(0xff000000),
                    fontFamily: 'Dosis',
                    fontSize: 14,
                  ),
                ),
                trailing: TextButton(
                  onPressed: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        content: Container(
                          padding: const EdgeInsets.only(top: 40),
                          child: SizedBox(
                            height: 52,
                            width: 400,
                            child: TextFormField(
                                style: const TextStyle(
                                    color: Color(0xff2E2E2E),
                                    fontFamily: 'Dosis',
                                    fontSize: 14),
                                controller: _nameController,
                                decoration: _buildDeco('Full name')),
                          ),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                _nameController.clear();
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                    color: Color(0xff2E2E2E),
                                    fontFamily: 'Dosis',
                                    fontSize: 14),
                              )),
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Save',
                                style: TextStyle(
                                    color: Color(0xffF2AE00),
                                    fontFamily: 'Dosis',
                                    fontSize: 14),
                              ))
                        ],
                      ),
                    );
                  },
                  child: const Text(
                    "Change",
                    style: TextStyle(
                      color: Color(0xff3C67FF),
                      fontFamily: 'Dosis',
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "Phone number",
                style: TextStyle(
                  color: Color(0xff534F4F),
                  fontFamily: 'Dosis',
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                tileColor: const Color(0xffE8E8E8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                contentPadding: const EdgeInsets.only(right: 10, left: 20),
                title: const Text(
                  "09-987654321",
                  style: TextStyle(
                    color: Color(0xff000000),
                    fontFamily: 'Dosis',
                    fontSize: 14,
                  ),
                ),
                trailing: TextButton(
                  onPressed: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        content: Container(
                          padding: const EdgeInsets.only(top: 40),
                          child: SizedBox(
                            height: 52,
                            width: 400,
                            child: TextFormField(
                                style: const TextStyle(
                                    color: Color(0xff2E2E2E),
                                    fontFamily: 'Dosis',
                                    fontSize: 14),
                                controller: _nameController,
                                decoration: _buildDeco('Phone number')),
                          ),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                _phoneNumberController.clear();
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                    color: Color(0xff2E2E2E),
                                    fontFamily: 'Dosis',
                                    fontSize: 14),
                              )),
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Save',
                                style: TextStyle(
                                    color: Color(0xffF2AE00),
                                    fontFamily: 'Dosis',
                                    fontSize: 14),
                              ))
                        ],
                      ),
                    );
                  },
                  child: const Text(
                    "Change",
                    style: TextStyle(
                      color: Color(0xff3C67FF),
                      fontFamily: 'Dosis',
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "Facebook account",
                style: TextStyle(
                  color: Color(0xff534F4F),
                  fontFamily: 'Dosis',
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                tileColor: const Color(0xffE8E8E8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                contentPadding: const EdgeInsets.only(right: 10, left: 20),
                title: const Text(
                  "Al Pussino",
                  style: TextStyle(
                    color: Color(0xff000000),
                    fontFamily: 'Dosis',
                    fontSize: 14,
                  ),
                ),
                trailing: TextButton(
                  onPressed: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        content: Container(
                          padding: const EdgeInsets.only(top: 40),
                          child: SizedBox(
                            height: 150,
                            width: 400,
                            child: Column(
                              children: [
                                TextFormField(
                                    style: const TextStyle(
                                        color: Color(0xff2E2E2E),
                                        fontFamily: 'Dosis',
                                        fontSize: 14),
                                    controller: _fbAccountNameController,
                                    decoration: _buildDeco('Account name')),
                                const SizedBox(height: 20),
                                TextFormField(
                                    style: const TextStyle(
                                        color: Color(0xff2E2E2E),
                                        fontFamily: 'Dosis',
                                        fontSize: 14),
                                    controller: _fbAccountLinkController,
                                    decoration: _buildDeco('profile link')),
                              ],
                            ),
                          ),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                _nameController.clear();
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                    color: Color(0xff2E2E2E),
                                    fontFamily: 'Dosis',
                                    fontSize: 14),
                              )),
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Save',
                                style: TextStyle(
                                    color: Color(0xffF2AE00),
                                    fontFamily: 'Dosis',
                                    fontSize: 14),
                              ))
                        ],
                      ),
                    );
                  },
                  child: const Text(
                    "Add",
                    style: TextStyle(
                      color: Color(0xff3C67FF),
                      fontFamily: 'Dosis',
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "Instagram account",
                style: TextStyle(
                  color: Color(0xff534F4F),
                  fontFamily: 'Dosis',
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                tileColor: const Color(0xffE8E8E8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                contentPadding: const EdgeInsets.only(right: 10, left: 20),
                title: const Text(
                  "Al Pussino",
                  style: TextStyle(
                    color: Color(0xff000000),
                    fontFamily: 'Dosis',
                    fontSize: 14,
                  ),
                ),
                trailing: TextButton(
                  onPressed: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        content: Container(
                          padding: const EdgeInsets.only(top: 40),
                          child: SizedBox(
                            height: 150,
                            width: 400,
                            child: Column(
                              children: [
                                TextFormField(
                                    style: const TextStyle(
                                        color: Color(0xff2E2E2E),
                                        fontFamily: 'Dosis',
                                        fontSize: 14),
                                    controller: _igAccountNameController,
                                    decoration: _buildDeco('Account name')),
                                const SizedBox(height: 20),
                                TextFormField(
                                    style: const TextStyle(
                                        color: Color(0xff2E2E2E),
                                        fontFamily: 'Dosis',
                                        fontSize: 14),
                                    controller: _igAccountLinkController,
                                    decoration: _buildDeco('profile link')),
                              ],
                            ),
                          ),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                _nameController.clear();
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                    color: Color(0xff2E2E2E),
                                    fontFamily: 'Dosis',
                                    fontSize: 14),
                              )),
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Save',
                                style: TextStyle(
                                    color: Color(0xffF2AE00),
                                    fontFamily: 'Dosis',
                                    fontSize: 14),
                              ))
                        ],
                      ),
                    );
                  },
                  child: const Text(
                    "Add",
                    style: TextStyle(
                      color: Color(0xff3C67FF),
                      fontFamily: 'Dosis',
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _buildDeco(String hint) {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xffFAFAFA),
      contentPadding: const EdgeInsets.all(20),
      hintText: hint,
      hintStyle: const TextStyle(
        fontFamily: 'Dosis',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xff757575),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color(0xff534F4F),
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color(0xff534F4F),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color(0xff534F4F),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color(0xff534F4F),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color(0xff534F4F),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color(0xff534F4F),
        ),
      ),
    );
  }
}
