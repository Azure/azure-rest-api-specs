import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * ExpressRoutePort resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@summary("ExpressRoute Port")
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
@Http.Private.includeInapplicableMetadataInPayload(false)
model ExpressRoutePort extends Resource {
  properties?: ExpressRoutePortPropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("expressRoutePortName")
  @segment("ExpressRoutePorts")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * The identity of ExpressRoutePort, if configured.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: ManagedServiceIdentity;
}

alias ExpressRouteLinkOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** The name of the express route port. */
    @path
    @segment("ExpressRoutePorts")
    @key
    expressRoutePortName: string;
  },
  {
    /** The name of the express route link. */
    @path
    @segment("links")
    @key
    linkName: string;
  },
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRoutePorts/{expressRoutePortName}/links/{linkName}",
  }
>;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
@armResourceOperations(#{ allowStaticRoutes: true })
interface ExpressRoutePorts {
  /**
   * Retrieves the requested ExpressRoutePort resource.
   */
  @autoRoute
  get is ArmResourceRead<ExpressRoutePort, Error = CloudError>;

  /**
   * Creates or updates the specified ExpressRoutePort resource.
   */
  @autoRoute
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ExpressRoutePort,
    Error = CloudError
  >;

  /**
   * Update ExpressRoutePort tags.
   */
  @autoRoute
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    ExpressRoutePort,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes the specified ExpressRoutePort resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @autoRoute
  delete is ArmResourceDeleteWithoutOkAsync<
    ExpressRoutePort,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * List all the ExpressRoutePort resources in the specified resource group.
   */
  @autoRoute
  listByResourceGroup is ArmResourceListByParent<
    ExpressRoutePort,
    Response = ExpressRoutePortListResult,
    Error = CloudError
  >;

  /**
   * List all the ExpressRoutePort resources in the specified subscription.
   */
  @autoRoute
  list is ArmListBySubscription<
    ExpressRoutePort,
    Response = ExpressRoutePortListResult,
    Error = CloudError
  >;

  /**
   * Generate a letter of authorization for the requested ExpressRoutePort resource.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("generateLoa")
  @autoRoute
  generateLOA is ArmResourceActionSync<
    ExpressRoutePort,
    GenerateExpressRoutePortsLOARequest,
    ArmResponse<GenerateExpressRoutePortsLOAResult>,
    Error = CloudError
  >;

  /**
   * Retrieves the specified ExpressRouteLink resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ExpressRouteLinks_Get")
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/ExpressRoutePorts/{expressRoutePortName}/links/{linkName}")
  expressRouteLinksGet is ExpressRouteLinkOps.ActionSync<
    ExpressRoutePort,
    void,
    Response = ArmResponse<ExpressRouteLink>,
    OverrideErrorType = CloudError
  >;

  /**
   * Retrieve the ExpressRouteLink sub-resources of the specified ExpressRoutePort resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ExpressRouteLinks_List")
  @list
  @get
  @action("links")
  @autoRoute
  expressRouteLinksList is ArmResourceActionSync<
    ExpressRoutePort,
    void,
    ArmResponse<ExpressRouteLinkListResult>,
    Error = CloudError
  >;
}

@@doc(ExpressRoutePort.name, "The name of ExpressRoutePort.");
@@doc(ExpressRoutePort.properties, "ExpressRoutePort properties.");
@@doc(ExpressRoutePorts.createOrUpdate::parameters.resource,
  "Parameters supplied to the create ExpressRoutePort operation."
);
@@doc(ExpressRoutePorts.updateTags::parameters.properties,
  "Parameters supplied to update ExpressRoutePort resource tags."
);
@@doc(ExpressRoutePorts.generateLOA::parameters.body,
  "Request parameters supplied to generate a letter of authorization."
);
