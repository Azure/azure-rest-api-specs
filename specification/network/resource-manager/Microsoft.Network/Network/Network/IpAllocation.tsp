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
 * IpAllocation resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Http.Private.includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model IpAllocation extends Resource {
  properties?: IpAllocationPropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("ipAllocationName")
  @segment("IpAllocations")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@armResourceOperations
interface IpAllocations {
  /**
   * Gets the specified IpAllocation by resource group.
   */
  get is ArmResourceRead<
    IpAllocation,
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
   * Creates or updates an IpAllocation in the specified resource group.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    IpAllocation,
    Error = CloudError
  >;

  /**
   * Updates a IpAllocation tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    IpAllocation,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes the specified IpAllocation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    IpAllocation,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all IpAllocations in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    IpAllocation,
    Error = CloudError
  >;

  /**
   * Gets all IpAllocations in a subscription.
   */
  list is ArmListBySubscription<IpAllocation, Error = CloudError>;
}

@@doc(IpAllocation.name, "The name of the IpAllocation.");
@@doc(IpAllocation.properties, "Properties of the IpAllocation.");
@@doc(IpAllocations.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update virtual network operation."
);
@@doc(IpAllocations.updateTags::parameters.properties,
  "Parameters supplied to update IpAllocation tags."
);
