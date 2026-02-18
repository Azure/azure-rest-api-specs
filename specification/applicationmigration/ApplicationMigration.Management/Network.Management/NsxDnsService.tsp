import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApplicationMigration;

/**
 * A DNS service resource.
 */
@parentResource(NetworkSite)
model NsxDnsService
  is Azure.ResourceManager.ProxyResource<NsxDnsServiceProperties, false> {
  ...ResourceNameParameter<
    Resource = NsxDnsService,
    KeyName = "dnsServiceName",
    SegmentName = "dnsServices",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

/**
 * Properties of a DNS service.
 */
model NsxDnsServiceProperties is AzureResourceProperties {
  /** The listener IP address. */
  listenerIp?: string;

  /** ARM resource ID of the associated gateway. */
  gatewayRef?: Azure.Core.armResourceIdentifier;

  /** ARM resource IDs of the DNS forwarder zones. */
  zoneRefs?: Azure.Core.armResourceIdentifier[];

  /** Original NSX resource metadata. */
  nsxOriginal?: NsxOriginal;
}

@armResourceOperations
interface NsxDnsServices {
  /**
   * Gets the NsxDnsService resource.
   */
  get is ArmResourceRead<NsxDnsService>;

  /**
   * Creates or updates the NsxDnsService resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<NsxDnsService>;

  /**
   * Patches the NsxDnsService resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<NsxDnsService, NsxDnsServicePatchProperties>;

  /**
   * Deletes the NsxDnsService resource.
   */
  delete is ArmResourceDeleteSync<NsxDnsService>;

  /**
   * Lists NsxDnsService resources within a network site.
   */
  listByNetworkSite is ArmResourceListByParent<
    NsxDnsService,
    Response = ArmResponse<NsxDnsServiceList>
  >;
}

/**
 * A list of NsxDnsService resources.
 */
model NsxDnsServiceList is Azure.Core.Page<NsxDnsService>;

@@maxLength(NsxDnsService.name, 63);
@@minLength(NsxDnsService.name, 3);
@@doc(NsxDnsService.name, "The name of the DNS service.");
@@doc(NsxDnsService.properties, "Resource properties.");
@@doc(NsxDnsServices.createOrUpdate::parameters.resource,
  "The request body for creating or updating a NsxDnsService resource."
);
@@doc(NsxDnsServices.update::parameters.properties,
  "The request body for patching a NsxDnsService resource."
);
