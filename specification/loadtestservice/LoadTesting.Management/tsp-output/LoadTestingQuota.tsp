import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.LoadTesting;
@doc("Quota bucket details object.")
@locationResource
model LoadTestingQuota is ProxyResource<QuotaResourceProperties> {
  @doc("Quota Bucket name.")
  @path
  @key("quotaBucketName")
  @segment("quotas")
  name: string;
}

@armResourceOperations
interface LoadTestingQuotas {
  @doc("Get the available quota for a quota bucket per region per subscription.")
  get is ArmResourceRead<LoadTestingQuota>;
  @doc("Lists all the available quota per region per subscription.")
  list is ArmResourceListByParent<LoadTestingQuota>;
  @doc("Check Quota Availability on quota bucket per region per subscription.")
  checkAvailability is ArmResourceActionSync<
    LoadTestingQuota,
    QuotaBucketRequest,
    CheckQuotaAvailabilityResponse
  >;
}
