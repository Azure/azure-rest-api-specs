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
 * ExpressRoute gateway resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
@Http.Private.includeInapplicableMetadataInPayload(false)
model ExpressRouteGateway extends Resource {
  properties?: ExpressRouteGatewayProperties;

  @visibility(Lifecycle.Read)
  @path
  @key("expressRouteGatewayName")
  @segment("expressRouteGateways")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

alias ExpressRouteConnectionOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** The name of the express route gateway. */
    @path
    @segment("expressRouteGateways")
    @key
    expressRouteGatewayName: string;
  },
  {
    /** The name of the express route connection. */
    @path
    @segment("expressRouteConnections")
    @key
    connectionName: string;
  },
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteGateways/{expressRouteGatewayName}/expressRouteConnections/{connectionName}",
  }
>;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
@armResourceOperations(#{ allowStaticRoutes: true })
interface ExpressRouteGateways {
  /**
   * Fetches the details of a ExpressRoute gateway in a resource group.
   */
  @autoRoute
  get is ArmResourceRead<ExpressRouteGateway, Error = CloudError>;

  /**
   * Creates or updates a ExpressRoute gateway in a specified resource group.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ExpressRouteGateway,
    Error = CloudError
  >;

  /**
   * Updates express route gateway tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  @autoRoute
  updateTags is ArmCustomPatchAsync<
    ExpressRouteGateway,
    PatchModel = TagsObject,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = ExpressRouteGateway> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;

  /**
   * Deletes the specified ExpressRoute gateway in a resource group. An ExpressRoute gateway resource can only be deleted when there are no connection subresources.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @autoRoute
  delete is ArmResourceDeleteWithoutOkAsync<
    ExpressRouteGateway,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists ExpressRoute gateways in a given resource group.
   */
  @autoRoute
  listByResourceGroup is ArmResourceListByParent<
    ExpressRouteGateway,
    Response = ArmResponse<ExpressRouteGatewayList>,
    Error = CloudError
  >;

  /**
   * Lists ExpressRoute gateways under a given subscription.
   */
  @autoRoute
  listBySubscription is ArmListBySubscription<
    ExpressRouteGateway,
    Response = ArmResponse<ExpressRouteGatewayList>,
    Error = CloudError
  >;

  /**
   * Creates a connection between an ExpressRoute gateway and an ExpressRoute circuit.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ExpressRouteConnections_CreateOrUpdate")
  @put
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteGateways/{expressRouteGatewayName}/expressRouteConnections/{connectionName}")
  expressRouteConnectionsCreateOrUpdate is ExpressRouteConnectionOps.ActionAsync<
    ExpressRouteGateway,
    ExpressRouteConnection,
    void,
    Response = ArmResponse<ExpressRouteConnection> | ArmResourceCreatedResponse<
      ExpressRouteConnection,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = ExpressRouteConnection> &
        Azure.Core.Foundations.RetryAfterHeader
    >,
    OverrideErrorType = CloudError
  >;

  /**
   * Gets the specified ExpressRouteConnection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ExpressRouteConnections_Get")
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteGateways/{expressRouteGatewayName}/expressRouteConnections/{connectionName}")
  expressRouteConnectionsGet is ExpressRouteConnectionOps.ActionSync<
    ExpressRouteGateway,
    void,
    Response = ArmResponse<ExpressRouteConnection>,
    OverrideErrorType = CloudError
  >;

  /**
   * Deletes a connection to a ExpressRoute circuit.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ExpressRouteConnections_Delete")
  @delete
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteGateways/{expressRouteGatewayName}/expressRouteConnections/{connectionName}")
  expressRouteConnectionsDelete is ExpressRouteConnectionOps.ActionAsync<
    ExpressRouteGateway,
    void,
    void,
    Response = {
      @body body: void;
    } | ArmAcceptedLroResponse | NoContentResponse,
    OverrideErrorType = CloudError
  >;

  /**
   * Lists ExpressRouteConnections.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ExpressRouteConnections_List")
  @list
  @get
  @action("expressRouteConnections")
  list is ArmResourceActionSync<
    ExpressRouteGateway,
    void,
    ArmResponse<ExpressRouteConnectionList>,
    Error = CloudError
  >;
}

@@doc(ExpressRouteGateway.name, "The name of the ExpressRoute gateway.");
@@doc(ExpressRouteGateway.properties,
  "Properties of the express route gateway."
);
@@doc(ExpressRouteGateways.createOrUpdate::parameters.resource,
  "Parameters required in an ExpressRoute gateway PUT operation."
);
@@doc(ExpressRouteGateways.updateTags::parameters.properties,
  "Parameters supplied to update a virtual wan express route gateway tags."
);
@@doc(ExpressRouteGateways.expressRouteConnectionsCreateOrUpdate::parameters.body,
  "Parameters required in an ExpressRouteConnection PUT operation."
);
