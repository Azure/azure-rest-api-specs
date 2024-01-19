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
@doc("Quota bucket details object.")
@locationResource
model QuotaResource is ProxyResource<QuotaResourceProperties> {
  @doc("Quota Bucket name.")
  @path
  @key("quotaBucketName")
  @segment("quotas")
  name: string;
}

@armResourceOperations
interface QuotaResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the available quota for a quota bucket per region per subscription.")
  @operationId("Quotas_Get")
  get is ArmResourceRead<QuotaResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists all the available quota per region per subscription.")
  @operationId("Quotas_List")
  list is ArmResourceListByParent<QuotaResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Check Quota Availability on quota bucket per region per subscription.")
  @operationId("Quotas_CheckAvailability")
  checkAvailability is ArmResourceActionSync<
    QuotaResource,
    QuotaBucketRequest,
    CheckQuotaAvailabilityResponse
  >;
}

@@projectedName(QuotaResources.checkAvailability::parameters.body,
  "json",
  "QuotaBucketRequest"
);
@@extension(QuotaResources.checkAvailability::parameters.body,
  "x-ms-client-name",
  "QuotaBucketRequest"
);
@@doc(QuotaResources.checkAvailability::parameters.body,
  "Quota Bucket Request data"
);
