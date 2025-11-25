import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Public IP prefix resource.
 */
model PublicIPPrefix
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<PublicIPPrefixPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = PublicIPPrefix,
    KeyName = "publicIpPrefixName",
    SegmentName = "publicIPPrefixes",
    NamePattern = ""
  >;

  /**
   * The extended location of the public ip address.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  extendedLocation?: ExtendedLocation;

  /**
   * The public IP prefix SKU.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: PublicIPPrefixSku;

  ...Azure.ResourceManager.Legacy.EntityTagProperty;
  ...Azure.ResourceManager.AvailabilityZonesProperty;
}

@armResourceOperations
interface PublicIPPrefixes {
  /**
   * Gets the specified public IP prefix in a specified resource group.
   */
  get is ArmResourceRead<PublicIPPrefix,
    Parameters = {
      /**
       * Expands referenced resources.
       */
      @query("$expand")
      $expand?: string;
    }, Error = CloudError>;

  /**
   * Creates or updates a static or dynamic public IP prefix.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PublicIPPrefix,
    LroHeaders = ArmLroLocationHeader<FinalResult = PublicIPPrefix> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates public IP prefix tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<PublicIPPrefix, PatchModel = TagsObject, Error = CloudError>;

  /**
   * Deletes the specified public IP prefix.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<PublicIPPrefix,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,  Error = CloudError>;

  /**
   * Gets all public IP prefixes in a resource group.
   */
  list is ArmResourceListByParent<PublicIPPrefix, Error = CloudError>;

  /**
   * Gets all the public IP prefixes in a subscription.
   */
  listAll is ArmListBySubscription<PublicIPPrefix, Error = CloudError>;
}

@@doc(PublicIPPrefix.name, "The name of the public IP prefix.");
@@doc(PublicIPPrefix.properties, "Public IP prefix properties.");
@@doc(PublicIPPrefixes.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update public IP prefix operation."
);
@@doc(PublicIPPrefixes.updateTags::parameters.properties,
  "Parameters supplied to update public IP prefix tags."
);
