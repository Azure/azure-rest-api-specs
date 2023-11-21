import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace PrivateDnsManagementClient;

enum ProvisioningState {
  Creating,
  Updating,
  Deleting,
  Succeeded,
  Failed,
  Canceled,
}

enum VirtualNetworkLinkState {
  InProgress,
  Completed,
}
@Azure.Core.fixed
enum RecordType {
  A,
  AAAA,
  CNAME,
  MX,
  PTR,
  SOA,
  SRV,
  TXT,
}

@doc("Describes a Private DNS zone.")
model PrivateZone {
  ...TrackedResource;

  @doc("The ETag of the zone.")
  etag?: string;

  @doc("Properties of the Private DNS zone.")
  properties?: PrivateZoneProperties;
}

@doc("Represents the properties of the Private DNS zone.")
model PrivateZoneProperties {
  @doc("""
The maximum number of record sets that can be created in this Private DNS zone.
This is a read-only property and any attempt to set this value will be ignored.
""")
  @visibility("read")
  maxNumberOfRecordSets?: int32;

  @doc("""
The current number of record sets in this Private DNS zone. This is a read-only
property and any attempt to set this value will be ignored.
""")
  @visibility("read")
  numberOfRecordSets?: int32;

  @doc("""
The maximum number of virtual networks that can be linked to this Private DNS
zone. This is a read-only property and any attempt to set this value will be
ignored.
""")
  @visibility("read")
  maxNumberOfVirtualNetworkLinks?: int32;

  @doc("""
The current number of virtual networks that are linked to this Private DNS
zone. This is a read-only property and any attempt to set this value will be
ignored.
""")
  @visibility("read")
  numberOfVirtualNetworkLinks?: int32;

  @doc("""
The maximum number of virtual networks that can be linked to this Private DNS
zone with registration enabled. This is a read-only property and any attempt to
set this value will be ignored.
""")
  @visibility("read")
  maxNumberOfVirtualNetworkLinksWithRegistration?: int32;

  @doc("""
The current number of virtual networks that are linked to this Private DNS zone
with registration enabled. This is a read-only property and any attempt to set
this value will be ignored.
""")
  @visibility("read")
  numberOfVirtualNetworkLinksWithRegistration?: int32;

  @doc("""
The provisioning state of the resource. This is a read-only property and any
attempt to set this value will be ignored.
""")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Private zone internal Id")
  @visibility("read")
  internalId?: string;
}

@doc("The resource model definition for a ARM tracked top level resource")
model TrackedResource {
  ...Resource;

  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("The Azure Region where the resource lives")
  location?: string;
}

@doc("The core properties of ARM resources")
model Resource {
  @doc("""
Fully qualified resource Id for the resource. Example -
'/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/privateDnsZones/{privateDnsZoneName}'.
""")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. Example - 'Microsoft.Network/privateDnsZones'.")
  @visibility("read")
  type?: string;
}

@doc("An error response from the service.")
@error
model CloudError {
  @doc("Cloud error body.")
  error?: CloudErrorBody;
}

@doc("An error response from the service.")
model CloudErrorBody {
  @doc("""
An identifier for the error. Codes are invariant and are intended to be
consumed programmatically.
""")
  code?: string;

  @doc("""
A message describing the error, intended to be suitable for display in a user
interface.
""")
  message?: string;

  @doc("""
The target of the particular error. For example, the name of the property in
error.
""")
  target?: string;

  @doc("A list of additional details about the error.")
  details?: CloudErrorBody[];
}

@doc("The response to a Private DNS zone list operation.")
model PrivateZoneListResult is Azure.Core.Page<PrivateZone>;

@doc("Describes a link to virtual network for a Private DNS zone.")
model VirtualNetworkLink {
  ...TrackedResource;

  @doc("The ETag of the virtual network link.")
  etag?: string;

  @doc("Properties of the virtual network link to the Private DNS zone.")
  properties?: VirtualNetworkLinkProperties;
}

