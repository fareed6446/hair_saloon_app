import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/stylist_model.dart';
import '../../services/hive_service.dart';
import '../../constants/app_colors.dart';

class SelectStylistScreen extends StatefulWidget {
  const SelectStylistScreen({super.key});

  @override
  State<SelectStylistScreen> createState() => _SelectStylistScreenState();
}

class _SelectStylistScreenState extends State<SelectStylistScreen> {
  List<StylistModel> stylists = [];
  StylistModel? selectedStylist;

  @override
  void initState() {
    super.initState();
    _loadStylists();
  }

  void _loadStylists() {
    setState(() {
      stylists = HiveService.getStylists();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Stylist')),
      body: stylists.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.person_search,
                    size: 80,
                    color: AppColors.textLight,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No stylists available',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'You can proceed without selecting a stylist',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Get.back(result: null),
                    child: const Text('Continue'),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                // Header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  color: AppColors.primary.withOpacity(0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Choose Your Stylist',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Or skip to let us assign one for you',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),

                // Stylists List
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: stylists.length,
                    itemBuilder: (context, index) {
                      final stylist = stylists[index];
                      return _buildStylistCard(stylist);
                    },
                  ),
                ),

                // Bottom Buttons
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Get.back(result: null),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: const Text('Skip'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: selectedStylist != null
                                ? () => Get.back(result: selectedStylist)
                                : null,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: const Text('Confirm Selection'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildStylistCard(StylistModel stylist) {
    final isSelected = selectedStylist?.id == stylist.id;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: isSelected ? AppColors.primary.withOpacity(0.05) : null,
      child: InkWell(
        onTap: () {
          setState(() {
            selectedStylist = stylist;
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Stylist Avatar
              CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child: stylist.imageUrl != null
                    ? ClipOval(
                        child: Image.network(
                          stylist.imageUrl!,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.person,
                              size: 30,
                              color: AppColors.primary,
                            );
                          },
                        ),
                      )
                    : const Icon(
                        Icons.person,
                        size: 30,
                        color: AppColors.primary,
                      ),
              ),
              const SizedBox(width: 16),

              // Stylist Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stylist.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (stylist.specialties.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        stylist.specialties.join(', '),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                    if (stylist.rating != null) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 16, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text(
                            stylist.rating!.toStringAsFixed(1),
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              // Selection Radio
              Radio<StylistModel>(
                value: stylist,
                groupValue: selectedStylist,
                onChanged: (value) {
                  setState(() {
                    selectedStylist = value;
                  });
                },
                activeColor: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
