import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_api/features/login/cubit/login_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            centerTitle: true,
            flexibleSpace: const FlexibleSpaceBar(title: Text("Profile")),
          ),

          BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              if (state is! LoginLoaded) {
                return const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final user = state.userData;

              return SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      /// Profile Image
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(user.profileImage),
                      ),

                      const SizedBox(height: 15),

                      /// Name
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 25),

                      /// Info Cards
                      _buildInfoCard("Email", user.email, Icons.email),
                      _buildInfoCard("Phone", user.phone, Icons.phone),
                      _buildInfoCard(
                        "National ID",
                        user.nationalId,
                        Icons.badge,
                      ),
                      _buildInfoCard("Gender", user.gender, Icons.person),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title),
        subtitle: Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
