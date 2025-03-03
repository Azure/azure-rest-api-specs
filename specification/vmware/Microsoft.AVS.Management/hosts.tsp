namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@armResourceOperations
interface Hosts {
  @added(Versions.v2024_09_01_preview)
  list is ArmResourceListByParent<Host>;

  @added(Versions.v2024_09_01_preview)
  get is ArmResourceRead<Host>;
}

@doc("A host resource")
@parentResource(Cluster)
model Host is ProxyResource<HostProperties> {
  ...AvailabilityZones;
  ...ResourceSkuProperty;

  @doc("The host identifier.")
  @pattern("^[-\\w\\._]+$")
  @key("hostId")
  @path
  @segment("hosts")
  name: string;
}

@doc("The kind of host.")
union HostKind {
  General: "General",
  Specialized: "Specialized",
  string,
}

@doc("The properties of a host.")
@discriminator("kind")
model HostProperties {
  @doc("The kind of host")
  @visibility("create", "read")
  kind: HostKind;

  @doc("The state of the host provisioning.")
  @visibility("read")
  provisioningState?: HostProvisioningState;

  @doc("Display name of the host in VMware vCenter.")
  displayName?: string;

  @doc("vCenter managed object reference ID of the host.")
  @visibility("read")
  moRefId?: string;

  @doc("Fully qualified domain name of the host.")
  @maxLength(255)
  @minLength(1)
  @visibility("read")
  fqdn?: string;

  @doc("If provided, the host is in maintenance. The value is the reason for maintenance.")
  maintenance?: HostMaintenance;

  @visibility("read")
  faultDomain?: string;
}

@doc("The properties of a general host.")
model GeneralHostProperties extends HostProperties {
  @doc("The kind of host.")
  kind: HostKind.General;
}

@doc("The properties of a specialized host.")
model SpecializedHostProperties extends HostProperties {
  @doc("The kind of host is specialized.")
  kind: HostKind.Specialized;
}

@doc("The reason for host maintenance.")
union HostMaintenance {
  string,

  @doc("The host is a replacement host.")
  Replacement: "Replacement",

  @doc("The host is for an upgrade, such as an upgrade to ESXi, NSX-T, or other component.")
  Upgrade: "Upgrade",
}

@doc("provisioning state of the host")
union HostProvisioningState {
  string,
  ResourceProvisioningState,
}
