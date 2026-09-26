import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.SaaS;

@tenantResource
model SaasTenantResource is ProxyResource<SaasResourceProperties> {
  ...ResourceNameParameter<
    Resource = SaasTenantResource,
    KeyName = "resourceId",
    SegmentName = "saasresources",
    NamePattern = "^[a-zA-Z0-9-]{3,50}$"
  >;
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
}

@armResourceOperations
interface SaasTenantLevel {
  createResource is ArmResourceCreateOrReplaceAsync<SaasTenantResource>;
  getResource is ArmResourceRead<
    SaasTenantResource,
    Parameters = ExpandCustomerDataQueryParameter
  >;
  updateResource is ArmCustomPatchAsync<
    SaasTenantResource,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      SaasTenantResource,
      SaasResourceProperties
    >
  >;
  deleteResource is ArmResourceDeleteWithoutOkAsync<SaasTenantResource>;
  list is ArmResourceListByParent<SaasTenantResource>;
  listAccessToken is ArmResourceActionSync<
    SaasTenantResource,
    void,
    AccessTokenResult
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Custom operation status routes"
interface SaasOperationStatuses {
  /** Gets the status of a long-running SaaS operation at the tenant scope. */
  @get
  @route("/providers/Microsoft.SaaS/operationStatuses/{operationId}")
  getTenantOperationStatus(
    ...ApiVersionParameter,
    ...Azure.ResourceManager.CommonTypes.OperationIdParameter,
  ):
    | ArmResponse<Azure.ResourceManager.CommonTypes.OperationStatusResult>
    | ErrorResponse;

  /** Gets the status of a long-running SaaS operation at the subscription scope. */
  @get
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.SaaS/operationStatuses/{operationId}")
  getSubscriptionOperationStatus(
    ...ApiVersionParameter,
    ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,
    ...Azure.ResourceManager.CommonTypes.OperationIdParameter,
  ):
    | ArmResponse<Azure.ResourceManager.CommonTypes.OperationStatusResult>
    | ErrorResponse;
}
