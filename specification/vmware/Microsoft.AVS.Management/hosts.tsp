namespace Microsoft.AVS;

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@armResourceOperations
interface Hosts {
  @added(Versions.v2024_09_01)
  list is ArmResourceListByParent<Host>;

  @added(Versions.v2024_09_01)
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
  @visibility(Lifecycle.Create, Lifecycle.Read)
  kind: HostKind;

  @doc("The state of the host provisioning.")
  @visibility(Lifecycle.Read)
  provisioningState?: HostProvisioningState;

  @doc("Display name of the host in VMware vCenter.")
  displayName?: string;

  @doc("vCenter managed object reference ID of the host.")
  @visibility(Lifecycle.Read)
  moRefId?: string;

  @doc("Fully qualified domain name of the host.")
  @maxLength(255)
  @minLength(1)
  @visibility(Lifecycle.Read)
  fqdn?: string;

  @doc("If provided, the host is in maintenance. The value is the reason for maintenance.")
  maintenance?: HostMaintenance;

  @visibility(Lifecycle.Read)
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
