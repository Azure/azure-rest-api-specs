import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Network;

/**
 * The provisioning state of the resource. This is a read-only property and any attempt to set this value will be ignored.
 */
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
}

/**
 * The resolution policy on the virtual network link. Only applicable for virtual network links to privatelink zones, and for A,AAAA,CNAME queries. When set to 'NxDomainRedirect', Azure DNS resolver falls back to public resolution if private dns query resolution results in non-existent domain response.
 */
union ResolutionPolicy {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Default: "Default",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NxDomainRedirect: "NxDomainRedirect",
}

/**
 * The status of the virtual network link to the Private DNS zone. Possible values are 'InProgress' and 'Done'. This is a read-only property and any attempt to set this value will be ignored.
 */
union VirtualNetworkLinkState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Completed: "Completed",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

/**
 * Represents the properties of the Private DNS zone.
 */
model PrivateZoneProperties {
  /**
   * The maximum number of record sets that can be created in this Private DNS zone. This is a read-only property and any attempt to set this value will be ignored.
   */
  @visibility(Lifecycle.Read)
  maxNumberOfRecordSets?: int64;

  /**
   * The current number of record sets in this Private DNS zone. This is a read-only property and any attempt to set this value will be ignored.
   */
  @visibility(Lifecycle.Read)
  numberOfRecordSets?: int64;

  /**
   * The maximum number of virtual networks that can be linked to this Private DNS zone. This is a read-only property and any attempt to set this value will be ignored.
   */
  @visibility(Lifecycle.Read)
  maxNumberOfVirtualNetworkLinks?: int64;

  /**
   * The current number of virtual networks that are linked to this Private DNS zone. This is a read-only property and any attempt to set this value will be ignored.
   */
  @visibility(Lifecycle.Read)
  numberOfVirtualNetworkLinks?: int64;

  /**
   * The maximum number of virtual networks that can be linked to this Private DNS zone with registration enabled. This is a read-only property and any attempt to set this value will be ignored.
   */
  @visibility(Lifecycle.Read)
  maxNumberOfVirtualNetworkLinksWithRegistration?: int64;

  /**
   * The current number of virtual networks that are linked to this Private DNS zone with registration enabled. This is a read-only property and any attempt to set this value will be ignored.
   */
  @visibility(Lifecycle.Read)
  numberOfVirtualNetworkLinksWithRegistration?: int64;

  /**
   * The provisioning state of the resource. This is a read-only property and any attempt to set this value will be ignored.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Private zone internal Id
   */
  @visibility(Lifecycle.Read)
  internalId?: string;
}

/**
 * The core properties of ARM resources
 */
