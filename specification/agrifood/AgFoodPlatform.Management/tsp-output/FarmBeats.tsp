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
@doc("FarmBeats ARM Resource.")
model FarmBeats is TrackedResource<FarmBeatsProperties> {
  @doc("FarmBeats resource name.")
  @path
  @key("farmBeatsResourceName")
  @segment("farmBeats")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
@projectedName("client", "FarmBeats")
interface FarmBeatsOperationGroup {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get FarmBeats resource.")
  @operationId("FarmBeatsModels_Get")
  get is ArmResourceRead<FarmBeats>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update FarmBeats resource.")
  @operationId("FarmBeatsModels_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<FarmBeats>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update a FarmBeats resource.")
  @operationId("FarmBeatsModels_Update")
  update is ArmCustomPatchAsync<
    FarmBeats,
    FarmBeatsUpdateRequestModel,
    BaseParameters<FarmBeats>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a FarmBeats resource.")
  @operationId("FarmBeatsModels_Delete")
  delete is ArmResourceDeleteSync<FarmBeats>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists the FarmBeats instances for a resource group.")
  @operationId("FarmBeatsModels_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    FarmBeats,
    {
      ...BaseParameters<FarmBeats>;

      @doc("""
Maximum number of items needed (inclusive).
Minimum = 10, Maximum = 1000, Default value = 50.
""")
      @maxValue(1000)
      @minValue(10)
      @query("$maxPageSize")
      $maxPageSize?: int32 = 50;

      @doc("Continuation token for getting next set of results.")
      @query("$skipToken")
      $skipToken?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists the FarmBeats instances for a subscription.")
  @operationId("FarmBeatsModels_ListBySubscription")
  listBySubscription is ArmListBySubscription<FarmBeats>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FarmBeatsModels_GetOperationResult")
  @doc("Get operationResults for a FarmBeats resource.")
  // FIXME: FarmBeatsModels_GetOperationResult could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AgFoodPlatform/farmBeats/{farmBeatsResourceName}/operationResults/{operationResultsId}")
  @get
  getOperationResult is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("FarmBeats resource name.")
      @path
      farmBeatsResourceName: string;

      @doc("The operation results id.")
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
