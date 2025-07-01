using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

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
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#[])
  dnsForwardingRules?: DnsForwardingRule[];

  @added(Versions.v20250701_preview)
  @doc("DNS listening endpoint IP address")
  @visibility(Lifecycle.Read)
  dnsListeningEndpointIpAddress?: string;

  @added(Versions.v20250701_preview)
  @doc("DNS forwarding endpoint IP address")
  @visibility(Lifecycle.Read)
  dnsForwardingEndpointIpAddress?: string;
}

@added(Versions.v20250701_preview)
@doc("DNS forwarding rule properties")
model DnsForwardingRule {
  @doc("Domain name")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  domainName: string;

  @doc("Forwarding ip address")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  forwardingIpAddress: string;
}
