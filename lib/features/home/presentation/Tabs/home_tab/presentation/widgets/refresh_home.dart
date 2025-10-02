import 'package:flutter/material.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/presentation/cubit/home_tab_cubit.dart';


class RefreshHome extends StatelessWidget {
  const RefreshHome({super.key, required this.viewModel, required this.savedToken});
final HomeTabCubit viewModel;
final String savedToken;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Text(
              'No Orders ',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w600
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                viewModel.getHomeData();
              },
              child: const CircleAvatar(
                radius: 20,
                  backgroundColor: Colors.pink,
                  child: Icon(Icons.refresh,color: Colors.white,size: 25,)),
            ),
            const SizedBox(
              height: 35,
            ),


          ],
        ));
  }
}
