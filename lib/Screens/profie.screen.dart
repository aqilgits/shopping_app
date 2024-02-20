import 'package:flutter/material.dart';
import 'package:shopping_app/Models/user.model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.user});
  final User user;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.user.image),
            radius: 70,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            widget.user.name,
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05),
          ),
        ],
      ),
    );
  }
}
