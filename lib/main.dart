import 'package:flutter/material.dart';

void main() => runApp(const SneakerLab7App());

class Product {
  final String id;
  final String title;
  final String description;
  final String imagePath;
  final double price;
  final String category;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.category,
  });
}

const List<Product> sampleProducts = [
  Product(
    id: 'velocity',
    title: "Nike Air Force 1 '07",
    description: "A classic all-white Nike low-top sneaker with leather panels, perforated toe box, durable rubber outsole and Air cushioning. A versatile everyday style.",
    imagePath: "https://asset.snipes.com/images/f_auto%2Cq_80%2Cd_fallback-sni.png/b_rgb%3Af8f8f8%2Cc_pad%2Cw_680%2Ch_680/dpr_1.0/01126425_2/nike-air-force-1-%2707-weiss-1727-2",
    price: 129.99,
    category: 'Lifestyle',
  ),
  Product(
    id: 'street',
    title: "adidas Samba OG",
    description: "The iconic adidas Samba features a low-profile silhouette, contrast three stripes and a gum rubber outsole. A recognizable classic for casual wear.",
    imagePath: "https://5thave-img-cdn.beyondstyle.us/pf/99b373df-5abd-3e1c-a63b-5a6939846995.jpg?x-oss-process=style%2Fs1",
    price: 94.50,
    category: 'Lifestyle',
  ),
  Product(
    id: 'nova',
    title: "Converse Chuck Taylor All Star",
    description: "The classic Converse high-top canvas sneaker with a rubber toe cap, iconic ankle patch and vulcanized sole. Made for timeless casual street style.",
    imagePath: "https://dr9l7gb9cebpv.cloudfront.net/media/catalog/product/cache/2774d42b8e55ba58cfe3fc9632392955/m/9/m9160_a_107x1_2.jpg",
    price: 149.00,
    category: 'Streetwear',
  ),
  Product(
    id: 'trail',
    title: "New Balance 574",
    description: "A classic New Balance running-inspired silhouette with a combination upper, supportive cushioning and a durable outsole suited for everyday use.",
    imagePath: "https://superrunnersshop.com/cdn/shop/products/ml574evg_5.jpg?v=1656688845",
    price: 119.00,
    category: 'Lifestyle',
  ),
];

String formatPrice(double price) => r'$' + price.toStringAsFixed(2);

