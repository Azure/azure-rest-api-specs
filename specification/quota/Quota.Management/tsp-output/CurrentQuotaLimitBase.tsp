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

namespace Microsoft.Quota;
/**
 * Quota limit.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@extensionResource
@includeInapplicableMetadataInPayload(false)
model CurrentQuotaLimitBase {
  /**
   * Resource name for a given resource provider. For example:
   * - SKU name for Microsoft.Compute
   * - SKU or TotalLowPriorityCores for Microsoft.MachineLearningServices
   *  For Microsoft.Network PublicIPAddresses.
   */
  @path
  @key("resourceName")
  @segment("quotas")
  @visibility("read")
  name: string;

  /**
   * The resource ID.
   */
  @visibility("read")
  id?: string;

  /**
   * The resource type.
   */
  @visibility("read")
  type?: string;

  /**
   * Quota properties for the specified resource, based on the API called, Quotas or Usages.
   */
  @extension("x-ms-client-flatten", true)
  properties?: QuotaProperties;
}

@armResourceOperations
interface CurrentQuotaLimitBases {
  /**
   * Get the quota limit of a resource. The response can be used to determine the remaining quota to calculate a new quota limit that can be submitted with a PUT request.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Quota_Get")
  get is ArmResourceRead<CurrentQuotaLimitBase>;

  /**
   * Create or update the quota limit for the specified resource with the requested value. To update the quota, follow these steps:
   * 1. Use the GET operation for quotas and usages to determine how much quota remains for the specific resource and to calculate the new quota limit. These steps are detailed in [this example](https://techcommunity.microsoft.com/t5/azure-governance-and-management/using-the-new-quota-rest-api/ba-p/2183670).
   * 2. Use this PUT operation to update the quota limit. Please check the URI in location header for the detailed status of the request.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Quota_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<CurrentQuotaLimitBase>;

  /**
   * Update the quota limit for a specific resource to the specified value:
   * 1. Use the Usages-GET and Quota-GET operations to determine the remaining quota for the specific resource and to calculate the new quota limit. These steps are detailed in [this example](https://techcommunity.microsoft.com/t5/azure-governance-and-management/using-the-new-quota-rest-api/ba-p/2183670).
   * 2. Use this PUT operation to update the quota limit. Please check the URI in location header for the detailed status of the request.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Quota_Update")
  update is ArmCustomPatchAsync<CurrentQuotaLimitBase, CurrentQuotaLimitBase>;

  /**
   * Get a list of current quota limits of all resources for the specified scope. The response from this GET operation can be leveraged to submit requests to update a quota.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Quota_List")
  list is ArmResourceListByParent<CurrentQuotaLimitBase>;
}

@@projectedName(CurrentQuotaLimitBases.createOrUpdate::parameters.resource,
  "json",
  "createQuotaRequest"
);
@@extension(CurrentQuotaLimitBases.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "createQuotaRequest"
);
@@doc(CurrentQuotaLimitBases.createOrUpdate::parameters.resource,
  "Quota request payload."
);
@@projectedName(CurrentQuotaLimitBases.update::parameters.properties,
  "json",
  "createQuotaRequest"
);
@@extension(CurrentQuotaLimitBases.update::parameters.properties,
  "x-ms-client-name",
  "createQuotaRequest"
);
@@doc(CurrentQuotaLimitBases.update::parameters.properties,
  "Quota requests payload."
);
