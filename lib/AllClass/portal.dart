class Portal {
  int portalID;
  String portalName;
  String portalDescription;
  int isActive;

  Portal({
    required this.portalID,
    required this.portalName,
    required this.portalDescription,
    required this.isActive,
  });

  factory Portal.fromJson(Map<String, dynamic> json) {
    return Portal(
      portalID: json['PortalID'],
      portalName: json['PortalName'],
      portalDescription: json['PortalDescription'],
      isActive: json['IsActive'],
    );
  }
}