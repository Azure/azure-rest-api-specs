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
}
