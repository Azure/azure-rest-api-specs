import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.SaaS;

@armResourceOperations
interface SaasSubscriptionLevel {
  get is ArmResourceRead<SaasResource>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SaasResource>;
  update is ArmCustomPatchAsync<
    SaasResource,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      SaasResource,
      SaasResourceProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<SaasResource>;
  listByResourceGroup is ArmResourceListByParent<SaasResource>;
  listAccessToken is ArmResourceActionSync<
    SaasResource,
    void,
    AccessTokenResult
  >;
  unsubscribe is ArmResourceActionAsync<
    SaasResource,
    DeleteOptions,
    SaasResource
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Custom preflight route not tied to SaasResource"
interface SaasSubscriptionLevelPreflight {
  /** Pre-validates SaaS subscription operations. */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Preflight accepts dynamic payload"
  @post
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SaaS/deployments/{saasSubscriptionName}/preflight")
  preflight(
    ...ApiVersionParameter,

    /** The Azure subscription ID. */
    @path subscriptionId: string,

    /** The resource group name. */
    @path resourceGroupName: string,

    /** The SaaS subscription name. */
    @pattern("^[a-zA-Z0-9-]{3,50}$")
    @path
    saasSubscriptionName: string,

    /** The preflight request body. */
    @body body: unknown,
  ): OkResponse | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Global operations not scoped to a single resource"
interface SaasSubscriptionLevelGlobal {
  listByAzureSubscription is ArmListBySubscription<SaasResource>;
  checkNameAvailability is checkGlobalNameAvailability<
    SaasNameAvailabilityRequest,
    SaasNameAvailabilityResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Move operations are not resource-scoped"
interface SaasSubscriptionLevelMove {
  /** Validates a request to move SaaS resources between resource groups. */
  @post
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/validateMoveResources")
  validateMoveResources(
    ...ApiVersionParameter,

    /** The Azure subscription ID. */
    @path subscriptionId: string,

    /** The resource group name. */
    @path resourceGroupName: string,

    /** The move resource parameters. */
    @body moveResourceParameter: MoveResource,
  ): ArmNoContentResponse<"Operation completed successfully."> | ErrorResponse;

  /** Moves SaaS resources between resource groups. */
  @post
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/moveResources")
  moveResources(
    ...ApiVersionParameter,

    /** The Azure subscription ID. */
    @path subscriptionId: string,

    /** The resource group name. */
    @path resourceGroupName: string,

    /** The move resource parameters. */
    @body moveResourceParameter: MoveResource,
  ): ArmNoContentResponse<"Operation completed successfully."> | ErrorResponse;
}
