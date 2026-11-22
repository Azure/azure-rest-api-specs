import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.SaaS;

/** Tenant-level SaaS proxy resource for GA API version 2026-04-01. */
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

/** The type used for update operations of the SaasTenantResource. */
model SaasTenantResourceUpdate is Azure.ResourceManager.Foundations.ResourceUpdateModel<
  SaasTenantResource,
  SaasResourceProperties
>;

@armResourceOperations
interface SaasTenantLevel {
  /** Gets a tenant-level SaaS resource by its identifier. */
  getResource is ArmResourceRead<
    SaasTenantResource,
    Parameters = ExpandCustomerDataQueryParameter
  >;

  /** Updates mutable properties or tags on an existing tenant-level SaaS resource. */
  updateResource is ArmCustomPatchAsync<
    SaasTenantResource,
    SaasTenantResourceUpdate
  >;

  /** Deletes a tenant-level SaaS resource. */
  deleteResource is ArmResourceDeleteWithoutOkAsync<SaasTenantResource>;

  /** Lists all tenant-level SaaS resources accessible to the caller. */
  list is ArmResourceListByParent<SaasTenantResource>;

  /** Generates a publisher access token for a tenant-level SaaS resource. */
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