class SneakerLab7App extends StatelessWidget {
  const SneakerLab7App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sneaker Lab 7',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5546E8),
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F8FC),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF7F8FC),
          surfaceTintColor: Colors.transparent,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final Set<String> _favoriteIds = <String>{};
  bool _notificationsEnabled = true;

  void _toggleFavorite(Product product) {
    setState(() {
      if (!_favoriteIds.add(product.id)) {
        _favoriteIds.remove(product.id);
      }
    });
  }

  void _openDetails(Product product) {
    Navigator.push<void>(
      context,
      MaterialPageRoute<void>(
        builder: (context) => DetailScreen(
          product: product,
          isFavorite: () => _favoriteIds.contains(product.id),
          onToggleFavorite: () => _toggleFavorite(product),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final saved = sampleProducts
        .where((product) => _favoriteIds.contains(product.id))
        .toList();

    final tabs = <Widget>[
      ProductListTab(
        products: sampleProducts,
        title: 'Find your next pair',
        subtitle: 'Explore four styles picked for you.',
        favoriteIds: _favoriteIds,
        onOpen: _openDetails,
        onToggleFavorite: _toggleFavorite,
      ),
      saved.isEmpty
          ? const EmptyFavoritesTab()
          : ProductListTab(
              products: saved,
              title: 'Your favorites',
              subtitle: '${saved.length} saved item(s)',
              favoriteIds: _favoriteIds,
              onOpen: _openDetails,
              onToggleFavorite: _toggleFavorite,
            ),
      ProfileTab(
        notificationsEnabled: _notificationsEnabled,
        onNotificationsChanged: (value) {
          setState(() => _notificationsEnabled = value);
        },
        favoritesCount: _favoriteIds.length,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SOLE SPACE',
          style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1.4),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '${_favoriteIds.length} saved',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ),
        ],
      ),
      body: IndexedStack(index: _selectedIndex, children: tabs),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF5546E8),
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dynamic_feed_outlined),
            activeIcon: Icon(Icons.dynamic_feed),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class ProductListTab extends StatelessWidget {
  final List<Product> products;
  final String title;
  final String subtitle;
  final Set<String> favoriteIds;
  final ValueChanged<Product> onOpen;
  final ValueChanged<Product> onToggleFavorite;

  const ProductListTab({
    super.key,
    required this.products,
    required this.title,
    required this.subtitle,
    required this.favoriteIds,
    required this.onOpen,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 16),
        for (final product in products)
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: ProductCard(
              product: product,
              isFavorite: favoriteIds.contains(product.id),
              onOpen: () => onOpen(product),
              onToggleFavorite: () => onToggleFavorite(product),
            ),
          ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isFavorite;
  final VoidCallback onOpen;
  final VoidCallback onToggleFavorite;

  const ProductCard({
    super.key,
    required this.product,
    required this.isFavorite,
    required this.onOpen,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onOpen,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product.imagePath,
                  width: 124,
                  height: 112,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const ColoredBox(
                    color: Color(0xFFE8E7F7),
                    child: SizedBox(width: 124, height: 112, child: Icon(Icons.shopping_bag, size: 40)),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.category.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF5546E8),
                        letterSpacing: 0.7,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      formatPrice(product.price),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: isFavorite ? 'Remove favorite' : 'Add favorite',
                onPressed: onToggleFavorite,
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.redAccent : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmptyFavoritesTab extends StatelessWidget {
  const EmptyFavoritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.favorite_border,
              size: 70,
              color: Color(0xFF5546E8),
            ),
            const SizedBox(height: 12),
            Text(
              'No favorites yet',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const Text(
              'Tap a heart on the Feed tab to save a sneaker here.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileTab extends StatelessWidget {
  final bool notificationsEnabled;
  final ValueChanged<bool> onNotificationsChanged;
  final int favoritesCount;

  const ProfileTab({
    super.key,
    required this.notificationsEnabled,
    required this.onNotificationsChanged,
    required this.favoritesCount,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SizedBox(height: 12),
        const CircleAvatar(
          radius: 40,
          backgroundColor: Color(0xFFE6E3FF),
          child: Icon(Icons.person, size: 45, color: Color(0xFF5546E8)),
        ),
        const SizedBox(height: 12),
        const Text(
          'Flutter Student',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        const Text(
          'Demo profile • Lab 7',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 28),
        Card(
          color: Colors.white,
          elevation: 0,
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.favorite_outline),
                title: const Text('Saved items'),
                trailing: Text('$favoritesCount'),
              ),
              const Divider(height: 1),
              SwitchListTile(
                secondary: const Icon(Icons.notifications_outlined),
                title: const Text('Notifications'),
                subtitle: const Text('Receive product updates'),
                value: notificationsEnabled,
                onChanged: onNotificationsChanged,
              ),
              const Divider(height: 1),
              const ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('About'),
                subtitle: Text('Multi-Screen Navigation & Tabs'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DetailScreen extends StatefulWidget {
  final Product product;
  final bool Function() isFavorite;
  final VoidCallback onToggleFavorite;

  const DetailScreen({
    super.key,
    required this.product,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  void _toggleFavorite() {
    widget.onToggleFavorite();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final favorite = widget.isFavorite();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product details'),
        leading: IconButton(
          tooltip: 'Back',
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            tooltip: favorite ? 'Remove favorite' : 'Add favorite',
            onPressed: _toggleFavorite,
            icon: Icon(
              favorite ? Icons.favorite : Icons.favorite_border,
              color: favorite ? Colors.redAccent : null,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Image.network(
                    product.imagePath,
                    height: 275,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const ColoredBox(
                      color: Color(0xFFE8E7F7),
                      child: SizedBox(height: 275, child: Icon(Icons.shopping_bag, size: 90)),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Chip(label: Text(product.category)),
                ),
                const SizedBox(height: 12),
                Text(
                  product.title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  formatPrice(product.price),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF5546E8),
                      ),
                ),
                const SizedBox(height: 18),
                Text(
                  'Description',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(product.description),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _toggleFavorite,
                  icon: Icon(
                    favorite ? Icons.favorite : Icons.favorite_border,
                  ),
                  label: Text(
                    favorite ? 'Remove from Favorites' : 'Save to Favorites',
                  ),
                ),
                const SizedBox(height: 10),
                OutlinedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Back to previous screen'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
