import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Common;

namespace Microsoft.Network;
/**
 * ExpressRouteLag Authorization resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "The includeInapplicableMetadataInPayload decorator is currently under Http.Private and is required to keep payload shape aligned with existing Network RP swagger output."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "This child resource explicitly defines the name/etag envelope fields to preserve the existing Network RP contract and generated OpenAPI shape for ExpressRoute LAG authorizations."
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "This child resource extends the shared SubResourceModel envelope used across Network RP to maintain consistency with existing model composition."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "The Network RP TypeSpec project currently uses Azure.ResourceManager.Legacy feature toggles and operation templates across this API surface; this file must remain consistent with that project pattern."
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
@summary("ExpressRoute Lag Authorization")
@Http.Private.includeInapplicableMetadataInPayload(false)
@added(Versions.v2026_03_01)
model ExpressRouteLagAuthorization extends SubResourceModel {
  /** ExpressRouteLag authorization properties. */
  properties?: ExpressRouteLagAuthorizationPropertiesFormat;

  /**
   * The name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("authorizationName")
  @segment("authorizations")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "etag is intentionally modeled as a read-only envelope field to match existing ExpressRoute resource contracts in Network RP."
  @visibility(Lifecycle.Read)
  etag?: string;
}

alias ExpressRouteLagAuthorizationOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the express route LAG. */
    @path
    @segment("expressRouteLags")
    @key
    expressRouteLagName: string;
  },
  {
    /** The name of the authorization. */
    @path
    @segment("authorizations")
    @key
    authorizationName: string;
  }
>;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "The containing service namespace still relies on Azure.ResourceManager.Legacy feature flags and templates; this interface follows the same established project-level pattern."
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
@armResourceOperations
@added(Versions.v2026_03_01)
interface ExpressRouteLagAuthorizations {
  /**
   * Gets the specified authorization from the specified express route LAG.
   */
  get is ExpressRouteLagAuthorizationOps.Read<
    ExpressRouteLagAuthorization,
    OverrideErrorType = CloudError
  >;

  /**
   * Creates or updates an authorization in the specified express route LAG.
   */
  createOrUpdate is ExpressRouteLagAuthorizationOps.CreateOrUpdateAsync<
    ExpressRouteLagAuthorization,
    OverrideErrorType = CloudError
  >;

  /**
   * Deletes the specified authorization from the specified express route LAG.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "The Network RP delete contract returns Location and Azure-AsyncOperation headers on the 202 response, matching existing ExpressRoute resources."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "This asynchronous delete returns 202 and 204 to match the existing ExpressRoute LAG resource delete contract in Network RP."
  @Azure.Core.useFinalStateVia("azure-async-operation")
  delete is ExpressRouteLagAuthorizationOps.DeleteWithoutOkAsync<
    ExpressRouteLagAuthorization,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse<ArmCombinedLroHeaders &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse,
    OverrideErrorType = CloudError
  >;

  /**
   * Gets all authorizations in an express route LAG.
   */
  list is ExpressRouteLagAuthorizationOps.List<
    ExpressRouteLagAuthorization,
    Response = ExpressRouteLagAuthorizationListResult,
    OverrideErrorType = CloudError
  >;

  /**
   * Gets the authorization key associated with the specified express route LAG authorization.
   */
  @action("listKeys")
  listKeys is ExpressRouteLagAuthorizationOps.ActionSync<
    ExpressRouteLagAuthorization,
    void,
    ArmResponse<ExpressRouteAuthorizationKey>,
    OverrideErrorType = CloudError
  >;
}

@@doc(ExpressRouteLagAuthorization.name, "The name of the authorization.");
@@doc(
  ExpressRouteLagAuthorization.properties,
  "ExpressRouteLag authorization properties."
);
@@doc(
  ExpressRouteLagAuthorizations.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update express route LAG authorization operation."
);
