import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.LoadTestService;
@doc("Quota bucket details object.")
@locationResource
model QuotaResource is ProxyResource<QuotaResourceProperties> {
  @doc("Quota Bucket name.")
  @key("quotaBucketName")
  @segment("quotas")
  name: string;
}

@armResourceOperations
@projectedName("client", "Quotas")
interface QuotaResources_Quotas {
  @doc("Get the available quota for a quota bucket per region per subscription.")
  get is ArmResourceRead<QuotaResource>;

  @doc("Lists all the available quota per region per subscription.")
  list is ArmResourceListByParent<QuotaResource>;

  @doc("Check Quota Availability on quota bucket per region per subscription.")
  checkAvailability is ArmResourceActionSync<
    QuotaResource,
    QuotaBucketRequest,
    CheckQuotaAvailabilityResponse
  >;
}
