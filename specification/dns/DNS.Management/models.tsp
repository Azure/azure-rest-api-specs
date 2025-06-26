import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Network;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum RecordType {
  A,
  AAAA,
  CAA,
  CNAME,
  MX,
  NS,
  PTR,
  SOA,
  SRV,
  TXT,
  TLSA,
  DS,
  NAPTR,
}

/**
 * The type of this DNS zone (Public or Private).
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ZoneType {
  Public,
  Private,
}

/**
 * Represents the DNSSEC properties.
 */
model DnssecProperties {
  /**
   * Provisioning State of the DNSSEC configuration.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The list of signing keys.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  signingKeys?: SigningKey[];
}

/**
 * Represents the signing key.
 */
model SigningKey {
  /**
   * The delegation signer information.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  delegationSignerInfo?: DelegationSignerInfo[];

  /**
   * The flags specifies how the key is used.
   */
  @visibility(Lifecycle.Read)
  flags?: int32;

  /**
   * The key tag value of the DNSKEY Resource Record.
   */
  @visibility(Lifecycle.Read)
  keyTag?: int32;

  /**
   * The protocol value. The value is always 3.
   */
  @visibility(Lifecycle.Read)
  protocol?: int32;

  /**
   * The public key, represented as a Base64 encoding.
   */
  @visibility(Lifecycle.Read)
  publicKey?: string;

  /**
   * The security algorithm type represents the standard security algorithm number of the DNSKEY Resource Record. See: https://www.iana.org/assignments/dns-sec-alg-numbers/dns-sec-alg-numbers.xhtml
   */
  @visibility(Lifecycle.Read)
  securityAlgorithmType?: int32;
}

/**
 * The delegation signer information.
 */
model DelegationSignerInfo {
  /**
   * The digest algorithm type represents the standard digest algorithm number used to construct the digest. See: https://www.iana.org/assignments/ds-rr-types/ds-rr-types.xhtml
   */
  @visibility(Lifecycle.Read)
  digestAlgorithmType?: int32;

  /**
   * The digest value is a cryptographic hash value of the referenced DNSKEY Resource Record.
   */
  @visibility(Lifecycle.Read)
  digestValue?: string;

  /**
   * The record represents a delegation signer (DS) record.
   */
  @visibility(Lifecycle.Read)
  record?: string;
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
  @OpenAPI.extension("x-ms-identifiers", #[])
  details?: CloudErrorBody[];
}

/**
 * Represents the properties of the records in the record set.
 */
model RecordSetProperties {
  /**
   * The metadata attached to the record set.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  metadata?: Record<string>;

  /**
   * The TTL (time-to-live) of the records in the record set.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TTL?: int64;

  /**
   * Fully qualified domain name of the record set.
   */
  @visibility(Lifecycle.Read)
  fqdn?: string;

  /**
   * provisioning State of the record set.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * A reference to an azure resource from where the dns resource value is taken.
   */
  targetResource?: SubResource;

  /**
   * A reference to an azure traffic manager profile resource from where the dns resource value is taken.
   */
  trafficManagementProfile?: SubResource;

  /**
   * The list of A records in the record set.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.extension("x-ms-identifiers", #[])
  ARecords?: ARecord[];

  /**
   * The list of AAAA records in the record set.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.extension("x-ms-identifiers", #[])
  AAAARecords?: AaaaRecord[];

  /**
   * The list of MX records in the record set.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.extension("x-ms-identifiers", #[])
  MXRecords?: MxRecord[];

  /**
   * The list of NS records in the record set.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.extension("x-ms-identifiers", #[])
  NSRecords?: NsRecord[];

  /**
   * The list of PTR records in the record set.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.extension("x-ms-identifiers", #[])
  PTRRecords?: PtrRecord[];

  /**
   * The list of SRV records in the record set.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.extension("x-ms-identifiers", #[])
  SRVRecords?: SrvRecord[];

  /**
   * The list of TXT records in the record set.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.extension("x-ms-identifiers", #[])
  TXTRecords?: TxtRecord[];

  /**
   * The CNAME record in the  record set.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CNAMERecord?: CnameRecord;

  /**
   * The SOA record in the record set.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SOARecord?: SoaRecord;

  /**
   * The list of CAA records in the record set.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  caaRecords?: CaaRecord[];

  /**
   * The list of DS records in the record set.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.extension("x-ms-identifiers", #[])
  DSRecords?: DsRecord[];

  /**
   * The list of TLSA records in the record set.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.extension("x-ms-identifiers", #[])
  TLSARecords?: TlsaRecord[];

  /**
   * The list of NAPTR records in the record set.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.extension("x-ms-identifiers", #[])
  NAPTRRecords?: NaptrRecord[];
}

/**
 * A reference to a another resource
 */
model SubResource {
  /**
   * Resource Id.
   */
  id?: string;
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
 * An NS record.
 */
model NsRecord {
  /**
   * The name server name for this NS record.
   */
  nsdname?: string;
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
  @OpenAPI.extension("x-ms-identifiers", #[])
  value?: string[];
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  minimumTTL?: int64;
}

/**
 * A CAA record.
 */
model CaaRecord {
  /**
   * The flags for this CAA record as an integer between 0 and 255.
   */
  flags?: int32;

  /**
   * The tag for this CAA record.
   */
  tag?: string;

  /**
   * The value for this CAA record.
   */
  value?: string;
}

/**
 * A DS record. For more information about the DS record format, see RFC 4034: https://www.rfc-editor.org/rfc/rfc4034
 */
model DsRecord {
  /**
   * The key tag value is used to determine which DNSKEY Resource Record is used for signature verification.
   */
  keyTag?: int32;

  /**
   * The security algorithm type represents the standard security algorithm number of the DNSKEY Resource Record. See: https://www.iana.org/assignments/dns-sec-alg-numbers/dns-sec-alg-numbers.xhtml
   */
  algorithm?: int32;

  /**
   * The digest entity.
   */
  digest?: Digest;
}

/**
 * A digest.
 */
model Digest {
  /**
   * The digest algorithm type represents the standard digest algorithm number used to construct the digest. See: https://www.iana.org/assignments/ds-rr-types/ds-rr-types.xhtml
   */
  algorithmType?: int32;

  /**
   * The digest value is a cryptographic hash value of the referenced DNSKEY Resource Record.
   */
  value?: string;
}

/**
 * A TLSA record. For more information about the TLSA record format, see RFC 6698: https://www.rfc-editor.org/rfc/rfc6698
 */
model TlsaRecord {
  /**
   * The usage specifies the provided association that will be used to match the certificate presented in the TLS handshake.
   */
  usage?: int32;

  /**
   * The selector specifies which part of the TLS certificate presented by the server will be matched against the association data.
   */
  selector?: int32;

  /**
   * The matching type specifies how the certificate association is presented.
   */
  matchingType?: int32;

  /**
   * This specifies the certificate association data to be matched.
   */
  certAssociationData?: string;
}

/**
 * A NAPTR record. For more information about the NAPTR record format, see RFC 3403: https://www.rfc-editor.org/rfc/rfc3403
 */
model NaptrRecord {
  /**
   * The order in which the NAPTR records MUST be processed in order to accurately represent the ordered list of rules. The ordering is from lowest to highest. Valid values: 0-65535.
   */
  order?: int32;

  /**
   * The preference specifies the order in which NAPTR records with equal 'order' values should be processed, low numbers being processed before high numbers. Valid values: 0-65535.
   */
  preference?: int32;

  /**
   * The flags specific to DDDS applications. Values currently defined in RFC 3404 are uppercase and lowercase letters "A", "P", "S", and "U", and the empty string, "". Enclose Flags in quotation marks.
   */
  flags?: string;

  /**
   * The services specific to DDDS applications. Enclose Services in quotation marks.
   */
  services?: string;

  /**
   * The regular expression that the DDDS application uses to convert an input value into an output value. For example: an IP phone system might use a regular expression to convert a phone number that is entered by a user into a SIP URI. Enclose the regular expression in quotation marks. Specify either a value for 'regexp' or a value for 'replacement'.
   */
  regexp?: string;

  /**
   * The replacement is a fully qualified domain name (FQDN) of the next domain name that you want the DDDS application to submit a DNS query for. The DDDS application replaces the input value with the value specified for replacement. Specify either a value for 'regexp' or a value for 'replacement'. If you specify a value for 'regexp', specify a dot (.) for 'replacement'.
   */
  replacement?: string;
}

/**
 * Represents the properties of the zone.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ZoneProperties {
  /**
   * The maximum number of record sets that can be created in this DNS zone.  This is a read-only property and any attempt to set this value will be ignored.
   */
  @visibility(Lifecycle.Read)
  maxNumberOfRecordSets?: int64;

  /**
   * The maximum number of records per record set that can be created in this DNS zone.  This is a read-only property and any attempt to set this value will be ignored.
   */
  @visibility(Lifecycle.Read)
  maxNumberOfRecordsPerRecordSet?: int64;

  /**
   * The current number of record sets in this DNS zone.  This is a read-only property and any attempt to set this value will be ignored.
   */
  @visibility(Lifecycle.Read)
  numberOfRecordSets?: int64;

  /**
   * The name servers for this DNS zone. This is a read-only property and any attempt to set this value will be ignored.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  nameServers?: string[];

  /**
   * The type of this DNS zone (Public or Private).
   */
  zoneType?: ZoneType = ZoneType.Public;

  /**
   * A list of references to virtual networks that register hostnames in this DNS zone. This is a only when ZoneType is Private.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  registrationVirtualNetworks?: SubResource[];

  /**
   * A list of references to virtual networks that resolve records in this DNS zone. This is a only when ZoneType is Private.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  resolutionVirtualNetworks?: SubResource[];

  /**
   * The list of signing keys.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  signingKeys?: SigningKey[];
}

/**
 * Common properties of an Azure Resource Manager resource
 */
model Resource {
  /**
   * Resource ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Resource location.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Describes a request to update a DNS zone.
 */
model ZoneUpdate {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Represents the properties of the Dns Resource Reference Request.
 */
model DnsResourceReferenceRequest {
  /**
   * The properties of the Resource Reference Request.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: DnsResourceReferenceRequestProperties;
}

/**
 * Represents the properties of the Dns Resource Reference Request.
 */
model DnsResourceReferenceRequestProperties {
  /**
   * A list of references to azure resources for which referencing dns records need to be queried.
   */
  targetResources?: SubResource[];
}

/**
 * Represents the properties of the Dns Resource Reference Result.
 */
model DnsResourceReferenceResult {
  /**
   * The result of dns resource reference request. Returns a list of dns resource references for each of the azure resource in the request.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: DnsResourceReferenceResultProperties;
}

/**
 * The result of dns resource reference request. Returns a list of dns resource references for each of the azure resource in the request.
 */
model DnsResourceReferenceResultProperties {
  /**
   * The result of dns resource reference request. A list of dns resource references for each of the azure resource in the request
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  dnsResourceReferences?: DnsResourceReference[];
}

/**
 * Represents a single Azure resource and its referencing DNS records.
 */
model DnsResourceReference {
  /**
   * A list of dns Records
   */
  dnsResources?: SubResource[];

  /**
   * A reference to an azure resource from where the dns resource value is taken.
   */
  targetResource?: SubResource;
}

/**
 * Parameters supplied to update a record set.
 */
model RecordSetUpdateParameters {
  /**
   * Specifies information about the record set being updated.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RecordSet?: RecordSet;
}
