import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Capacity;
/**
 * Quota properties.
 */
@parentResource(LocationProxy)
model CurrentQuotaLimitBase
  is Azure.ResourceManager.ProxyResource<QuotaProperties> {
  ...ResourceNameParameter<
    Resource = CurrentQuotaLimitBase,
    KeyName = "resourceName",
    SegmentName = "serviceLimits",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" ""
@armResourceOperations(#{ omitTags: true })
interface CurrentQuotaLimitBases {
  /**
   * Get the current quota (service limit) and usage of a resource. You can use the response from the GET operation to submit quota update request.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Quota_Get")
  @tag("QuotaInformation")
  get is ArmResourceRead<
    CurrentQuotaLimitBase,
    Response = ArmResponse<CurrentQuotaLimitBase> & {
      /**
       * Current entity state version. It should be treated as opaque and used to make conditional HTTP requests.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" ""
      @header("ETag")
      ETag?: string;
    },
    Error = ExceptionResponse
  >;

  /**
   * Create or update the quota (service limits) of a resource to the requested value.
   *  Steps:
   *   1. Make the Get request to get the quota information for specific resource.
   *   2. To increase the quota, update the limit field in the response from Get request to new value.
   *   3. Submit the JSON to the quota request API to update the quota.
   *   The Create quota request may be constructed as follows. The PUT operation can be used to update the quota.
   */
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem" ""
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Quota_CreateOrUpdate")
  @tag("QuotaInformation")
  @Azure.Core.useFinalStateVia("original-uri")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    CurrentQuotaLimitBase,
    Response = ArmResourceUpdatedResponse<CurrentQuotaLimitBase> | ArmCreatedResponse<
      QuotaRequestSubmitResponse201,
      ExtraHeaders = ArmLroLocationHeader<FinalResult = CurrentQuotaLimitBase> &
        Azure.Core.Foundations.RetryAfterHeader
    >,
    Error = ExceptionResponse
  >;

  /**
   * Update the quota (service limits) of this resource to the requested value.
   *   • To get the quota information for specific resource, send a GET request.
   *   • To increase the quota, update the limit field from the GET response to a new value.
   *   • To update the quota value, submit the JSON response to the quota request API to update the quota.
   *   • To update the quota. use the PATCH operation.
   */
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem" ""
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Quota_Update")
  @tag("QuotaInformation")
  @patch(#{ implicitOptionality: false })
  @Azure.Core.useFinalStateVia("original-uri")
  update is ArmCustomPatchAsync<
    CurrentQuotaLimitBase,
    PatchModel = CurrentQuotaLimitBase,
    Response = ArmResponse<CurrentQuotaLimitBase> | ArmCreatedResponse<
      QuotaRequestSubmitResponse201,
      ExtraHeaders = ArmLroLocationHeader<FinalResult = CurrentQuotaLimitBase> &
        Azure.Core.Foundations.RetryAfterHeader
    >,
    Error = ExceptionResponse
  >;

  /**
   * Gets a list of current quotas (service limits) and usage for all resources. The response from the list quota operation can be leveraged to request quota updates.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Quota_List")
  @tag("QuotaInformation")
  list is ArmResourceListByParent<
    CurrentQuotaLimitBase,
    Response = ArmResponse<QuotaLimits> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" ""
      @header("ETag")
      ETag?: string;
    },
    Error = ExceptionResponse
  >;
}

@@doc(CurrentQuotaLimitBase.name,
  "The resource name for a resource provider, such as SKU name for Microsoft.Compute, Sku or TotalLowPriorityCores for Microsoft.MachineLearningServices"
);
@@doc(CurrentQuotaLimitBase.properties, "Quota properties for the resource.");
@@doc(CurrentQuotaLimitBases.createOrUpdate::parameters.resource,
  "Quota requests payload."
);
@@doc(CurrentQuotaLimitBases.update::parameters.properties,
  "Payload for the quota request."
);
