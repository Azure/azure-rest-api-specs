import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.LoadTestService;
/**
 * LoadTest details.
 */
model LoadTestResource
  is Azure.ResourceManager.TrackedResource<LoadTestProperties> {
  ...ResourceNameParameter<
    Resource = LoadTestResource,
    KeyName = "loadTestName",
    SegmentName = "loadTests",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@armResourceOperations
interface LoadTestResources {
  /**
   * Get a LoadTestResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LoadTests_Get")
  get is ArmResourceRead<LoadTestResource>;

  /**
   * Create a LoadTestResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LoadTests_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<LoadTestResource>;

  /**
   * Update a LoadTestResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("LoadTests_Update")
  update is ArmCustomPatchAsync<
    LoadTestResource,
    PatchModel = LoadTestResourceUpdate
  >;

  /**
   * Delete a LoadTestResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LoadTests_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<LoadTestResource>;

  /**
   * List LoadTestResource resources by resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LoadTests_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<LoadTestResource>;

  /**
   * List LoadTestResource resources by subscription ID
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LoadTests_ListBySubscription")
  listBySubscription is ArmListBySubscription<LoadTestResource>;

  /**
   * Lists the endpoints that agents may call as part of load testing.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("outboundNetworkDependenciesEndpoints")
  @operationId("LoadTests_ListOutboundNetworkDependenciesEndpoints")
  listOutboundNetworkDependenciesEndpoints is ArmResourceActionSync<
    LoadTestResource,
    void,
    ArmResponse<PagedOutboundEnvironmentEndpoint>
  >;
}

@@doc(LoadTestResource.name, "Load Test name");
@@doc(LoadTestResource.properties,
  "The resource-specific properties for this resource."
);
