import 'package:flutter/material.dart';

class PetExpertsScreen extends StatefulWidget {
  final List<Map<String, dynamic>> providers;

  const PetExpertsScreen({super.key, required this.providers});

  @override
  _PetExpertsScreenState createState() => _PetExpertsScreenState();
}

class _PetExpertsScreenState extends State<PetExpertsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';
  String _searchQuery = '';

  final List<String> filters = [
    'All',
    'Groomers',
    'Vets',
    'Trainers',
    'Sitters',
    'Walkers',
  ];

  List<Map<String, dynamic>> get filteredProviders {
    return widget.providers.where((provider) {
      final matchesFilter = _selectedFilter == 'All' || provider['specialty'] == _selectedFilter;
      final matchesSearch = provider['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          provider['specialty'].toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesFilter && matchesSearch;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          "Pet Experts",
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontSize: screenWidth * 0.05,
                color: Theme.of(context).primaryColor,
                fontFamily: 'ComicNeue',
                fontWeight: FontWeight.bold,
              ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryColor,
            size: screenWidth * 0.06,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.02),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.pets,
                    size: screenWidth * 0.06,
                    color: Theme.of(context).primaryColor,
                  ),
                  hintText: 'Search pet experts...',
                  hintStyle: TextStyle(
                    fontFamily: 'ComicNeue',
                    color: Colors.grey[400],
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.9),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              SizedBox(
                height: screenHeight * 0.05,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  itemBuilder: (context, index) {
                    final isSelected = _selectedFilter == filters[index];
                    return Padding(
                      padding: EdgeInsets.only(right: screenWidth * 0.03),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedFilter = filters[index];
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.04,
                            vertical: screenHeight * 0.01,
                          ),
                          decoration: BoxDecoration(
                            gradient: isSelected
                                ? LinearGradient(
                                    colors: [
                                      Theme.of(context).primaryColor,
                                      const Color(0xFFFF80AB),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                : null,
                            color: isSelected ? null : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Theme.of(context).primaryColor.withOpacity(0.3),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Text(
                                filters[index],
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontSize: screenWidth * 0.035,
                                      color: isSelected
                                          ? Colors.white
                                          : Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'ComicNeue',
                                    ),
                              ),
                              if (isSelected) ...[
                                SizedBox(width: screenWidth * 0.02),
                                Icon(
                                  Icons.pets,
                                  size: screenWidth * 0.04,
                                  color: Colors.white,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredProviders.length,
                itemBuilder: (context, index) {
                  final provider = filteredProviders[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                    child: GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Selected: ${provider['name']} (${provider['specialty']})"),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).primaryColor.withOpacity(0.15),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(screenWidth * 0.04),
                          child: Row(
                            children: [
                              Container(
                                width: screenWidth * 0.15,
                                height: screenWidth * 0.15,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                                    width: 4,
                                  ),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white,
                                      Theme.of(context).primaryColor.withOpacity(0.05),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: screenWidth * 0.07,
                                  backgroundColor: const Color(0xFFFFF3F6),
                                  child: Icon(
                                    provider['icon'],
                                    size: screenWidth * 0.08,
                                    color: const Color(0xFFFF80AB),
                                  ),
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.04),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      provider['name'],
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.04,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'ComicNeue',
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: screenHeight * 0.005),
                                    Text(
                                      provider['specialty'],
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.03,
                                        color: Colors.grey[700],
                                        fontFamily: 'ComicNeue',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.01),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star_rounded,
                                          size: screenWidth * 0.05,
                                          color: const Color(0xFFFFB300),
                                        ),
                                        SizedBox(width: screenWidth * 0.01),
                                        Text(
                                          provider['rating'].toString(),
                                          style: TextStyle(
                                            fontSize: screenWidth * 0.035,
                                            color: Theme.of(context).primaryColor,
                                            fontFamily: 'ComicNeue',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}