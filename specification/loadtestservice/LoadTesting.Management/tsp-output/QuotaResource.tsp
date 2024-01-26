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
/**
 * Quota bucket details object.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@locationResource
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(QuotaResourceProperties)
model QuotaResource extends ProxyResourceBase {
  /**
   * Quota Bucket name.
   */
  @path
  @key("quotaBucketName")
  @segment("quotas")
  @visibility("read")
  name: string;

  /**
   * Quota bucket resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: QuotaResourceProperties;
}

@armResourceOperations
interface QuotaResources {
  /**
   * Get the available quota for a quota bucket per region per subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Quotas_Get")
  get is ArmResourceRead<QuotaResource>;

  /**
   * Lists all the available quota per region per subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Quotas_List")
  list is ArmResourceListByParent<QuotaResource>;

  /**
   * Check Quota Availability on quota bucket per region per subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
