import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.OpenAPI;
using Azure.Core;
using Azure.ResourceManager;

namespace ServiceEntitlementsApi;

/** A Microsoft Defender for Cloud service entitlement. */
model ServiceEntitlement is TrackedResource<ServiceEntitlementProperties> {
  ...ResourceNameParameter<
    Resource = ServiceEntitlement,
    KeyName = "serviceEntitlementName",
    SegmentName = "serviceEntitlements",
    NamePattern = "^[a-z0-9]{3,24}$"
  >;
}

@armResourceOperations(#{ allowStaticRoutes: true })
interface ServiceEntitlements {
  /** Gets a service entitlement. */
  get is ArmResourceRead<ServiceEntitlement>;

  /** Creates or replaces a service entitlement. */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ServiceEntitlement>;

  /** Updates a service entitlement. */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ServiceEntitlement,
    ServiceEntitlementUpdate,
    LroHeaders = ArmCombinedLroHeaders<
      ArmOperationStatus,
      ServiceEntitlement
    > & Azure.Core.Foundations.RetryAfterHeader
  >;

  /** Deletes a service entitlement. */
  delete is ArmResourceDeleteWithoutOkAsync<
    ServiceEntitlement,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  /** Lists service entitlements in a resource group. */
  listByResourceGroup is ArmResourceListByParent<ServiceEntitlement>;

  /** Lists service entitlements in a subscription. */
  listBySubscription is ArmListBySubscription<ServiceEntitlement>;

  /** Lists service entitlements in the tenant. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "x-ms-pageable is required for this manually-routed tenant list operation; a standard ArmResourceList template is not used here."
  @route("/providers/Microsoft.Security/serviceEntitlements")
  @get
  @armResourceList(ServiceEntitlement)
  @extension("x-ms-pageable", #{ nextLinkName: "nextLink" })
  listByTenant(...ApiVersionParameter):
    | ArmResponse<ResourceListResult<ServiceEntitlement>>
    | ErrorResponse;

  /** Gets the result of a long-running operation performed on a service entitlement. */
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Security/serviceEntitlements/{serviceEntitlementName}/operationResults/{operationId}")
  getOperationResult(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /** The name of the service entitlement. */
    @path
    @pattern("^[a-z0-9]{3,24}$")
    serviceEntitlementName: string,

    ...Azure.ResourceManager.CommonTypes.OperationIdParameter,
  ): ArmResponse<Azure.ResourceManager.CommonTypes.OperationStatusResult> | ErrorResponse;
}
