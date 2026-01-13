import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;
using Microsoft.LoadTestService;
using Azure.ResourceManager;

@useDependency(Microsoft.LoadTestService.APIVersions.v2022_12_01)
namespace Customizations;

@@clientName(LoadTests.updateLoadtest::parameters.properties,
  "LoadTestResourcePatchRequestBody"
);
@@clientName(Quotas.checkAvailability::parameters.body, "QuotaBucketRequest");
@@clientName(LoadTests.createOrUpdateLoadtest::parameters.resource,
  "LoadTestResource"
);

@client({
  name: "LoadTestMgmtClient",
  service: Microsoft.LoadTestService,
})
@armResourceOperations
interface LoadTests {
  listBySubscription is Microsoft.LoadTestService.LoadTests.listBySubscription;

  listByResourceGroup is Microsoft.LoadTestService.LoadTests.listByResourceGroup;

  getLoadtest is Microsoft.LoadTestService.LoadTests.get;

  createOrUpdateLoadtest is Microsoft.LoadTestService.LoadTests.createOrUpdate;

  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "Existing API"
  updateLoadtest is Microsoft.LoadTestService.LoadTests.update;

  deleteLoadtest is Microsoft.LoadTestService.LoadTests.delete;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" ""
  outboundNetworkDependenciesEndpoints is Microsoft.LoadTestService.LoadTests.outboundNetworkDependenciesEndpoints;

  getQuota is Microsoft.LoadTestService.Quotas.get;

  listQuota is Microsoft.LoadTestService.Quotas.list;

  checkAvailabilityQuota is Microsoft.LoadTestService.Quotas.checkAvailability;
}

@@clientName(type, "LoadTestingCmkIdentityType", "csharp");
@@clientName(LoadTestResource, "LoadTestingResource", "csharp");
@@clientName(QuotaResource, "LoadTestingQuota", "csharp");
@@clientName(EncryptionProperties, "LoadTestingCmkEncryptionProperties", "csharp");
@@clientName(EncryptionPropertiesIdentity, "LoadTestingCmkIdentity", "csharp");
@@clientName(EndpointDependency, "LoadTestingEndpointDependency", "csharp");
@@clientName(EndpointDetail, "LoadTestingEndpointDetail", "csharp");
@@clientName(CheckQuotaAvailabilityResponse, "LoadTestingQuotaAvailabilityResult", "csharp");
@@clientName(QuotaBucketRequest, "LoadTestingQuotaBucketContent", "csharp");
@@clientName(QuotaBucketRequestPropertiesDimensions, "LoadTestingQuotaBucketDimensions", "csharp");
@@clientName(ResourceState, "LoadTestingProvisioningState", "csharp");
@@clientName(QuotaBucketRequestPropertiesDimensions, "LoadTestingQuotaBucketDimensions", "csharp");
@@clientName(OutboundEnvironmentEndpoint, "LoadTestingOutboundEnvironmentEndpoint", "csharp");

@@clientName(LoadTests.checkAvailabilityQuota, "CheckLoadTestingQuotaAvailability", "csharp");
@@clientName(LoadTests.outboundNetworkDependenciesEndpoints,
  "GetOutboundNetworkDependenciesEndpoints",
  "csharp"
);