model Resource {
  /**
   * Fully qualified resource Id for the resource. Example - '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/privateDnsZones/{privateDnsZoneName}'.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. Example - 'Microsoft.Network/privateDnsZones'.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * An error response from the service.
 */
@error
model CloudError {
  /**
   * Cloud error body.
   */
  error?: CloudErrorBody;
}

/**
 * An error response from the service.
 */
model CloudErrorBody {
  /**
   * An identifier for the error. Codes are invariant and are intended to be consumed programmatically.
   */
  code?: string;

  /**
   * A message describing the error, intended to be suitable for display in a user interface.
   */
  message?: string;

  /**
   * The target of the particular error. For example, the name of the property in error.
   */
  target?: string;

  /**
   * A list of additional details about the error.
   */
  @identifiers(#["code"])
  details?: CloudErrorBody[];
}

/**
 * Represents the properties of the Private DNS zone.
 */
model VirtualNetworkLinkProperties {
  /**
   * The reference of the virtual network.
   */
  virtualNetwork?: SubResource;

  /**
   * Is auto-registration of virtual machine records in the virtual network in the Private DNS zone enabled?
   */
  registrationEnabled?: boolean;

  /**
   * The resolution policy on the virtual network link. Only applicable for virtual network links to privatelink zones, and for A,AAAA,CNAME queries. When set to 'NxDomainRedirect', Azure DNS resolver falls back to public resolution if private dns query resolution results in non-existent domain response.
   */
  resolutionPolicy?: ResolutionPolicy;

  /**
   * The status of the virtual network link to the Private DNS zone. Possible values are 'InProgress' and 'Done'. This is a read-only property and any attempt to set this value will be ignored.
   */
  @visibility(Lifecycle.Read)
  virtualNetworkLinkState?: VirtualNetworkLinkState;

  /**
   * The provisioning state of the resource. This is a read-only property and any attempt to set this value will be ignored.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Reference to another subresource.
 */
model SubResource {
  /**
   * Resource ID.
   */
  id?: string;
}

/**
 * Represents the properties of the records in the record set.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RecordSetProperties {
  /**
   * The metadata attached to the record set.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  metadata?: Record<string>;

  /**
   * The TTL (time-to-live) of the records in the record set.
   */
  ttl?: int64;

  /**
   * Fully qualified domain name of the record set.
   */
  @visibility(Lifecycle.Read)
  fqdn?: string;

  /**
   * Is the record set auto-registered in the Private DNS zone through a virtual network link?
   */
  @visibility(Lifecycle.Read)
  isAutoRegistered?: boolean;

  /**
   * The list of A records in the record set.
   */
  @identifiers(#["ipv4Address"])
  aRecords?: ARecord[];

  /**
   * The list of AAAA records in the record set.
   */
  @identifiers(#["ipv6Address"])
  aaaaRecords?: AaaaRecord[];

  /**
   * The CNAME record in the record set.
   */
  cnameRecord?: CnameRecord;

  /**
   * The list of MX records in the record set.
   */
  @identifiers(#[])
  mxRecords?: MxRecord[];

  /**
   * The list of PTR records in the record set.
   */
  @identifiers(#[])
  ptrRecords?: PtrRecord[];

  /**
   * The SOA record in the record set.
   */
  soaRecord?: SoaRecord;

  /**
   * The list of SRV records in the record set.
   */
  @identifiers(#[])
  srvRecords?: SrvRecord[];

  /**
   * The list of TXT records in the record set.
   */
  @identifiers(#[])
  txtRecords?: TxtRecord[];

  /**
   * A reference to an azure private traffic manager profile resource from where the record set value is taken. Cannot be combined with aRecords, aaaaRecords, or cnameRecord.
   */
  @added(Versions.v2026_06_01_preview)
  trafficManagementProfile?: SubResource;

  /**
   * The provisioning state of the record set. This is a read-only property and any attempt to set this value will be ignored.
   */
  @added(Versions.v2026_06_01_preview)
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Represents a single Azure resource and its referencing private DNS record sets.
 */
@added(Versions.v2026_06_01_preview)
model PrivateDnsResourceReference {
  /**
   * A list of private DNS record sets that reference the target resource.
   */
  privateDnsResources?: SubResource[];

  /**
   * A reference to an azure resource from where the private DNS resource value is taken.
   */
  targetResource?: SubResource;
}

/**
 * Represents the properties of the private DNS Resource Reference Request.
 */
@added(Versions.v2026_06_01_preview)
model PrivateDnsResourceReferenceRequest {
  /**
   * The properties of the Resource Reference Request.
   */
  properties?: PrivateDnsResourceReferenceRequestProperties;
}

/**
 * Represents the properties of the private DNS Resource Reference Request.
 */
@added(Versions.v2026_06_01_preview)
model PrivateDnsResourceReferenceRequestProperties {
  /**
   * A list of references to azure resources for which referencing private DNS records need to be queried.
   */
  targetResources?: SubResource[];
}

/**
 * Represents the properties of the private DNS Resource Reference Result.
 */
@added(Versions.v2026_06_01_preview)
model PrivateDnsResourceReferenceResult {
  /**
   * The result of private dns resource reference request. Returns a list of private dns resource references for each of the azure resource in the request.
   */
  properties?: PrivateDnsResourceReferenceResultProperties;
}

/**
 * The result of private dns resource reference request. Returns a list of private dns resource references for each of the azure resource in the request.
 */
@added(Versions.v2026_06_01_preview)
model PrivateDnsResourceReferenceResultProperties {
  /**
   * The result of private dns resource reference request. A list of private dns resource references for each of the azure resource in the request
   */
  @identifiers(#[])
  privateDnsResourceReferences?: PrivateDnsResourceReference[];
}

/**
 * An A record.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ARecord {
  /**
   * The IPv4 address of this A record.
   */
  ipv4Address?: string;
}

/**
 * An AAAA record.
 */
model AaaaRecord {
  /**
   * The IPv6 address of this AAAA record.
   */
  ipv6Address?: string;
}

/**
 * A CNAME record.
 */
model CnameRecord {
  /**
   * The canonical name for this CNAME record.
   */
  cname?: string;
}

/**
 * An MX record.
 */
model MxRecord {
  /**
   * The preference value for this MX record.
   */
  preference?: int32;

  /**
   * The domain name of the mail host for this MX record.
   */
  exchange?: string;
}

/**
 * A PTR record.
 */
model PtrRecord {
  /**
   * The PTR target domain name for this PTR record.
   */
  ptrdname?: string;
}

/**
 * An SOA record.
 */
model SoaRecord {
  /**
   * The domain name of the authoritative name server for this SOA record.
   */
  host?: string;

  /**
   * The email contact for this SOA record.
   */
  email?: string;

  /**
   * The serial number for this SOA record.
   */
  serialNumber?: int64;

  /**
   * The refresh value for this SOA record.
   */
  refreshTime?: int64;

  /**
   * The retry time for this SOA record.
   */
  retryTime?: int64;

  /**
   * The expire time for this SOA record.
   */
  expireTime?: int64;

  /**
   * The minimum value for this SOA record. By convention this is used to determine the negative caching duration.
   */
  minimumTtl?: int64;
}

/**
 * An SRV record.
 */
model SrvRecord {
  /**
   * The priority value for this SRV record.
   */
  priority?: int32;

  /**
   * The weight value for this SRV record.
   */
  weight?: int32;

  /**
   * The port value for this SRV record.
   */
  port?: int32;

  /**
   * The target domain name for this SRV record.
   */
  target?: string;
}

/**
 * A TXT record.
 */
model TxtRecord {
  /**
   * The text value of this TXT record.
   */
  value?: string[];
}
