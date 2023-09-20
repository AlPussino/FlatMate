import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:finding_apartments_yangon/features/data/models/requests/add_social_contact_request.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/setting/view_profile_image_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/user_provider.dart';
import '../log_in_pages/login_page.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _nameController = TextEditingController();
  final _accountNameController = TextEditingController();
  final _accountLinkController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _accountLinkController.dispose();
    _accountNameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  String selectedSocialContact = "FACEBOOK";
  List<String> socialContactsOptions = [
    'FACEBOOK',
    'INSTAGRAM',
    'TELEGRAM',
  ];

  @override
  Widget build(BuildContext context) {
    bool isTokenExpired = context.read<AuthProvider>().isTokenExpired();
    if (isTokenExpired) {
      final user = context.read<UserProvider>().getUserInfo();
      user.then((value) {
        if (value == null) {
          Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.leftToRight, child: LoginPage()),
          );
        }
      });
    }

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
        body: FutureBuilder(
          future: context.read<UserProvider>().getUserInfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Color(0xffF2AE00),
                ),
              );
            }
            if (snapshot.hasError) {
              log(snapshot.error.toString());
              return Center(
                child: Text(
                  snapshot.error.toString(),
                  style: TextStyle(
                    color: Color(0xff000000),
                    fontFamily: 'Dosis',
                    fontSize: 20,
                  ),
                ),
              );
            }

            final myUser = context.watch<UserProvider>().user;
            myUser!.socialContacts!.map((e) {
              if (socialContactsOptions.contains(e.contactType)) {
                bool isSuccess = socialContactsOptions.remove(e.contactType);
                log(isSuccess.toString());
              }
            }).toList();

            return Padding(
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
                                  imgUrl: myUser.profileUrl != null
                                      ? myUser.profileUrl ?? ""
                                      : "https://img.freepik.com/free-vector/mysterious-gangster-character_23-2148483453.jpg?w=740&t=st=1694579352~exp=1694579952~hmac=fb3ade8ee793f7b89b94ff12fa773da23e827fb82279da7c36ffd3eb3033d98f",
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
                                  imageUrl: myUser!.profileUrl != null
                                      ? myUser.profileUrl ?? ""
                                      : "https://img.freepik.com/free-vector/mysterious-gangster-character_23-2148483453.jpg?w=740&t=st=1694579352~exp=1694579952~hmac=fb3ade8ee793f7b89b94ff12fa773da23e827fb82279da7c36ffd3eb3033d98f",
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
                                  placeholder: (context, url) => Center(
                                    child: const CircularProgressIndicator(
                                      color: Color(0xffF2AE00),
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xff534F4F)
                                                .withOpacity(0.5),
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
                                      onPressed: () async {
                                        await context
                                            .read<UserProvider>()
                                            .pickImageAndSaveToSever(
                                                myUser.profileUrl);
                                        setState(() {});
                                      },
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
                      contentPadding:
                          const EdgeInsets.only(right: 10, left: 20),
                      title: Text(
                        myUser.username ?? '',
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
                                    onPressed: () async {
                                      final result = await context
                                          .read<UserProvider>()
                                          .changeUserName(
                                              userName: _nameController.text);
                                      if (result != null) {
                                        _nameController.clear();
                                        Navigator.pop(context);
                                        // setState(() {});
                                      } else {}
                                    },
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
                          "change",
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
                      contentPadding:
                          const EdgeInsets.only(right: 10, left: 20),
                      title: Text(
                        myUser.mobileNumber ?? '',
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
                                      controller: _phoneNumberController,
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
                                    onPressed: () async {
                                      final result = await context
                                          .read<UserProvider>()
                                          .changeMobileNumber(
                                              mobileNumber:
                                                  _phoneNumberController.text);
                                      if (result != null) {
                                        _phoneNumberController.clear();
                                        Navigator.pop(context);
                                        // setState(() {});
                                      } else {}
                                    },
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
                          "change",
                          style: TextStyle(
                            color: Color(0xff3C67FF),
                            fontFamily: 'Dosis',
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Social accounts",
                          style: TextStyle(
                            color: Color(0xff534F4F),
                            fontFamily: 'Dosis',
                            fontSize: 14,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            socialContactsOptions.isEmpty
                                ? null
                                : showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => ShowUpAddSocialView(
                                        socialContactsListLeft:
                                            socialContactsOptions),
                                  );
                          },
                          child: Text(
                            socialContactsOptions.isEmpty ? '' : 'add',
                            style: TextStyle(
                              color: Color(0xff3C67FF),
                              fontFamily: 'Dosis',
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ...myUser.socialContacts!.map((sc) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: ListTile(
                          onTap: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => ShowUpAddSocialView(
                                socialContactsListLeft: socialContactsOptions,
                                body: AddSocialContactRequest(
                                    userName: sc.username!,
                                    contactType: sc.contactType!,
                                    url: sc.profileUrl!),
                              ),
                            );
                          },
                          tileColor: const Color(0xffE8E8E8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding:
                              const EdgeInsets.only(right: 10, left: 20),
                          leading: Icon(sc.contactType! == 'FACEBOOK'
                              ? Icons.facebook
                              : sc.contactType! == 'TELEGRAM'
                                  ? Icons.telegram
                                  : Icons.chat_bubble_rounded),
                          title: Text(
                            sc.username!,
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontFamily: 'Dosis',
                              fontSize: 14,
                            ),
                          ),
                          trailing: TextButton(
                            onPressed: () async {
                              showDialog(
                                  context: context,
                                  useRootNavigator: true,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      child: SizedBox(
                                        width: 50,
                                        child: Container(
                                          padding: const EdgeInsets.all(20.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: Colors.white,
                                          ),
                                          height: 150,
                                          child: const Center(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                CircularProgressIndicator(
                                                  color: Color(0xffF2AE00),
                                                ),
                                                SizedBox(height: 16.0),
                                                Text('Removing...'),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                              final result = await context
                                  .read<UserProvider>()
                                  .removeSocialContact(id: sc.id!.toString());
                              if (result != null) {
                                Navigator.pop(context);
                                setState(() {
                                  socialContactsOptions.add(sc.contactType!);
                                });
                              }
                            },
                            child: const Text(
                              "remove",
                              style: TextStyle(
                                color: Color(0xff3C67FF),
                                fontFamily: 'Dosis',
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            );
          },
        ));
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

class ShowUpAddSocialView extends StatefulWidget {
  final AddSocialContactRequest? body;
  final List<String> socialContactsListLeft;
  const ShowUpAddSocialView(
      {super.key, this.body, required this.socialContactsListLeft});

  @override
  State<ShowUpAddSocialView> createState() => _ShowUpAddSocialViewState();
}

class _ShowUpAddSocialViewState extends State<ShowUpAddSocialView> {
  final _accountNameController = TextEditingController();
  final _accountLinkController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    _accountLinkController.dispose();
    _accountNameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  String selectedSocialContact = '';
  List<String> socialContactsListAll = ["FACEBOOK", "INSTAGRAM", "TELEGRAM"];

  List<String> socialContactsListForEdit = [];

  @override
  void initState() {
    if (widget.body != null) {
      _accountNameController.text = widget.body!.userName;
      _accountLinkController.text = widget.body!.url;
      selectedSocialContact = widget.body!.contactType;
      socialContactsListForEdit = [widget.body!.contactType];
    } else {
      selectedSocialContact = widget.socialContactsListLeft[0];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      content: Container(
        padding: const EdgeInsets.only(top: 40),
        child: SizedBox(
          height: 220,
          width: 400,
          child: Column(
            children: [
              Container(
                height: 60,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xff534F4F), // Border color
                  ),
                  borderRadius: BorderRadius.circular(10), // Border radius
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: AbsorbPointer(
                      absorbing: widget.body != null ? true : false,
                      child: DropdownButton(
                        isExpanded: true,
                        autofocus: true,
                        underline: Container(),
                        alignment: Alignment.centerLeft,
                        borderRadius: BorderRadius.circular(10),
                        style: TextStyle(
                          color: Color(0xff534F4F),
                          fontFamily: 'Dosis',
                          fontSize: 14,
                        ),
                        value: selectedSocialContact,
                        onChanged: (newValue) {
                          setState(() {
                            selectedSocialContact = newValue!;
                            log(selectedSocialContact);
                          });
                        },
                        items: widget.body == null
                            ? widget.socialContactsListLeft
                                .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList()
                            : socialContactsListForEdit
                                .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  enabled: false,
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                  style: const TextStyle(
                      color: Color(0xff2E2E2E),
                      fontFamily: 'Dosis',
                      fontSize: 14),
                  controller: _accountNameController,
                  decoration: _buildDeco('Account name')),
              const SizedBox(height: 20),
              TextFormField(
                  style: const TextStyle(
                      color: Color(0xff2E2E2E),
                      fontFamily: 'Dosis',
                      fontSize: 14),
                  controller: _accountLinkController,
                  decoration: _buildDeco('profile link')),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              _accountNameController.clear();
              _accountLinkController.clear();
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(
                  color: Color(0xff2E2E2E), fontFamily: 'Dosis', fontSize: 14),
            )),
        TextButton(
          onPressed: () async {
            Navigator.pop(context, true);
            showDialog(
                context: context,
                useRootNavigator: true,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return Dialog(
                    child: SizedBox(
                      width: 50,
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                        ),
                        height: 150,
                        child: const Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(
                                color: Color(0xffF2AE00),
                              ),
                              SizedBox(height: 16.0),
                              Text('Removing...'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });

            final result = await context.read<UserProvider>().addSocialContact(
                AddSocialContactRequest(
                    userName: _accountNameController.text,
                    url: _accountLinkController.text,
                    contactType: selectedSocialContact));

            if (result != null) {
              _accountNameController.clear();
              _accountLinkController.clear();
              Navigator.pop(context, true);
            } else {}
          },
          child: const Text(
            'Save',
            style: TextStyle(
                color: Color(0xffF2AE00), fontFamily: 'Dosis', fontSize: 14),
          ),
        ),
      ],
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
