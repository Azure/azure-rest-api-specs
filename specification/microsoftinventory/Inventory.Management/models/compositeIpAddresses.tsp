import "./common.tsp";

@doc("compositeIpAddresses Properties")
model CompositeIpAddressesProperties {
  @doc("IPv4 or IPv6 address")
  ipAddress: string;

  @doc("Version of the IP address")
  ipAddressVersion: string;

  @doc("Signal event type")
  ipAddressState: string;

  @doc("Cloud location of the IP Address")
  cloud: string;

  @doc("UTC timestamp when this change occurred")
  eventTimestamp: string;

  @doc("Upstream data source name emitting the signal")
  dataSource: string;

  @doc("Ownership attribution of the IP Address")
  ownershipAttributes: OwnershipAttributesObject;

  @doc("Resource attribution which is hosting the IP Address")
  resourceAttributes: ResourceAttributesObject;

  @doc("IPAM tags metadata associated with the parent IP range of the IP Address")
  ipamMetadata: IpamMetadataObject;

  @doc("Provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Model that describes the Ownership Attributes object for CompositeIPAddresses")
model OwnershipAttributesObject {
  @doc("Owner service level (Service|Component)")
  ownerServiceLevel: string;

  @doc("Owner service tree ID")
  ownerServiceTreeId: string;

  @doc("Owner service tree name")
  ownerServiceTreeName: string;

  @doc("Owner component ID (if available)")
  ownerComponentId: string;

  @doc("Customer subscription ID")
  customerSubscriptionId: string;

  @doc("Customer service tree ID")
  customerServiceTreeId: string;

  @doc("Customer service tree name")
  customerServiceTreeName: string;

  @doc("Beneficiary type (Hosted/Managed OBO)")
  beneficiaryType: string;

  @doc("Subscription offer ID")
  offerId: string;

  @doc("Customer type (1P|3P)")
  customerType: string;

  @doc("IP owner role")
  ipOwnerRole: string;
}

@doc("Model that describes the Resource Attributes object for CompositeIPAddresses")
model ResourceAttributesObject {
  @doc("Provider resource ID")
  providerResourceId: string;

  @doc("Provider resource type")
  providerResourceType: string;

  @doc("Resource ID assigned to IP Address")
  assignedToResourceId: string;

  @doc("Resource ID type assigned to IP Address")
  assignedToResourceType: string;
}

@doc("Model that describes the IPAM Metadata object for CompositeIPAddresses")
model IpamMetadataObject {
  @doc("Parent IP range")
  prefix: string;

  @doc("Allocation type")
  allocationType: string;

  @doc("Property Group")
  propertyGroup: string;

  @doc("Cloud location of the IP Address")
  cloud: string;

  @doc("Region of the IP Address")
  region: string;

  @doc("Network type (PRIVATE|PUBLIC)")
  networkType: string;

  @doc("Is IP Reused (for Private IPs only)")
  isReused: boolean;

  @doc("IPAM modeled ARM Resource ID")
  ipamId: string;
}
