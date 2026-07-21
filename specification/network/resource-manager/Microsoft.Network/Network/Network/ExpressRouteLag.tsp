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
 * ExpressRouteLag resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "The includeInapplicableMetadataInPayload decorator is currently under Http.Private and is required to keep payload shape aligned with existing Network RP swagger output."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "This tracked resource explicitly defines name/etag/identity envelope fields to preserve existing Network RP contract and generated OpenAPI shape for ExpressRoute LAG."
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "This resource extends the shared Common.Resource envelope used across Network RP to maintain consistency with existing model composition."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "The Network RP TypeSpec project currently uses Azure.ResourceManager.Legacy feature toggles and operation templates across this API surface; this file must remain consistent with that project pattern."
@summary("ExpressRoute LAG")
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
@Http.Private.includeInapplicableMetadataInPayload(false)
@added(Versions.v2025_09_01)
model ExpressRouteLag extends Common.Resource {
  /** ExpressRouteLag properties. */
  properties?: ExpressRouteLagPropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("expressRouteLagName")
  @minLength(1)
  @maxLength(80)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]*$")
  @segment("expressRouteLags")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "etag is intentionally modeled as a read-only envelope field to match existing ExpressRoute resource contracts in Network RP."
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * The identity of ExpressRouteLag, if configured.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "identity is intentionally exposed at the resource envelope level to align with managed identity behavior of peer ExpressRoute resources."
  identity?: Common.ManagedServiceIdentity;
}

alias ExpressRouteLagLinkOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

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
    /** The name of the express route LAG link. */
    @path
    @segment("links")
    @key
    @minLength(1)
    @maxLength(80)
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]*$")
    linkName: string;
  },
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteLags/{expressRouteLagName}/links/{linkName}",
  }
>;

alias ExpressRouteLagMemberOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** The name of the express route LAG. */
    @path
    @segment("expressRouteLags")
    @key
    @minLength(1)
    @maxLength(80)
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]*$")
    expressRouteLagName: string;

    /** The name of the express route LAG link. */
    @path
    @segment("links")
    @key
    @minLength(1)
    @maxLength(80)
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]*$")
    linkName: string;
  },
  {
    /** The name of the express route LAG member. */
    @path
    @segment("members")
    @key
    @minLength(1)
    @maxLength(80)
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]*$")
    memberName: string;
  },
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteLags/{expressRouteLagName}/links/{linkName}/members/{memberName}",
  }
>;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "The containing service namespace still relies on Azure.ResourceManager.Legacy feature flags and templates; this interface follows the same established project-level pattern."
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
@armResourceOperations(#{ allowStaticRoutes: true, omitTags: true })
@added(Versions.v2025_09_01)
interface ExpressRouteLags {
  /**
   * Retrieves the requested ExpressRouteLag resource.
   */
  @tag("ExpressRouteLags")
  @autoRoute
  get is ArmResourceRead<ExpressRouteLag, Error = CloudError>;

  /**
   * Creates or updates the specified ExpressRouteLag resource.
   */
  @tag("ExpressRouteLags")
  @autoRoute
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ExpressRouteLag,
    Error = CloudError
  >;

  /**
   * Update ExpressRouteLag tags or identity.
   */
  @tag("ExpressRouteLags")
  @autoRoute
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    ExpressRouteLag,
    PatchModel = ExpressRouteLagUpdateTagsOrIdentityRequest,
    Error = CloudError
  >;

  /**
   * Deletes the specified ExpressRouteLag resource.
   */
  @tag("ExpressRouteLags")
  @autoRoute
  delete is ArmResourceDeleteWithoutOkAsync<
    ExpressRouteLag,
    Response =
      | ArmDeleteAcceptedLroResponse<ArmCombinedLroHeaders &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * List all the ExpressRouteLag resources in the specified resource group.
   */
  @tag("ExpressRouteLags")
  @autoRoute
  listByResourceGroup is ArmResourceListByParent<
    ExpressRouteLag,
    Response = ExpressRouteLagListResult,
    Error = CloudError
  >;

  /**
   * List all the ExpressRouteLag resources in the specified subscription.
   */
  @tag("ExpressRouteLags")
  @autoRoute
  list is ArmListBySubscription<
    ExpressRouteLag,
    Response = ExpressRouteLagListResult,
    Error = CloudError
  >;

  /**
   * Generate a letter of authorization for the requested ExpressRouteLag resource.
   */
  @tag("ExpressRouteLags")
  @action("generateLoa")
  @autoRoute
  generateLoa is ArmResourceActionSync<
    ExpressRouteLag,
    GenerateExpressRouteLagsLOARequest,
    ArmResponse<GenerateExpressRouteLagsLOAResult>,
    Error = CloudError
  >;

  /**
   * Retrieves the specified ExpressRouteLagLink resource.
   */
  @tag("ExpressRouteLagLinks")
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteLags/{expressRouteLagName}/links/{linkName}")
  linksGet is ExpressRouteLagLinkOps.ActionSync<
    ExpressRouteLag,
    void,
    Response = ArmResponse<ExpressRouteLagLink>,
    OverrideErrorType = CloudError
  >;

  /**
   * Retrieve the ExpressRouteLagLink sub-resources of the specified ExpressRouteLag resource.
   */
  @tag("ExpressRouteLagLinks")
  @list
  @get
  @action("links")
  @autoRoute
  linksList is ArmResourceActionSync<
    ExpressRouteLag,
    void,
    ArmResponse<ExpressRouteLagLinkListResult>,
    Error = CloudError
  >;

  /**
   * Retrieves the specified ExpressRouteLagMember resource.
   */
  @tag("ExpressRouteLagMembers")
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteLags/{expressRouteLagName}/links/{linkName}/members/{memberName}")
  membersGet is ExpressRouteLagMemberOps.ActionSync<
    ExpressRouteLag,
    void,
    Response = ArmResponse<ExpressRouteLagMember>,
    OverrideErrorType = CloudError
  >;

  /**
   * Retrieve the ExpressRouteLagMember sub-resources of the specified ExpressRouteLagLink resource.
   */
  @tag("ExpressRouteLagMembers")
  @list
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteLags/{expressRouteLagName}/links/{linkName}/members")
  membersList(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /** The name of the express route LAG. */
    @path
    @minLength(1)
    @maxLength(80)
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]*$")
    expressRouteLagName: string,

    /** The name of the express route LAG link. */
    @path
    @minLength(1)
    @maxLength(80)
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]*$")
    linkName: string,
  ): ArmResponse<ExpressRouteLagMemberListResult> | CloudError;
}

@@doc(ExpressRouteLag.name, "The name of ExpressRouteLag.");
@@doc(ExpressRouteLag.properties, "ExpressRouteLag properties.");
@@doc(
  ExpressRouteLags.createOrUpdate::parameters.resource,
  "Parameters supplied to the create ExpressRouteLag operation."
);
@@doc(
  ExpressRouteLags.update::parameters.properties,
  "Parameters supplied to update ExpressRouteLag resource tags or identity."
);
@@doc(
  ExpressRouteLags.generateLoa::parameters.body,
  "Request parameters supplied to generate a letter of authorization."
);

#suppress "@azure-tools/typespec-azure-core/no-openapi" "x-ms-pageable extension is required for this manually-routed list operation; ArmResourceListByParent is not used here"
@@extension(
  ExpressRouteLags.membersList,
  "x-ms-pageable",
  #{ nextLinkName: "nextLink" }
);
