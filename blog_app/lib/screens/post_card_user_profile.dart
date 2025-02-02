import 'package:blog_app/controllers/PostController.dart';
import 'package:blog_app/model/post_model.dart';
import 'package:blog_app/screens/PostDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostCardUserProfile extends StatefulWidget {
  final Post post;
  final Future<String> Function() getToken;

  const PostCardUserProfile({
    super.key,
    required this.post,
    required this.getToken,
  });

  @override
  _PostCardUserProfileState createState() => _PostCardUserProfileState();
}

class _PostCardUserProfileState extends State<PostCardUserProfile> {
    static  String baseUrl = dotenv.env['BASE_URL_IMAGES'] ?? 'http://default.url';

  String? _currentUserId;

  @override
  void initState() {
    super.initState();
    _getCurrentUserId();
  }

  Future<void> _getCurrentUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentUserId = prefs.getString('userId');
    });
  }

  Future<void> _deletePost() async {
    bool? confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Post"),
          content: const Text("Are you sure you want to delete this post?"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                final String token = await widget.getToken();
                final PostController postController = Get.find();
                await postController.deletePost(widget.post.id);
                Navigator.of(context).pop(true);
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      Get.snackbar('Success', 'Post deleted successfully',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    final PostController postController = Get.find();
    final formattedDate = DateFormat.yMMMd().format(widget.post.createdAt);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5), // Reduced margin
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Rounded corners for compact look
      ),
      elevation: 3, // Slightly reduced elevation for a subtler card
      child: Padding(
        padding: const EdgeInsets.all(8.0), // Reduced padding for compactness
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Post Header with Menu Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => PostDetailsScreen(postId: widget.post.id));
                    },
                    child: Text(
                      widget.post.title,
                      style: const TextStyle(
                        fontSize: 16, // Smaller title text
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                if (_currentUserId == widget.post.userId)
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert, color: Colors.grey),
                    onSelected: (value) {
                      if (value == 'delete') _deletePost();
                    },
                    itemBuilder: (BuildContext context) => [
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Delete Post'),
                          ],
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 6), // Reduced space between elements
            // Rest of Post Content
            GestureDetector(
              onTap: () {
                Get.to(() => PostDetailsScreen(postId: widget.post.id));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.post.content,
                    style: const TextStyle(fontSize: 12), // Smaller content text
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  if (widget.post.image != null && widget.post.image!.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8), // More subtle corner radius
                      child: Image.network(
                        // "http://192.168.100.146:3000${widget.post.image}",
                        "$baseUrl${widget.post.image}",
                        height: 180, // Reduced image height
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Text(
                            'Image not available',
                            style: TextStyle(color: Colors.red),
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 6), // Reduced space
                  Text(
                    'Posted on: $formattedDate',
                    style: const TextStyle(fontSize: 10, color: Colors.grey), // Smaller date text
                  ),
                ],
              ),
            ),
            // Like and Comment Buttons
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    widget.post.hasLiked
                        ? Icons.thumb_up_alt_rounded
                        : Icons.thumb_up_off_alt_rounded,
                    size: 20, // Smaller icon size
                    color: widget.post.hasLiked ? Colors.blue : Colors.grey,
                  ),
                  onPressed: () async {
                    final String token = await widget.getToken();
                    postController.updateLikes(
                      widget.post.id,
                      widget.post.hasLiked,
                      widget.post.likes,
                      token,
                    );
                  },
                ),
                Text(
                  'Likes: ${widget.post.likes}',
                  style: const TextStyle(fontSize: 12, color: Colors.black54), // Smaller text size
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(
                    Icons.comment_outlined,
                    size: 20, // Smaller icon size
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    Get.to(() => PostDetailsScreen(postId: widget.post.id));
                  },
                ),
                Text(
                  'Comments: ${widget.post.commentCount}',
                  style: const TextStyle(fontSize: 12, color: Colors.black54), // Smaller text size
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
