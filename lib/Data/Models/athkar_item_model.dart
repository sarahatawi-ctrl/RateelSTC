import '../../Domain/Entities/athkar_item.dart';

class AthkarItemModel extends AthkarItem {
  AthkarItemModel({required super.text, required super.repeat, super.footnote});

  factory AthkarItemModel.fromMuslimKitJson(Map<String, dynamic> json) {
    return AthkarItemModel(
      text: json['zekr'] ?? '',
      repeat: json['repeat'] ?? 1,
      footnote: (json['bless'] as String?)?.isNotEmpty == true
          ? json['bless']
          : null,
    );
  }

  factory AthkarItemModel.fromHisnMuslimJson(Map<String, dynamic> json) {
    return AthkarItemModel(
      text: json['ARABIC_TEXT'] ?? '',
      repeat: json['REPEAT'] ?? 1,
    );
  }
}
