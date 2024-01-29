import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../colors.dart';
import '../widgets/mobile/mobile_footer.dart';
import '../widgets/search.dart';
import '../widgets/web/search_buttons.dart';
import '../widgets/web/translation_buttons.dart';
import '../widgets/web/web_footer.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final size =MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
            onPressed: (){},
            icon: const Icon(Icons.menu, color: Colors.grey,),
        ),
        title: SizedBox(
          width: size.width*0.34,
          child: const DefaultTabController(
            length: 2,
            child: TabBar(
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              indicatorColor: blueColor,
              dividerColor: backgroundColor,
              tabs: [
              Tab(text: 'ALL',),
              Tab(text: 'IMAGES',)
           ],
                ),
              ),
        ),
        actions: [
          IconButton(
            onPressed: (){},
            icon: SvgPicture.asset('assets/images/more-apps.svg',color: primaryColor,),
          ),
          const SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              onPressed: (){},
              color: const Color(0xff1A73EB),
              child: const Text(
                "Sign In",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),

        ],
      ),
      body:  Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Column(
          children: [
            SizedBox(height: size.height * 0.01,),
            const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Search(),
                        SizedBox(height: 20,),
                      ],
                    ),
                    MobileFooter(),
                  ],
                )
            )
          ],
        ),
      ),

    );
  }
}
