import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/loyalty_transaction_model.dart';
import '../../services/hive_service.dart';
import '../../constants/app_colors.dart';
import '../../utils/date_formatter.dart';

class LoyaltyHistoryScreen extends StatefulWidget {
  const LoyaltyHistoryScreen({super.key});

  @override
  State<LoyaltyHistoryScreen> createState() => _LoyaltyHistoryScreenState();
}

class _LoyaltyHistoryScreenState extends State<LoyaltyHistoryScreen> {
  List<LoyaltyTransactionModel> transactions = [];

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  void _loadTransactions() {
    // In real app, fetch from API or Hive
    // For demo, showing sample data
    setState(() {
      transactions = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Points History')),
      body: transactions.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.history,
                    size: 80,
                    color: AppColors.textLight,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No transaction history',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Complete bookings to earn points',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: transactions.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return _buildTransactionCard(context, transaction);
              },
            ),
    );
  }

  Widget _buildTransactionCard(
    BuildContext context,
    LoyaltyTransactionModel transaction,
  ) {
    final isEarning = transaction.isEarning;

    return Card(
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: (isEarning ? AppColors.success : AppColors.error)
                .withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            isEarning ? Icons.add_circle : Icons.remove_circle,
            color: isEarning ? AppColors.success : AppColors.error,
          ),
        ),
        title: Text(
          isEarning ? 'Points Earned' : 'Points Redeemed',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              DateFormatter.formatDateTime(transaction.createdAt),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            if (transaction.reference != null) ...[
              const SizedBox(height: 2),
              Text(
                'Booking: ${transaction.reference}',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.textLight),
              ),
            ],
          ],
        ),
        trailing: Text(
          '${isEarning ? '+' : '-'}${transaction.points}',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: isEarning ? AppColors.success : AppColors.error,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
