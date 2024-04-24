import 'package:flutter/material.dart';
import 'package:joblyst/constant/colors.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  late PageController _pageController;
  int _currentPage = 0;

  final List<String> _carouselItems = [
    'Carousel Item 1',
    'Carousel Item 2',
    'Carousel Item 3',
    'Carousel Item 4',
    'Carousel Item 5',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.3,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: Image.asset('images/icon_back.png'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              "Select your interest",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            titleSpacing: 0,
            floating: true,
            pinned: true,
            snap: true,
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.white,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'What are you interested in?',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _carouselItems.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: index == 0 ? EdgeInsets.zero : EdgeInsets.only(left: 8),
                    color: Colors.blue,
                    child: Center(
                      child: Text(
                        _carouselItems[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
              ),
            ),
          ),
          SliverGrid.count(
            crossAxisCount: 3,
            children: List.generate(
              12,
                  (index) => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.all(8),
                color: Colors.blue,
                child: Center(
                  child: Text(
                    'Interest ${index + 1}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}