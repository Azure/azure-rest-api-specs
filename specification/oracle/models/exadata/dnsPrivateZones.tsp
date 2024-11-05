using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Oracle.Database;

// https://docs.oracle.com/en-us/iaas/api/#/en/dns/20180115/

@doc("DnsPrivateZone resource definition")
@parentResource(SubscriptionLocationResource)
model DnsPrivateZone is ProxyResource<DnsPrivateZoneProperties> {
  @doc("DnsPrivateZone name")
  @key("dnsprivatezonename")
  @path
  @segment("dnsPrivateZones")
  @pattern(".*")
  name: string;
}

@doc("Zones resource model")
model DnsPrivateZoneProperties {
  @doc("The OCID of the Zone")
  @visibility("read")
  ocid?: Ocid;

  @doc("A Boolean flag indicating whether or not parts of the resource are unable to be explicitly managed.")
  @visibility("read")
  isProtected?: boolean;

  @doc("Zones lifecycleState")
  @visibility("read")
  lifecycleState?: DnsPrivateZonesLifecycleState;

  @doc("The canonical absolute URL of the resource.")
  @visibility("read")
  self?: string;

  @doc("The current serial of the zone. As seen in the zone's SOA record.")
  @visibility("read")
  serial?: int32;

  @doc("Version is the never-repeating, totally-orderable, version of the zone, from which the serial field of the zone's SOA record is derived.")
  @visibility("read")
  version?: string;

  @doc("The OCID of the private view containing the zone. This value will be null for zones in the global DNS, which are publicly resolvable and not part of a private view.")
  @visibility("read")
  viewId?: Ocid;

  @doc("The type of the zone. Must be either PRIMARY or SECONDARY. SECONDARY is only supported for GLOBAL zones.")
  @visibility("read")
  zoneType?: ZoneType;

  @doc("Zones timeCreated")
  @visibility("read")
  timeCreated?: utcDateTime;

  @doc("Azure resource provisioning state.")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

@doc("DNS Private Zones lifecycle state enum")
union DnsPrivateZonesLifecycleState {
  @doc("DNS Private Zones is active")
  Active: "Active",

  @doc("DNS Private Zones is creating")
  Creating: "Creating",

  @doc("DNS Private Zones is deleted")
  Deleted: "Deleted",

  @doc("DNS Private Zones is deleting")
  Deleting: "Deleting",

  @doc("DNS Private Zones is updating")
  Updating: "Updating",

  string,
}

@doc("Zone type enum")
union ZoneType {
  @doc("Primary zone")
  Primary: "Primary",

  @doc("Secondary zone")
  Secondary: "Secondary",

  string,
}
