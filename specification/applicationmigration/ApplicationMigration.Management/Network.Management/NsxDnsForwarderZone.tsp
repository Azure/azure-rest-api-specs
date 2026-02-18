import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NsxDnsService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApplicationMigration;

/**
 * A DNS forwarder zone resource (child of NsxDnsService).
 */
@parentResource(NsxDnsService)
model NsxDnsForwarderZone
  is Azure.ResourceManager.ProxyResource<NsxDnsForwarderZoneProperties, false> {
  ...ResourceNameParameter<
    Resource = NsxDnsForwarderZone,
    KeyName = "zoneName",
    SegmentName = "dnsForwarderZones",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

/**
 * Properties of a DNS forwarder zone.
 */
model NsxDnsForwarderZoneProperties is AzureResourceProperties {
  /** The zone type. */
  zoneType?: DnsZoneType;

  /** The domain names served by this zone. */
  domainNames?: string[];

  /** The upstream DNS servers. */
  @identifiers(#[])
  upstreamServers?: UpstreamServer[];

  /** Source IP addresses for forwarding. */
  sourceIps?: string[];

  /** Original NSX resource metadata. */
  nsxOriginal?: NsxOriginal;
}

@armResourceOperations
interface NsxDnsForwarderZones {
  /**
   * Gets the NsxDnsForwarderZone resource.
   */
  get is ArmResourceRead<NsxDnsForwarderZone>;

  /**
   * Creates or updates the NsxDnsForwarderZone resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<NsxDnsForwarderZone>;

  /**
   * Patches the NsxDnsForwarderZone resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    NsxDnsForwarderZone,
    NsxDnsForwarderZonePatchProperties
  >;

  /**
   * Deletes the NsxDnsForwarderZone resource.
   */
  delete is ArmResourceDeleteSync<NsxDnsForwarderZone>;

  /**
   * Lists NsxDnsForwarderZone resources within a DNS service.
   */
  listByNsxDnsService is ArmResourceListByParent<
    NsxDnsForwarderZone,
    Response = ArmResponse<NsxDnsForwarderZoneList>
  >;
}

model NsxDnsForwarderZoneList is Azure.Core.Page<NsxDnsForwarderZone>;

@@maxLength(NsxDnsForwarderZone.name, 63);
@@minLength(NsxDnsForwarderZone.name, 3);
@@doc(NsxDnsForwarderZone.name, "The name of the DNS forwarder zone.");
