class ServiceModel {
  final String id;
  final String name; // "Design", "Posts", "Website", "Mobile App"...
  final bool isQuantityBased; // true = counted (e.g. 5/month), false = project-based (%)
  final int? contractedQty;
  final int? consumedQty;
  final int? progressPercent;

  const ServiceModel({
    required this.id,
    required this.name,
    this.isQuantityBased = true,
    this.contractedQty,
    this.consumedQty,
    this.progressPercent,
  });

  String get quotaLabel {
    if (isQuantityBased) {
      if (contractedQty != null && consumedQty != null) {
        return '$consumedQty/$contractedQty';
      }
      return '';
    } else {
      if (progressPercent != null) {
        return '$progressPercent%';
      }
      return '';
    }
  }
}
