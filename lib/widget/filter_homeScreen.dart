import 'package:flutter/material.dart';

class Filter extends StatefulWidget {
  final ValueChanged<List<String>> onFilterChanged;
  final bool isPinFilterActive;
  final VoidCallback onPinFilterToggle;

 Filter({
    required this.onFilterChanged,
    required this.isPinFilterActive,
    required this.onPinFilterToggle,
  });

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  List<String> selectedFilters = [];
  bool isPinButtonSelected = false;
  bool isStatusButtonSelected = false;
  bool isObjectButtonSelected = false;
  
  get isPinFilterActive => null;
  
  get onPinFilterToggle => null;

  void _toggleFilterOption(String option) {
    setState(() {
      if (selectedFilters.contains(option)) {
        selectedFilters.remove(option);
      } else {
        selectedFilters.add(option);
      }
      widget.onFilterChanged(selectedFilters);
    });
  }

  Widget _buildFilterOption(
      BuildContext context, String option, StateSetter setStateModal) {
    final isSelected = selectedFilters.contains(option);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: OutlinedButton(
        onPressed: () {
          setStateModal(() {
            _toggleFilterOption(option);
          });
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: isSelected
              ? const Color.fromRGBO(100, 3, 41, 1)
              : Colors.transparent,
          side: BorderSide(
              color: isSelected
                  ? const Color.fromRGBO(100, 3, 41, 1)
                  : Colors.grey,
              width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        ),
        child: Text(
          option,
          style: TextStyle(
            fontSize: 16,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  void _showFilterSheet(
      BuildContext context, List<String> options, String sheetTitle) {
    showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStateModal) {
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      sheetTitle,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  const Divider(),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: options
                        .map((String option) =>
                            _buildFilterOption(context, option, setStateModal))
                        .toList(),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // print(selectedFilters);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(100, 3, 41, 1),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 12),
                      ),
                      child:
                          const Text('Valider', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 0,
          left: 10,
          right: 10,
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: ElevatedButton(
                  onPressed: () => _showFilterSheet(
                      context,
                      [
                        'Administration',
                        'BDA',
                        'BDE',
                        'BDS',
                        'Clubs',
                        'JE',
                        'Professeurs',
                      ],
                      'Organisateur'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isStatusButtonSelected
                        ? const Color.fromRGBO(100, 3, 41, 1)
                        : const Color.fromRGBO(100, 3, 41, 0.6),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Organisateur',
                      style: TextStyle(fontSize: 15)),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: ElevatedButton(
                  onPressed: () => _showFilterSheet(
                      context,
                      [
                        'Afterwork',
                        'Conférence',
                        'Rencontre Club',
                        'Rencontre Sportive',
                        'Soirée',
                        'Sortie',
                      ],
                      'Sujet'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isObjectButtonSelected
                        ? const Color.fromRGBO(100, 3, 41, 1)
                        : const Color.fromRGBO(100, 3, 41, 0.6),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Sujet',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ),
          Padding(
              padding: const EdgeInsets.all(6.0),
              child: ElevatedButton(
                onPressed: widget.onPinFilterToggle,
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.isPinFilterActive
                      ? const Color.fromRGBO(100, 3, 41, 1)
                      : const Color.fromRGBO(100, 3, 41, 0.6),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // même rayon que les autres boutons
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
                child: Icon(
                  widget.isPinFilterActive ? Icons.push_pin : Icons.push_pin_outlined,
                  color: widget.isPinFilterActive ? Colors.white : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
