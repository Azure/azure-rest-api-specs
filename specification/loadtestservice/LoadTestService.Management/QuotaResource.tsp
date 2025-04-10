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
 * Quota bucket details object.
 */
@subscriptionResource
@parentResource(SubscriptionLocationResource)
model QuotaResource
  is Azure.ResourceManager.ProxyResource<QuotaResourceProperties> {
  ...ResourceNameParameter<
    Resource = QuotaResource,
    KeyName = "quotaBucketName",
    SegmentName = "quotas",
    NamePattern = ""
  >;
}

@armResourceOperations
interface QuotaResources {
  /**
   * Get the available quota for a quota bucket per region per subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Quotas_Get")
  get is ArmResourceRead<
    QuotaResource,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * List quotas for a given subscription Id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Quotas_List")
  list is ArmResourceListByParent<
    QuotaResource,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Check Quota Availability on quota bucket per region per subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Quotas_CheckAvailability")
  checkAvailability is ArmResourceActionSync<
    QuotaResource,
    QuotaBucketRequest,
    ArmResponse<CheckQuotaAvailabilityResponse>,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
}

@@doc(QuotaResource.name, "The quota name.");
@@doc(QuotaResource.properties,
  "The resource-specific properties for this resource."
);
