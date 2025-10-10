using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Oracle.Database;

@added(Versions.v20250401_preview)
@doc("Network Anchor resource model.")
model NetworkAnchor is TrackedResource<NetworkAnchorProperties> {
  ...ResourceNameParameter<NetworkAnchor>;
  ...AvailabilityZonesProperty;
}

@added(Versions.v20250401_preview)
@doc("Network Anchor properties")
model NetworkAnchorProperties {
  @doc("Corresponding resource anchor Azure ID")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  resourceAnchorId: string;

  @doc("NetworkAnchor provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: AzureResourceProvisioningState;

  @doc("VNET for network connectivity")
  @visibility(Lifecycle.Read)
  vnetId?: VnetId;

  @doc("Client subnet")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  subnetId: SubnetId;

  @doc("Delegated Azure subnet cidr block.")
  @visibility(Lifecycle.Read)
  cidrBlock?: string;

  @doc("Oracle Cloud Infrastructure VCN OCID")
  @visibility(Lifecycle.Read)
  ociVcnId?: Ocid;

  @doc("OCI DNS label. This is optional if DNS config is provided.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  ociVcnDnsLabel?: string;

  @doc("Oracle Cloud Infrastructure subnet OCID")
  @visibility(Lifecycle.Read)
  ociSubnetId?: Ocid;

  @doc("OCI backup subnet cidr block.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  ociBackupCidrBlock?: string;

  @added(Versions.v20250701_preview)
  @doc("Indicates whether DNS zone sync from OCI to Azure is enabled")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  isOracleToAzureDnsZoneSyncEnabled?: boolean = false;

  @added(Versions.v20250701_preview)
  @doc("Indicates whether the Oracle DNS listening endpoint is enabled")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  isOracleDnsListeningEndpointEnabled?: boolean = false;

  @added(Versions.v20250701_preview)
  @doc("Indicates whether the Oracle DNS forwarding endpoint is enabled")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  isOracleDnsForwardingEndpointEnabled?: boolean = false;

  @added(Versions.v20250701_preview)
  @doc("DNS forwarding rules")
  @visibility(Lifecycle.Create)
  @Azure.ResourceManager.identifiers(#[])
  dnsForwardingRules?: DnsForwardingRule[];

  @added(Versions.v20250701_preview)
  @doc("Comma-separated list of CIDRs that are allowed to send requests to the DNS listening endpoint")
  @visibility(Lifecycle.Create)
  dnsListeningEndpointAllowedCidrs?: string;

  @added(Versions.v20250701_preview)
  @doc("DNS listening endpoint IP address")
  @visibility(Lifecycle.Read)
  dnsListeningEndpointIpAddress?: string;

  @added(Versions.v20250701_preview)
  @doc("DNS forwarding endpoint IP address")
  @visibility(Lifecycle.Read)
  dnsForwardingEndpointIpAddress?: string;

  @added(Versions.v20250701_preview)
  @doc("Deep link to OCI console DNS Forwarding rules page")
  @visibility(Lifecycle.Read)
  dnsForwardingRulesUrl?: string;

  @added(Versions.v20250701_preview)
  @doc("Deep link to OCI console DNS Listening endpoint NSG rules")
  @visibility(Lifecycle.Read)
  dnsListeningEndpointNsgRulesUrl?: string;

  @added(Versions.v20250701_preview)
  @doc("Deep link to OCI console DNS Forwarding endpoint NSG rules")
  @visibility(Lifecycle.Read)
  dnsForwardingEndpointNsgRulesUrl?: string;
}

@added(Versions.v20250701_preview)
@doc("DNS forwarding rule properties")
model DnsForwardingRule {
  @doc("Comma-separated domain names")
  @visibility(Lifecycle.Create)
  domainNames: string;

  @doc("Forwarding ip address")
  @visibility(Lifecycle.Create)
  forwardingIpAddress: string;
}
