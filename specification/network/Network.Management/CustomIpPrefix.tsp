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
 * Custom IP prefix resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Http.Private.includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model CustomIpPrefix extends Resource {
  properties?: CustomIpPrefixPropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("customIpPrefixName")
  @segment("customIpPrefixes")
  name: string;

  /**
   * The extended location of the custom IP prefix.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extendedLocation?: ExtendedLocation;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  /** A list of availability zones denoting where the resource needs to come from. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  zones?: string[];
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@armResourceOperations
interface CustomIpPrefixes {
  /**
   * Gets the specified custom IP prefix in a specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("CustomIPPrefixes_Get")
  get is ArmResourceRead<
    CustomIpPrefix,
    Parameters = {
      /**
       * Expands referenced resources.
       */
      @query("$expand")
      $expand?: string;
    },
    Error = CloudError
  >;

  /**
   * Creates or updates a custom IP prefix.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("CustomIPPrefixes_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    CustomIpPrefix,
    LroHeaders = ArmLroLocationHeader<FinalResult = CustomIpPrefix> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;

  /**
   * Updates custom IP prefix tags.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("CustomIPPrefixes_UpdateTags")
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    CustomIpPrefix,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes the specified custom IP prefix.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("CustomIPPrefixes_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    CustomIpPrefix,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all custom IP prefixes in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("CustomIPPrefixes_List")
  list is ArmResourceListByParent<CustomIpPrefix, Error = CloudError>;

  /**
   * Gets all the custom IP prefixes in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("CustomIPPrefixes_ListAll")
  listAll is ArmListBySubscription<CustomIpPrefix, Error = CloudError>;
}

@@doc(CustomIpPrefix.name, "The name of the custom IP prefix.");
@@doc(CustomIpPrefix.properties, "Custom IP prefix properties.");
@@doc(CustomIpPrefixes.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update custom IP prefix operation."
);
@@doc(CustomIpPrefixes.updateTags::parameters.properties,
  "Parameters supplied to update custom IP prefix tags."
);
