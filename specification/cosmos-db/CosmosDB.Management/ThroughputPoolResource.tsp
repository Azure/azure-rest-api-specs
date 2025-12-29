import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DocumentDB;
/**
 * An Azure Cosmos DB Throughputpool.
 */
model ThroughputPoolResource
  is Azure.ResourceManager.TrackedResource<ThroughputPoolProperties> {
  ...ResourceNameParameter<
    Resource = ThroughputPoolResource,
    KeyName = "throughputPoolName",
    SegmentName = "throughputPools",
    NamePattern = "^[a-z0-9]+(-[a-z0-9]+)*"
  >;
}

@armResourceOperations
interface ThroughputPoolResources {
  /**
   * Retrieves the properties of an existing Azure Cosmos DB Throughput Pool
   */
  get is ArmResourceRead<ThroughputPoolResource>;

  /**
   * Creates or updates an Azure Cosmos DB ThroughputPool account. The "Update" method is preferred when performing updates on an account.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ThroughputPoolResource>;

  /**
   * Updates the properties of an existing Azure Cosmos DB Throughput Pool.
   */
  @patch(#{ implicitOptionality: false })
  @Azure.Core.useFinalStateVia("azure-async-operation")
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    ThroughputPoolResource,
    PatchModel = ThroughputPoolUpdate,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ThroughputPoolResource> &
      Azure.Core.Foundations.RetryAfterHeader,
    OptionalRequestBody = true
  >;

  /**
   * Deletes an existing Azure Cosmos DB Throughput Pool.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    ThroughputPoolResource,
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders> | ArmDeletedNoContentResponse
  >;

  /**
   * List all the ThroughputPools in a given resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    ThroughputPoolResource,
    Response = ArmResponse<ThroughputPoolsListResult>
  >;

  /**
   * Lists all the Azure Cosmos DB Throughput Pools available under the subscription.
   */
  list is ArmListBySubscription<
    ThroughputPoolResource,
    Response = ArmResponse<ThroughputPoolsListResult>
  >;
}

@@maxLength(ThroughputPoolResource.name, 50);
@@minLength(ThroughputPoolResource.name, 3);
@@doc(ThroughputPoolResource.name, "Cosmos DB Throughput Pool name.");
@@doc(ThroughputPoolResource.properties,
  "Properties to update Azure Cosmos DB throughput pool."
);
@@doc(ThroughputPoolResources.createOrUpdate::parameters.resource,
  "The parameters to provide for the current ThroughputPool."
);
@@doc(ThroughputPoolResources.update::parameters.properties,
  "The parameters to provide for the current Throughput Pool."
);
