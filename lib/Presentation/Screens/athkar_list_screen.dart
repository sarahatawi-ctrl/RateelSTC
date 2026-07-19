import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Domain/Entities/athkar_category.dart';
import '../../Domain/UseCases/get_athkar_category_content.dart';
import '../../Domain/UseCases/get_quick_athkar.dart';
import '../Providers/athkar_provider.dart';
import '../Widgets/athkar_item_card.dart';

class AthkarListScreen extends StatelessWidget {
  final String title;
  final AthkarQuickType? quickType;
  final int? categoryId;

  const AthkarListScreen({
    super.key,
    required this.title,
    this.quickType,
    this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) {
        final provider = AthkarProvider(
          getQuickAthkar: ctx.read<GetQuickAthkar>(),
          getAthkarCategoryContent: ctx.read<GetAthkarCategoryContent>(),
        );
        if (quickType != null) {
          provider.loadQuick(quickType!);
        } else if (categoryId != null) {
          provider.loadCategory(categoryId!);
        }
        return provider;
      },
      child: _AthkarListBody(title: title),
    );
  }
}

class _AthkarListBody extends StatelessWidget {
  final String title;

  const _AthkarListBody({required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<AthkarProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : provider.hasError
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    'تعذر تحميل المحتوى، تأكد من الاتصال بالإنترنت',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: provider.items.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: buildAthkarItemCard(
                    theme,
                    provider.items[index],
                    provider.remaining[index],
                    () => provider.tapItem(index),
                  ),
                ),
              ),
      ),
    );
  }
}
