import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisata_candi/providers/favorite_provider.dart';
import 'package:wisata_candi/providers/auth_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSignedIn = true;
  String fullName = 'Dzikri Cahayadi Alamsyah';
  String userName = 'Ryzzs09';

  void signIn() => setState(() => isSignedIn = true);
  void signOut() => setState(() => isSignedIn = false);

  @override
  Widget build(BuildContext context) {
    final favoriteCount = context.watch<FavoriteProvider>().count;
    final auth = context.watch<AuthProvider>();
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.deepPurple,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 200 - 50),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.deepPurple,
                              width: 2,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(
                              'images/placeholder_image.png',
                            ),
                          ),
                        ),
                        if (isSignedIn)
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colors.deepPurple[50],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                ProfileInfoItem(
                  icon: Icons.lock,
                  iconColor: Colors.amber,
                  label: 'Pengguna',
                  value: isSignedIn ? userName : '',
                ),
                ProfileInfoItem(
                  icon: Icons.person,
                  iconColor: Colors.blue,
                  label: 'Nama',
                  value: isSignedIn ? fullName : '',
                  showEditIcon: isSignedIn,
                ),
                ProfileInfoItem(
                  icon: Icons.favorite,
                  iconColor: Colors.red,
                  label: 'Favorit',
                  value: favoriteCount > 0 ? '$favoriteCount' : '',
                ),
                const SizedBox(height: 16),

                auth.isSignedIn
                    ? TextButton(
                  onPressed: () => context.read<AuthProvider>().signOut(),
                  child: const Text('Sign Out'),
                )
                    : TextButton(
                  onPressed: () => context.read<AuthProvider>().signIn(),
                  child: const Text('Sign In'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileInfoItem extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final String label;
  final String value;
  final bool showEditIcon;

  const ProfileInfoItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.iconColor,
    this.showEditIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: Row(
                children: [
                  Icon(icon, color: iconColor),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Text(
                ': $value',
                style: const TextStyle(fontSize: 18),
              ),
            ),
            if (showEditIcon) const Icon(Icons.edit),
          ],
        ),
        const SizedBox(height: 4),
        Divider(color: Colors.deepPurple[100]),
        const SizedBox(height: 4),
      ],
    );
  }
}