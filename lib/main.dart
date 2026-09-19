

import 'package:flutter/material.dart';

void main() {
  runApp(const SApp());
}

class SApp extends StatelessWidget {
  const SApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      title: 'القصص',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF111111),
        fontFamily: 'Arial',),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  final List<String> storyImages = const [
    'https://images.unsplash.com/photo-1500534623283-312aade485b7?w=300',
    'https://images.unsplash.com/photo-1519608487953-e999c86e7455?w=300',
    'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=300',
    'https://images.unsplash.com/photo-1519225421980-715cb0215aed?w=300',
  ];
  final List<String> discoverImages = const [
    'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=600',
    'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=600',
    'https://images.unsplash.com/photo-1529156069898-49953e39b3ac?w=600',
    'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?w=600',
    'https://images.unsplash.com/photo-1504274066651-8d31a536b11a?w=600',
    'https://images.unsplash.com/photo-1516321165247-4aa89a48be28?w=600',
  ];
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // عدد أعمدة الـ Grid حسب حجم الشاشة
    int columns;

    if (width < 600) {
      columns = 2;
    } else if (width < 900) {
      columns = 3;
    } else {
      columns = 4;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF111111),
        elevation: 0,
        title: const Text(
          'القصص',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.person_outline)),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'الأصدقاء',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.chevron_left, size: 30),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Stories
                SizedBox(
                  height: 125,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: storyImages.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: StoryItem(
                          imageUrl: storyImages[index],
                          name: 'صديق ${index + 1}',
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 25),

                // -------------------------
                // Discover
                // -------------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(child: Text(
                      'اكتشف',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),),
                    

                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.chevron_left, size: 30),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // -------------------------
                // Discover Cards
                // -------------------------
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: discoverImages.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,

                    childAspectRatio: 0.72,
                  ),
                  itemBuilder: (context, index) {
                    return DiscoverCard(
                      imageUrl: discoverImages[index],
                      title: getTitle(index),
                    );
                  },
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getTitle(int index) {
    switch (index) {
      case 0:
        return 'تعلم مهارات جديدة';
      case 1:
        return 'اكتشف عالم التقنية';
      case 2:
        return 'شارك لحظاتك';
      case 3:
        return 'أصدقاء جدد';
      case 4:
        return 'استمتع بوقتك';
      default:
        return 'اكتشف المزيد';
    }
  }
}

// ================================================== // Story Item // ==================================================
class StoryItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  const StoryItem({super.key, required this.imageUrl, required this.name});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 90,
          height: 90,

          decoration: BoxDecoration(
            shape: BoxShape.circle,

            border: Border.all(width: 4, color: Colors.purpleAccent),
          ),

          padding: const EdgeInsets.all(3),

          child: ClipOval(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,

              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.person, size: 45);
              },
            ),
          ),
        ),

        const SizedBox(height: 6),

        Text(name, style: const TextStyle(fontSize: 13)),
      ],
    );
  }
}

// ================================================== // Discover Card // ==================================================
class DiscoverCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  const DiscoverCard({super.key, required this.imageUrl, required this.title});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Image
          Image.network(
            imageUrl,
            fit: BoxFit.cover,

            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[900],
                child: const Icon(Icons.image, size: 50),
              );
            },
          ),

          // Dark overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
              ),
            ),
          ),

          // Text
          Positioned(
            right: 12,
            left: 12,
            bottom: 12,

            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,

              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),

          // Star
          const Positioned(
            top: 10,
            right: 10,
            child: Icon(Icons.star, size: 22),
          ),
        ],
      ),
    );
  }
}

