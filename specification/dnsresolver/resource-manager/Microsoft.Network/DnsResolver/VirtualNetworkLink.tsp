import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DnsForwardingRuleset.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Describes a virtual network link.
 */
@parentResource(DnsForwardingRuleset)
model VirtualNetworkLink
  is Azure.ResourceManager.ProxyResource<VirtualNetworkLinkProperties, false> {
  ...ResourceNameParameter<
    Resource = VirtualNetworkLink,
    KeyName = "virtualNetworkLinkName",
    SegmentName = "virtualNetworkLinks",
    NamePattern = ""
  >;
  ...Legacy.EntityTagProperty;
}

@armResourceOperations
interface VirtualNetworkLinks {
  /**
   * Gets properties of a virtual network link to a DNS forwarding ruleset.
   */
  get is ArmResourceRead<VirtualNetworkLink, Error = CloudError>;

  /**
   * Creates or updates a virtual network link to a DNS forwarding ruleset.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    VirtualNetworkLink,
    Parameters = {
      /**
       * ETag of the resource. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting any concurrent changes.
       */
      @header
      ifMatch?: string;

      /**
       * Set to '*' to allow a new resource to be created, but to prevent updating an existing resource. Other values will be ignored.
       */
      @header
      ifNoneMatch?: string;
    },
    Response = ArmResourceUpdatedResponse<VirtualNetworkLink> | ArmResourceCreatedResponse<
      VirtualNetworkLink,
      ArmLroLocationHeader<FinalResult = VirtualNetworkLink> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse,
    Error = CloudError
  >;

  /**
   * Updates a virtual network link to a DNS forwarding ruleset.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    VirtualNetworkLink,
    PatchModel = VirtualNetworkLinkPatch,
    Parameters = {
      /**
       * ETag of the resource. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting any concurrent changes.
       */
      @header
      ifMatch?: string;
    },
    Error = CloudError
  >;

  /**
   * Deletes a virtual network link to a DNS forwarding ruleset. WARNING: This operation cannot be undone.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualNetworkLink,
    Parameters = {
      /**
       * ETag of the resource. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting any concurrent changes.
       */
      @header
      ifMatch?: string;
    },
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists virtual network links to a DNS forwarding ruleset.
   */
  list is ArmResourceListByParent<
    VirtualNetworkLink,
    Parameters = {
      /**
       * The maximum number of results to return. If not specified, returns up to 100 results.
       */
      @query("$top")
      $top?: int32;
    },
    Error = CloudError
  >;
}

@@doc(VirtualNetworkLink.name, "The name of the virtual network link.");
@@doc(VirtualNetworkLink.properties, "Properties of the virtual network link.");
@@doc(VirtualNetworkLinks.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateOrUpdate operation."
);
@@doc(VirtualNetworkLinks.update::parameters.properties,
  "Parameters supplied to the Update operation."
);
