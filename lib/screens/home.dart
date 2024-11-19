import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> heroList = [];
  List<Map<String, dynamic>> filteredHeroList = [];
  Map<int, String> heroIcons = {}; // Peta untuk menyimpan ikon dari heroes.json
  String searchQuery = '';
  String? selectedPrimaryAttr;
  String? selectedAttackType;
  String? selectedRolesType;

  @override
  void initState() {
    super.initState();
    fetchHeroes();
    loadHeroIcons();
  }

  // Memuat ikon hero dari heroes.json
  Future<void> loadHeroIcons() async {
    final String response = await rootBundle.loadString('assets/heroes.json');
    final Map<String, dynamic> data = json.decode(response);
    final List<dynamic> heroes = data['heroes'];

    for (var hero in heroes) {
      heroIcons[hero['id']] = hero['image_url'];
    }

    // Pastikan setState hanya dipanggil jika widget masih aktif
    if (mounted) {
      setState(() {});
    }
  }

  // Mengambil data hero dari API
  Future<void> fetchHeroes() async {
    final response = await http.get(Uri.parse('https://api.opendota.com/api/heroStats'));

    if (response.statusCode == 200) {
      final List<dynamic> heroData = json.decode(response.body);
      // Pastikan setState hanya dipanggil jika widget masih aktif
      if (mounted) {
        setState(() {
          heroList = List<Map<String, dynamic>>.from(heroData);
          filteredHeroList = heroList;
        });
      }
    } else {
      throw Exception('Failed to load heroes');
    }
  }

  // Menampilkan dialog filter untuk atribut, jenis serangan, dan peran
  void showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filter Heroes'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildDropdownFilter(
                label: 'Primary Attribute',
                value: selectedPrimaryAttr,
                items: const ['str', 'agi', 'int', 'all'],
                itemLabels: const ['Strength', 'Agility', 'Intelligence', 'Universal'],
                onChanged: (value) => setState(() => selectedPrimaryAttr = value),
              ),
              buildDropdownFilter(
                label: 'Attack Type',
                value: selectedAttackType,
                items: const ['Melee', 'Ranged'],
                onChanged: (value) => setState(() => selectedAttackType = value),
              ),
              buildDropdownFilter(
                label: 'Role',
                value: selectedRolesType,
                items: const [
                  'Carry', 'Support', 'Nuker', 'Disabler', 'Jungler',
                  'Durable', 'Escape', 'Pusher', 'Initiator'
                ],
                onChanged: (value) => setState(() => selectedRolesType = value),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  selectedPrimaryAttr = null;
                  selectedAttackType = null;
                  selectedRolesType = null;
                  applyFilter();
                });
                Navigator.of(context).pop();
              },
              child: const Text('Reset Filter'),
            ),
            ElevatedButton(
              onPressed: () {
                applyFilter();
                Navigator.of(context).pop();
              },
              child: const Text('Apply Filter'),
            ),
          ],
        );
      },
    );
  }

  // Widget builder untuk dropdown filter
  DropdownButtonFormField<String> buildDropdownFilter({
    required String label,
    required String? value,
    required List<String> items,
    List<String>? itemLabels,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      hint: Text('Select $label'),
      items: items.map((item) {
        final labelText = itemLabels != null ? itemLabels[items.indexOf(item)] : item;
        return DropdownMenuItem(value: item, child: Text(labelText));
      }).toList(),
      onChanged: onChanged,
    );
  }

  // Menampilkan detail hero dalam dialog
  void showHeroDetails(Map<String, dynamic> hero) {
    // Function to map primary attributes to their display names
    String getPrimaryAttributeDisplayName(String primaryAttr) {
      switch (primaryAttr) {
        case 'str':
          return 'Strength';
        case 'agi':
          return 'Agility';
        case 'int':
          return 'Intelligence';
        case 'all':
          return 'Universal';
        default:
          return primaryAttr; // Fallback if value is unexpected
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(hero['localized_name'] ?? 'Hero Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildInfoRow("Primary Attribute", getPrimaryAttributeDisplayName(hero['primary_attr'].toString())),
                buildInfoRow("Attack Type", hero['attack_type'].toString()),
                buildInfoRow("Roles", (hero['roles'] as List).join(', ')),
                buildInfoRow("Base Health", hero['base_health'].toString()),
                buildInfoRow("Base Health Regen", hero['base_health_regen'].toString()),
                buildInfoRow("Base Mana", hero['base_mana'].toString()),
                buildInfoRow("Base Mana Regen", hero['base_mana_regen'].toString()),
                buildInfoRow("Base Armor", hero['base_armor'].toString()),
                buildInfoRow("Base Magic Resist", hero['base_mr'].toString()),
                buildInfoRow("Base Attack Min", hero['base_attack_min'].toString()),
                buildInfoRow("Base Attack Max", hero['base_attack_max'].toString()),
                buildInfoRow("Base Strength", hero['base_str'].toString()),
                buildInfoRow("Base Agility", hero['base_agi'].toString()),
                buildInfoRow("Base Intelligence", hero['base_int'].toString()),
                buildInfoRow("Strength Gain", hero['str_gain'].toString()),
                buildInfoRow("Agility Gain", hero['agi_gain'].toString()),
                buildInfoRow("Intelligence Gain", hero['int_gain'].toString()),
                buildInfoRow("Attack Range", hero['attack_range'].toString()),
                buildInfoRow("Projectile Speed", hero['projectile_speed'].toString()),
                buildInfoRow("Attack Rate", hero['attack_rate'].toString()),
                buildInfoRow("Base Attack Time", hero['base_attack_time'].toString()),
                buildInfoRow("Attack Point", hero['attack_point'].toString()),
                buildInfoRow("Move Speed", hero['move_speed'].toString()),
                buildInfoRow("Legs", hero['legs'].toString()),
                buildInfoRow("Day Vision", hero['day_vision'].toString()),
                buildInfoRow("Night Vision", hero['night_vision'].toString()),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  // Widget untuk baris informasi hero
  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          SizedBox(
            width: 150,
            child: Text(
              "$label:",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  // Mengaplikasikan filter pada daftar hero
  void applyFilter() {
    setState(() {
      filteredHeroList = heroList.where((hero) {
        final matchesPrimaryAttr = selectedPrimaryAttr == null ||
            hero['primary_attr'] == selectedPrimaryAttr;
        final matchesAttackType = selectedAttackType == null ||
            hero['attack_type'] == selectedAttackType;
        final matchesRole = selectedRolesType == null ||
            (hero['roles'] as List).contains(selectedRolesType);
        final matchesSearch = searchQuery.isEmpty ||
            (hero['localized_name'] as String).toLowerCase().contains(searchQuery.toLowerCase());

        return matchesPrimaryAttr && matchesAttackType && matchesRole && matchesSearch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Dota 2 Heroes'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Search Hero',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                        applyFilter();
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: showFilterDialog,
                  child: const Text('Filter Heroes'),
                ),
              ],
            ),
          ),
          Expanded(
            child: filteredHeroList.isEmpty
                ? const Center(
                    child: Text(
                      'Hero tidak ditemukan',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredHeroList.length,
                    itemBuilder: (context, index) {
                      final hero = filteredHeroList[index];
                      final heroImage = heroIcons[hero['id']] != null
                          ? NetworkImage(heroIcons[hero['id']]!)
                          : const AssetImage('assets/images/person_icon.png') as ImageProvider;

                      return HeroCard(
                        heroName: hero['localized_name'],
                        primaryAttr: hero['primary_attr'],
                        attackType: hero['attack_type'],
                        roles: (hero['roles'] as List).join(', '),
                        heroImage: heroImage,
                        onTap: () => showHeroDetails(hero),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// Widget terpisah untuk menampilkan setiap kartu hero
class HeroCard extends StatelessWidget {
  final String heroName;
  final String primaryAttr;
  final String attackType;
  final String roles;
  final ImageProvider heroImage;
  final VoidCallback onTap;

  const HeroCard({
    super.key,
    required this.heroName,
    required this.primaryAttr,
    required this.attackType,
    required this.roles,
    required this.heroImage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10.0),
        title: Text(
          heroName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5.0),
            Text(
              'Primary Attribute: ${primaryAttr == 'agi' ? 'Agility' : primaryAttr == 'str' ? 'Strength' : primaryAttr == 'int' ? 'Intelligence' : primaryAttr == 'all' ? 'Universal' : ''}',
            ),
            Text('Attack Type: $attackType'),
            Text('Roles: $roles'),
          ],
        ),
        leading: Container(
          width: 80, // Ukuran lebar gambar
          height: 50, // Ukuran tinggi gambar
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(4.0), // Menambahkan sedikit rounding pada sudut
            image: DecorationImage(
              image: heroImage,
              fit: BoxFit.cover,
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
