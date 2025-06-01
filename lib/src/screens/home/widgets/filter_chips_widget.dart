import 'package:flutter/material.dart';

/// A horizontal scrollable widget displaying filter chips for pet expert specialties.
/// The selected chip is displayed first in the list.
class FilterChipsWidget extends StatelessWidget {
  /// List of filter options (e.g., ['All', 'Groomers', 'Vets']).
  final List<String> filters;

  /// Currently selected filter.
  final String selectedFilter;

  /// Callback triggered when a filter is selected.
  final ValueChanged<String> onFilterSelected;

  const FilterChipsWidget({
    super.key,
    required this.filters,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Create a reordered list with the selected filter first.
    // If selectedFilter is not in filters, use the original list.
    final displayFilters = selectedFilter.isNotEmpty && filters.contains(selectedFilter)
        ? [
            selectedFilter, // Place selected filter first
            ...filters.where((filter) => filter != selectedFilter), // Add remaining filters
          ]
        : filters;

    return SizedBox(
      height: screenHeight * 0.05, // Fixed height for horizontal scroll
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: displayFilters.length,
        itemBuilder: (context, index) {
          final filter = displayFilters[index];
          final isSelected = selectedFilter == filter;
          return Padding(
            padding: EdgeInsets.only(right: screenWidth * 0.03), // Spacing between chips
            child: GestureDetector(
              onTap: () => onFilterSelected(filter), // Trigger callback on tap
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.01,
                ),
                decoration: BoxDecoration(
                  // Apply gradient for selected chip, white background for unselected
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
                    // Filter label with dynamic styling based on selection
                    Text(
                      filter,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: screenWidth * 0.035,
                            color: isSelected
                                ? Colors.white
                                : Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'ComicNeue',
                          ),
                    ),
                    // Show paw icon for selected chip
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
    );
  }
}