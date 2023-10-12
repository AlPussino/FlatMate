import 'package:finding_apartments_yangon/features/presentation/providers/post_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/profile_pages/my_posts_card_widgets/bottom_sheet_to_edit_tenants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopUpMenuButtonToEditPost extends StatelessWidget {
  final post;
  const PopUpMenuButtonToEditPost({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      child: Icon(Icons.more_vert),
      onSelected: (String choice) {
        switch (choice) {
          case 'Delete':
            context.read<PostProvider>().deleteMyPost(post.id!);
            break;
          case 'Left':
            BottomSheetToEditTenants.bottomSheetToEditTenants(context, post);
            break;
        }
      },
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: 'Delete',
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.delete),
                SizedBox(width: 10),
                Text('Delete'),
              ],
            ),
          ),
          PopupMenuItem<String>(
            value: 'Edit',
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.edit),
                SizedBox(width: 10),
                Text('Edit'),
              ],
            ),
          ),
          PopupMenuItem<String>(
            value: 'Left',
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.people),
                SizedBox(width: 10),
                Text('Tenants left'),
              ],
            ),
          ),
        ];
      },
    );
  }
}
