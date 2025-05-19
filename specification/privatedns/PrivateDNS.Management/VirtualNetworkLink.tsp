import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateZone.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Describes a link to virtual network for a Private DNS zone.
 */
@parentResource(PrivateZone)
model VirtualNetworkLink
  is Azure.ResourceManager.TrackedResource<VirtualNetworkLinkProperties> {
  ...ResourceNameParameter<
    Resource = VirtualNetworkLink,
    KeyName = "virtualNetworkLinkName",
    SegmentName = "virtualNetworkLinks",
    NamePattern = ""
  >;

  /**
   * The ETag of the virtual network link.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

@armResourceOperations
interface VirtualNetworkLinks {
  /**
   * Gets a virtual network link to the specified Private DNS zone.
   */
  get is ArmResourceRead<VirtualNetworkLink>;

  /**
   * Creates or updates a virtual network link to the specified Private DNS zone.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    VirtualNetworkLink,
    Parameters = {
      /**
       * The ETag of the virtual network link to the Private DNS zone. Omit this value to always overwrite the current virtual network link. Specify the last-seen ETag value to prevent accidentally overwriting any concurrent changes.
       */
      @header
      IfMatch?: string;

      /**
       * Set to '*' to allow a new virtual network link to the Private DNS zone to be created, but to prevent updating an existing link. Other values will be ignored.
       */
      @header
      IfNoneMatch?: string;
    },
    Response = ArmResourceUpdatedResponse<VirtualNetworkLink> | ArmResourceCreatedResponse<
      VirtualNetworkLink,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Updates a virtual network link to the specified Private DNS zone.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    VirtualNetworkLink,
    PatchModel = VirtualNetworkLink,
    Parameters = {
      /**
       * The ETag of the virtual network link to the Private DNS zone. Omit this value to always overwrite the current virtual network link. Specify the last-seen ETag value to prevent accidentally overwriting any concurrent changes.
       */
      @header
      IfMatch?: string;
    }
  >;

  /**
   * Deletes a virtual network link to the specified Private DNS zone. WARNING: In case of a registration virtual network, all auto-registered DNS records in the zone for the virtual network will also be deleted. This operation cannot be undone.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualNetworkLink,
    Parameters = {
      /**
       * The ETag of the virtual network link to the Private DNS zone. Omit this value to always delete the current zone. Specify the last-seen ETag value to prevent accidentally deleting any concurrent changes.
       */
      @header
      IfMatch?: string;
    },
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists the virtual network links to the specified Private DNS zone.
   */
  list is ArmResourceListByParent<
    VirtualNetworkLink,
    Parameters = {
      /**
       * The maximum number of virtual network links to return. If not specified, returns up to 100 virtual network links.
       */
      @query("$top")
      $top?: int32;
    }
  >;
}

@@doc(VirtualNetworkLink.name, "The name of the virtual network link.");
@@doc(VirtualNetworkLink.properties,
  "Properties of the virtual network link to the Private DNS zone."
);
@@doc(VirtualNetworkLinks.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateOrUpdate operation."
);
@@doc(VirtualNetworkLinks.update::parameters.properties,
  "Parameters supplied to the Update operation."
);
