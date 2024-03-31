class Portal {
  int portalID;
  String portalName;
  int isActive;

  Portal({
    required this.portalID,
    required this.portalName,
    required this.isActive,
  });

  factory Portal.fromJson(Map<String, dynamic> json) {
    return Portal(
      portalID: json['CoursePortalID'],
      portalName: json['CoursePortalName'],
      isActive: json['isActive'] ?? 1,
    );
  }
}
