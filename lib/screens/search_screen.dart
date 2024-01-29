import 'package:flutter/material.dart';
import 'package:google_clone/colors.dart';
import 'package:google_clone/services/api_service.dart';

import '../widgets/search_footer.dart';
import '../widgets/search_header.dart';
import '../widgets/search_result_component.dart';
import '../widgets/search_tabs.dart';

class SearchScreen extends StatelessWidget {
  final String searchQuery;
  final String start;
  const SearchScreen({super.key, required this.searchQuery, required this.start});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  Title(
      color: Colors.blue,
      title: searchQuery,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Web header
              SearchHeader(label: searchQuery,),
              //tabs for news, images etc
              Padding(
                padding: EdgeInsets.only(left: size.width <= 768 ? 5 : 150),
                child: const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                    child: SearchTabs()
                ),
              ),
              const Divider(
                height: 0,
                thickness: 0.3,
              ),
              // search results
              FutureBuilder(
                  future: ApiService().fetchData(queryTerm: searchQuery, start: start),
                  builder: (BuildContext context, AsyncSnapshot snapshot){
                    if(snapshot.hasData){
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                padding:  EdgeInsets.only(left: size.width <= 768 ? 5 : 150, top: 12),
                                child: Text(
                                  'About ${snapshot.data?['searchInformation']['formattedTotalResults']} results and  (${snapshot.data?['searchInformation']['formattedSearchTime']} seconds)',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFF70757a),
                                  ),
                                ),
                              ),
                              ListView.builder(
                                  itemBuilder: (context,index){
                                    return Padding(
                                      padding:  EdgeInsets.only(left: size.width<=768 ? 5 : 150, top: 10),
                                      child: SearchResultComponent(
                                        link: snapshot.data?['items'][index]['formattedUrl'],
                                        text: snapshot.data?['items'][index]['title'],
                                        LinkToGo: snapshot.data?['items'][index]['link'],
                                        desc: snapshot.data?['items'][index]['snippet'],
                                      ),
                                    );
                                  },
                                itemCount: snapshot.data?['items'].length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                              ),
                            ],
                          ),
                          // pagination buttons
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: (){
                                    if(start !='0'){
                                      Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => SearchScreen(
                                            searchQuery: searchQuery,
                                            start: (int.parse(start) - 1).toString()
                                        ),
                                      ),
                                      );
                                    }
                                  },
                                  child: const Text(
                                    '< Prev',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: blueColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 30,),
                                TextButton(
                                  onPressed: (){
                                    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => SearchScreen(
                                          searchQuery: searchQuery,
                                          start: (int.parse(start) + 1).toString()
                                      ),
                                    ),
                                    );
                                  },
                                  child: const Text(
                                    'Next >',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: blueColor,
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                          const SizedBox(height: 30,),
                          const SearchFooter(),
                        ],
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(
      
                      ),
                    );
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
