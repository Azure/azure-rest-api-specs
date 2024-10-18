import "./models.tsp";
import "./customOperation.tsp";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.LoadTestService;

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "deprecated" "LEGACY - DO NOT COPY - FIX"
@@encodedName(LoadTests.createOrUpdate::parameters.resource,
  "application/json",
  "LoadTestResource"
);

#suppress "deprecated" "LEGACY - DO NOT COPY - FIX"
@@encodedName(LoadTests.update::parameters.properties,
  "application/json",
  "LoadTestResourcePatchRequestBody"
);
#suppress "deprecated" "LEGACY - DO NOT COPY - FIX"
@@encodedName(Quotas.checkAvailability::parameters.body,
  "application/json",
  "QuotaBucketRequest"
);

@armResourceOperations
interface LoadTests {
  listBySubscription is ArmListBySubscription<LoadTestResource>;

  listByResourceGroup is ArmResourceListByParent<LoadTestResource>;
  get is ArmResourceRead<LoadTestResource>;

  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    LoadTestResource,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "Existing API"
  update is ArmCustomPatchAsync<
    LoadTestResource,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      LoadTestResource,
      LoadTestProperties
    >,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  delete is ArmResourceDeleteWithoutOkAsync<LoadTestResource>;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "OperationID already published."
  @operationId("LoadTests_ListOutboundNetworkDependenciesEndpoints")
  @doc("Lists the endpoints that agents may call as part of load testing.")
  outboundNetworkDependenciesEndpoints is CustomOperations.ArmResourceActionSyncCustomGet<
    LoadTestResource,
    void,
    PagedOutboundEnvironmentEndpoint
  >;
}

@armResourceOperations
interface Quotas {
  @doc("Get the available quota for a quota bucket per region per subscription.")
  get is ArmResourceRead<QuotaResource>;

  @doc("List quotas for a given subscription Id.")
  list is ArmListBySubscription<QuotaResource>;

  @doc("Check Quota Availability on quota bucket per region per subscription.")
  checkAvailability is ArmResourceActionSync<
    QuotaResource,
    QuotaBucketRequest,
    CheckQuotaAvailabilityResponse
  >;
}

@armResourceOperations
interface LoadTestMappings {
  @added(APIVersions.v2023_12_01_preview)
  createOrUpdate is ArmResourceCreateOrReplaceSync<LoadTestMappingResource>;

  @added(APIVersions.v2023_12_01_preview)
  get is ArmResourceRead<LoadTestMappingResource>;

  @added(APIVersions.v2023_12_01_preview)
  delete is ArmResourceDeleteSync<LoadTestMappingResource>;

  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "Existing API"
  @added(APIVersions.v2023_12_01_preview)
  update is ArmCustomPatchSync<
    LoadTestMappingResource,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      LoadTestMappingResource,
      LoadTestMappingProperties
    >
  >;

  @added(APIVersions.v2023_12_01_preview)
  list is ArmResourceListByParent<LoadTestMappingResource>;
}

@armResourceOperations
interface LoadTestProfileMappings {
  @added(APIVersions.v2023_12_01_preview)
  createOrUpdate is ArmResourceCreateOrReplaceSync<LoadTestProfileMappingResource>;

  @added(APIVersions.v2023_12_01_preview)
  get is ArmResourceRead<LoadTestProfileMappingResource>;

  @added(APIVersions.v2023_12_01_preview)
  delete is ArmResourceDeleteSync<LoadTestProfileMappingResource>;

  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "Existing API"
  @added(APIVersions.v2023_12_01_preview)
  update is ArmCustomPatchSync<
    LoadTestProfileMappingResource,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      LoadTestProfileMappingResource,
      LoadTestProfileMappingProperties
    >
  >;

  @added(APIVersions.v2023_12_01_preview)
  list is ArmResourceListByParent<LoadTestProfileMappingResource>;
}
