class Resource {
  final String name;
  final int quantity;
  final String type;

  Resource({required this.name, required this.quantity, required this.type});
}

class ResourceRequest {
  final String coordinatorName;
  final String resourceName;
  final int requestedQuantity;
  final String reason;

  ResourceRequest({
    required this.coordinatorName,
    required this.resourceName,
    required this.requestedQuantity,
    required this.reason,
  });
}

class DonatedResource {
  final String donorName;
  final String resourceName;
  final int donatedQuantity;

  DonatedResource({
    required this.donorName,
    required this.resourceName,
    required this.donatedQuantity,
  });
}
