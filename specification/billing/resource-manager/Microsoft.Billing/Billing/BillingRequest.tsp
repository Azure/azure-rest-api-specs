import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using Azure.ResourceManager;

namespace Microsoft.Billing;
/**
 * A request submitted by a user to manage billing. Users with an owner role on the scope can approve or decline these requests.
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Existing API model contract. Back compat. Furthermore, Request is the ARM resource."
@tenantResource
model BillingRequest
  is Azure.ResourceManager.ProxyResource<BillingRequestProperties> {
  ...ResourceNameParameter<
    Resource = BillingRequest,
    KeyName = "billingRequestName",
    SegmentName = "billingRequests",
    NamePattern = GuidPattern
  >;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  tags?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Billing requests do not get deleted. They still exist but expire over time."
@armResourceOperations(#{ omitTags: true })
interface BillingRequests {
  /**
   * Gets a billing request by its ID.
   */
  @tag("BillingRequest")
  get is ArmResourceRead<
    BillingRequest,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Create or update a billing request.
   */
  @tag("BillingRequest")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    BillingRequest,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    LroHeaders = ArmLroLocationHeader<FinalResult = BillingRequest> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The list of billing requests submitted by a user.
   */
  @tag("BillingRequest")
  listByUser is ArmResourceListByParent<
    BillingRequest,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = {
      ...DefaultODataParameters;
    },
    Response = ArmResponse<BillingRequestListResult>
  >;
}

@@doc(
  BillingRequest.name,
  "The ID that uniquely identifies a billing request."
);
@@doc(
  BillingRequest.properties,
  "A request submitted by a user to manage billing. Users with an owner role on the scope can approve or decline these requests."
);
@@doc(
  BillingRequests.createOrUpdate::parameters.resource,
  "A request submitted by a user to manage billing. Users with an owner role on the scope can approve or decline these requests."
);
