import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AgFoodPlatform;
/**
 * FarmBeats ARM Resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(FarmBeatsProperties)
model FarmBeats extends TrackedResourceBase {
  /**
   * FarmBeats resource name.
   */
  @path
  @key("farmBeatsResourceName")
  @segment("farmBeats")
  @visibility("read")
  name: string;

  /**
   * FarmBeats ARM Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: FarmBeatsProperties;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
@projectedName("client", "FarmBeats")
interface FarmBeatsOperationGroup {
  /**
   * Get FarmBeats resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FarmBeatsModels_Get")
  get is ArmResourceRead<FarmBeats>;

  /**
   * Create or update FarmBeats resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FarmBeatsModels_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<FarmBeats>;

  /**
   * Update a FarmBeats resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("FarmBeatsModels_Update")
  update is ArmCustomPatchAsync<
    FarmBeats,
    FarmBeatsUpdateRequestModel,
    BaseParameters<FarmBeats>,
    ArmLroLocationHeader
  >;

  /**
   * Delete a FarmBeats resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FarmBeatsModels_Delete")
  delete is ArmResourceDeleteSync<FarmBeats>;

  /**
   * Lists the FarmBeats instances for a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FarmBeatsModels_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    FarmBeats,
    {
      ...BaseParameters<FarmBeats>;

      /**
       * Maximum number of items needed (inclusive).
       * Minimum = 10, Maximum = 1000, Default value = 50.
       */
      @maxValue(1000)
      @minValue(10)
      @query("$maxPageSize")
      $maxPageSize?: int32 = 50;

      /**
       * Continuation token for getting next set of results.
       */
      @query("$skipToken")
      $skipToken?: string;
    }
  >;

  /**
   * Lists the FarmBeats instances for a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FarmBeatsModels_ListBySubscription")
  listBySubscription is ArmListBySubscription<FarmBeats>;

  /**
   * Get operationResults for a FarmBeats resource.
   */
  // FIXME: FarmBeatsModels_GetOperationResult could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FarmBeatsModels_GetOperationResult")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AgFoodPlatform/farmBeats/{farmBeatsResourceName}/operationResults/{operationResultsId}")
  @get
  getOperationResult is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * FarmBeats resource name.
       */
      @path
      farmBeatsResourceName: string;

      /**
       * The operation results id.
       */
      @pattern("^[A-Za-z0-9]+(-[A-Za-z0-9]+)*$")
      @path
      operationResultsId: string;
    },
    ArmAsyncOperation
  >;
}

@@projectedName(FarmBeatsOperationGroup.createOrUpdate::parameters.resource,
  "json",
  "body"
);
@@extension(FarmBeatsOperationGroup.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(FarmBeatsOperationGroup.createOrUpdate::parameters.resource,
  "FarmBeats resource create or update request object."
);
@@projectedName(FarmBeatsOperationGroup.update::parameters.properties,
  "json",
  "body"
);
@@extension(FarmBeatsOperationGroup.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(FarmBeatsOperationGroup.update::parameters.properties, "Request object.");