@doc("Represents the properties of the Private DNS zone.")
model VirtualNetworkLinkProperties {
  @doc("The reference of the virtual network.")
  virtualNetwork?: SubResource;

  @doc("""
Is auto-registration of virtual machine records in the virtual network in the
Private DNS zone enabled?
""")
  registrationEnabled?: boolean;

  @doc("""
The status of the virtual network link to the Private DNS zone. Possible values
are 'InProgress' and 'Done'. This is a read-only property and any attempt to
set this value will be ignored.
""")
  @visibility("read")
  virtualNetworkLinkState?: VirtualNetworkLinkState;

  @doc("""
The provisioning state of the resource. This is a read-only property and any
attempt to set this value will be ignored.
""")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Reference to another subresource.")
model SubResource {
  @doc("Resource ID.")
  id?: string;
}

@doc("The response to a list virtual network link to Private DNS zone operation.")
model VirtualNetworkLinkListResult is Azure.Core.Page<VirtualNetworkLink>;

@doc("""
Describes a DNS record set (a collection of DNS records with the same name and
type) in a Private DNS zone.
""")
model RecordSet {
  ...ProxyResource;

  @doc("The ETag of the record set.")
  etag?: string;

  @doc("The properties of the record set.")
  properties?: RecordSetProperties;
}

@doc("Represents the properties of the records in the record set.")
model RecordSetProperties {
  @doc("The metadata attached to the record set.")
  metadata?: Record<string>;

  @doc("The TTL (time-to-live) of the records in the record set.")
  ttl?: int32;

  @doc("Fully qualified domain name of the record set.")
  @visibility("read")
  fqdn?: string;

  @doc("""
Is the record set auto-registered in the Private DNS zone through a virtual
network link?
""")
  @visibility("read")
  isAutoRegistered?: boolean;

  @doc("The list of A records in the record set.")
  aRecords?: ARecord[];

  @doc("The list of AAAA records in the record set.")
  aaaaRecords?: AaaaRecord[];

  @doc("The CNAME record in the record set.")
  cnameRecord?: CnameRecord;

  @doc("The list of MX records in the record set.")
  mxRecords?: MxRecord[];

  @doc("The list of PTR records in the record set.")
  ptrRecords?: PtrRecord[];

  @doc("The SOA record in the record set.")
  soaRecord?: SoaRecord;

  @doc("The list of SRV records in the record set.")
  srvRecords?: SrvRecord[];

  @doc("The list of TXT records in the record set.")
  txtRecords?: TxtRecord[];
}

@doc("An A record.")
model ARecord {
  @doc("The IPv4 address of this A record.")
  ipv4Address?: string;
}

@doc("An AAAA record.")
model AaaaRecord {
  @doc("The IPv6 address of this AAAA record.")
  ipv6Address?: string;
}

@doc("A CNAME record.")
model CnameRecord {
  @doc("The canonical name for this CNAME record.")
  cname?: string;
}

@doc("An MX record.")
model MxRecord {
  @doc("The preference value for this MX record.")
  preference?: int32;

  @doc("The domain name of the mail host for this MX record.")
  exchange?: string;
}

@doc("A PTR record.")
model PtrRecord {
  @doc("The PTR target domain name for this PTR record.")
  ptrdname?: string;
}

@doc("An SOA record.")
model SoaRecord {
  @doc("The domain name of the authoritative name server for this SOA record.")
  host?: string;

  @doc("The email contact for this SOA record.")
  email?: string;

  @doc("The serial number for this SOA record.")
  serialNumber?: int32;

  @doc("The refresh value for this SOA record.")
  refreshTime?: int32;

  @doc("The retry time for this SOA record.")
  retryTime?: int32;

  @doc("The expire time for this SOA record.")
  expireTime?: int32;

  @doc("""
The minimum value for this SOA record. By convention this is used to determine
the negative caching duration.
""")
  minimumTtl?: int32;
}

@doc("An SRV record.")
model SrvRecord {
  @doc("The priority value for this SRV record.")
  priority?: int32;

  @doc("The weight value for this SRV record.")
  weight?: int32;

  @doc("The port value for this SRV record.")
  port?: int32;

  @doc("The target domain name for this SRV record.")
  target?: string;
}

@doc("A TXT record.")
model TxtRecord {
  @doc("The text value of this TXT record.")
  value?: string[];
}

@doc("The resource model definition for an ARM proxy resource.")
model ProxyResource {
  ...Resource;
}

@doc("The response to a record set list operation.")
model RecordSetListResult is Azure.Core.Page<RecordSet>;
