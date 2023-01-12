import 'package:equatable/equatable.dart';

class BuildItem extends Equatable {
  final String? uid;
  final String? applicationName;
  final String? websiteUrl;
  final String? primaryColor;
  final String? bundleId;
  final DateTime? createdAt;
  final String? version;
  final String? versionNumber;
  final String? iconUrl;
  final String? sourceUrl;
  final DateTime? updatedAt;
  final String? keystoreUrl;
  final String? status;
  final String? buildUrl;

  const BuildItem({
    this.uid,
    this.applicationName,
    this.websiteUrl,
    this.primaryColor,
    this.bundleId,
    this.createdAt,
    this.version,
    this.versionNumber,
    this.iconUrl,
    this.sourceUrl,
    this.updatedAt,
    this.keystoreUrl,
    this.status,
    this.buildUrl,
  });

  factory BuildItem.fromJson(Map<String, dynamic> json) => BuildItem(
        uid: json['uid'] as String?,
        applicationName: json['application_name'] as String?,
        websiteUrl: json['website_url'] as String?,
        primaryColor: json['primary_color'] as String?,
        bundleId: json['bundle_id'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        version: json['version'] as String?,
        versionNumber: json['version_number'] as String?,
        iconUrl: json['icon_url'] as String?,
        sourceUrl: json['source_url'] as String?,
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        keystoreUrl: json['keystore_url'] as String?,
        status: json['status'] as String?,
        buildUrl: json['build_url'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'application_name': applicationName,
        'website_url': websiteUrl,
        'primary_color': primaryColor,
        'bundle_id': bundleId,
        'created_at': createdAt?.toIso8601String(),
        'version': version,
        'version_number': versionNumber,
        'icon_url': iconUrl,
        'source_url': sourceUrl,
        'updated_at': updatedAt?.toIso8601String(),
        'keystore_url': keystoreUrl,
        'status': status,
        'build_url': buildUrl,
      };

  BuildItem copyWith({
    String? uid,
    String? applicationName,
    String? websiteUrl,
    String? primaryColor,
    String? bundleId,
    DateTime? createdAt,
    String? version,
    String? versionNumber,
    String? iconUrl,
    String? sourceUrl,
    DateTime? updatedAt,
    String? keystoreUrl,
    String? status,
    String? buildUrl,
  }) {
    return BuildItem(
      uid: uid ?? this.uid,
      applicationName: applicationName ?? this.applicationName,
      websiteUrl: websiteUrl ?? this.websiteUrl,
      primaryColor: primaryColor ?? this.primaryColor,
      bundleId: bundleId ?? this.bundleId,
      createdAt: createdAt ?? this.createdAt,
      version: version ?? this.version,
      versionNumber: versionNumber ?? this.versionNumber,
      iconUrl: iconUrl ?? this.iconUrl,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      updatedAt: updatedAt ?? this.updatedAt,
      keystoreUrl: keystoreUrl ?? this.keystoreUrl,
      status: status ?? this.status,
      buildUrl: buildUrl ?? this.buildUrl,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      uid,
      applicationName,
      websiteUrl,
      primaryColor,
      bundleId,
      createdAt,
      version,
      versionNumber,
      iconUrl,
      sourceUrl,
      updatedAt,
      keystoreUrl,
      status,
      buildUrl,
    ];
  }
}
