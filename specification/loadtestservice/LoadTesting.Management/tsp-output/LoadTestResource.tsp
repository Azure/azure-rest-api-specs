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

namespace Microsoft.LoadTestService;
@doc("LoadTest details")
model LoadTestResource is TrackedResource<LoadTestProperties> {
  @doc("Load Test name.")
  @path
  @key("loadTestName")
  @segment("loadTests")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface LoadTestResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a LoadTest resource.")
  @operationId("LoadTests_Get")
  get is ArmResourceRead<LoadTestResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update LoadTest resource.")
  @operationId("LoadTests_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    LoadTestResource,
    BaseParameters<LoadTestResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update a loadtest resource.")
  @operationId("LoadTests_Update")
  update is ArmCustomPatchAsync<
    LoadTestResource,
    LoadTestResourcePatchRequestBody,
    BaseParameters<LoadTestResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a LoadTest resource.")
  @operationId("LoadTests_Delete")
  delete is ArmResourceDeleteAsync<
    LoadTestResource,
    BaseParameters<LoadTestResource>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists loadtest resources in a resource group.")
  @operationId("LoadTests_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<LoadTestResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists loadtests resources in a subscription.")
  @operationId("LoadTests_ListBySubscription")
  listBySubscription is ArmListBySubscription<LoadTestResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("LoadTests_ListOutboundNetworkDependenciesEndpoints")
  @doc("Lists the endpoints that agents may call as part of load testing.")
  // FIXME: LoadTests_ListOutboundNetworkDependenciesEndpoints could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LoadTestService/loadTests/{loadTestName}/outboundNetworkDependenciesEndpoints")
  @get
  listOutboundNetworkDependenciesEndpoints is Azure.Core.Foundations.Operation<
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

      @doc("Load Test name.")
      @path
      loadTestName: string;
    },
    OutboundEnvironmentEndpointCollection
  >;
}

@@projectedName(LoadTestResources.createOrUpdate::parameters.resource,
  "json",
  "LoadTestResource"
);
@@extension(LoadTestResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "LoadTestResource"
);
@@doc(LoadTestResources.createOrUpdate::parameters.resource,
  "LoadTest resource data"
);
@@projectedName(LoadTestResources.update::parameters.properties,
  "json",
  "LoadTestResourcePatchRequestBody"
);
@@extension(LoadTestResources.update::parameters.properties,
  "x-ms-client-name",
  "LoadTestResourcePatchRequestBody"
);
@@doc(LoadTestResources.update::parameters.properties,
  "LoadTest resource update data"
);
