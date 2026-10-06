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
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "This decorator excludes the local @path name from the JSON payload so the proxy base supplies the optional read-only name instead of requiring it in the PUT body."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "The resource inherits the existing Network ProxyResourceWithReadOnlyID custom envelope to expose read-only id, name and type without declaring systemData that the backend does not return."
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Inheritance preserves the separate proxy identity schema when the local @path name is excluded from the payload; spreading the base would replace its payload name with the path-only property."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "The feature decorator routes this resource to expressRoute.json under output-splitting: legacy-feature-files."
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
@summary("ExpressRoute Lag Authorization")
@Http.Private.includeInapplicableMetadataInPayload(false)
@added(Versions.v2026_03_01)
model ExpressRouteLagAuthorization extends ProxyResourceWithReadOnlyID {
  /** ExpressRouteLag authorization properties. */
  properties?: ExpressRouteLagAuthorizationPropertiesFormat;

  /**
   * The authorization name, unique within the parent ExpressRoute LAG.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("authorizationName")
  @minLength(1)
  @maxLength(80)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]*$")
  @segment("authorizations")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
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
    @minLength(1)
    @maxLength(80)
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]*$")
    expressRouteLagName: string;
  },
  {
    /** The authorization name, unique within the parent ExpressRoute LAG. */
    @path
    @segment("authorizations")
    @key
    @minLength(1)
    @maxLength(80)
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]*$")
    authorizationName: string;
  }
>;

/** Polling headers returned when creating or updating an ExpressRoute LAG authorization. */
alias ExpressRouteLagAuthorizationLroHeaders = ArmAsyncOperationHeader<
  UrlValue = url,
  FinalResult = ExpressRouteLagAuthorization
> &
  Azure.Core.Foundations.RetryAfterHeader;

/** The request has succeeded. */
model ExpressRouteLagAuthorizationUpdatedResult {
  ...ArmResourceUpdatedResponse<ExpressRouteLagAuthorization>;
  ...ExpressRouteLagAuthorizationLroHeaders;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "LegacyOperations supplies the explicit Network route parameter groups, and the feature decorator routes these operations to expressRoute.json under output-splitting: legacy-feature-files."
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
  // The status monitor returns only operation status; retrieve the resource from its original URI.
  @Azure.Core.useFinalStateVia("original-uri")
  createOrUpdate is ExpressRouteLagAuthorizationOps.CreateOrUpdateAsync<
    ExpressRouteLagAuthorization,
    Response =
      | ExpressRouteLagAuthorizationUpdatedResult
      | ArmResourceCreatedResponse<
          ExpressRouteLagAuthorization,
          ExpressRouteLagAuthorizationLroHeaders
        >,
    OverrideErrorType = CloudError
  >;

  /**
   * Deletes the specified authorization from the specified express route LAG.
   */
  delete is ExpressRouteLagAuthorizationOps.DeleteWithoutOkAsync<
    ExpressRouteLagAuthorization,
    Response =
      | ArmDeleteAcceptedLroResponse<ArmCombinedLroHeaders<
          FinalResult = void,
          FinalUrlValue = url
        > &
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

@@doc(
  ExpressRouteLagAuthorization.name,
  "The authorization name, unique within the parent ExpressRoute LAG."
);
@@doc(
  ExpressRouteLagAuthorization.properties,
  "ExpressRouteLag authorization properties."
);
@@doc(
  ExpressRouteLagAuthorizations.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update express route LAG authorization operation."
);
