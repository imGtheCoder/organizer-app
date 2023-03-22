import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(top: 80, right: 15, left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello Again, \nUSER',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 40),
            ),
            const SizedBox(
              height: 30,
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/Profile.jpeg'),
              ),
              title: const Text('Account management'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.extension),
              title: const Text('Suggestions'),
              onTap: () {},
            ),            
            ListTile(
              leading: const Icon(Icons.contact_support),
              title: const Text('Contact support'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text('Leave us a review'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.psychology_alt),
              title: const Text('About the developers'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
