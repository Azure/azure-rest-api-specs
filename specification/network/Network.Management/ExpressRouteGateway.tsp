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
model ExpressRouteGateway
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<ExpressRouteGatewayProperties> {
  ...ResourceNameParameter<
    Resource = ExpressRouteGateway,
    KeyName = "expressRouteGatewayName",
    SegmentName = "expressRouteGateways",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

alias ExpressRouteConnectionOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

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
  }
>;

@armResourceOperations
interface ExpressRouteGateways {
  /**
   * Fetches the details of a ExpressRoute gateway in a resource group.
   */
  get is ArmResourceRead<ExpressRouteGateway>;

  /**
   * Creates or updates a ExpressRoute gateway in a specified resource group.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ExpressRouteGateway>;

  /**
   * Updates express route gateway tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchAsync<
    ExpressRouteGateway,
    PatchModel = TagsObject,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = ExpressRouteGateway> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes the specified ExpressRoute gateway in a resource group. An ExpressRoute gateway resource can only be deleted when there are no connection subresources.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    ExpressRouteGateway,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists ExpressRoute gateways in a given resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    ExpressRouteGateway,
    Response = ArmResponse<ExpressRouteGatewayList>
  >;

  /**
   * Lists ExpressRoute gateways under a given subscription.
   */
  listBySubscription is ArmListBySubscription<
    ExpressRouteGateway,
    Response = ArmResponse<ExpressRouteGatewayList>
  >;

  /**
   * Creates a connection between an ExpressRoute gateway and an ExpressRoute circuit.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ExpressRouteConnections_CreateOrUpdate")
  @put
  @Azure.Core.useFinalStateVia("azure-async-operation")
  expressRouteConnectionsCreateOrUpdate is ExpressRouteConnectionOps.CreateOrUpdateAsync<
    ExpressRouteGateway,
    Response = ArmResponse<ExpressRouteConnection> | ArmResourceCreatedResponse<ExpressRouteConnection>,
    Request = ExpressRouteConnection
  >;

  /**
   * Gets the specified ExpressRouteConnection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ExpressRouteConnections_Get")
  @get
  expressRouteConnectionsGet is ExpressRouteConnectionOps.Read<
    ExpressRouteGateway,
    Response = ArmResponse<ExpressRouteConnection>
  >;

  /**
   * Deletes a connection to a ExpressRoute circuit.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ExpressRouteConnections_Delete")
  @delete
  expressRouteConnectionsDelete is ExpressRouteConnectionOps.DeleteWithoutOkAsync<
    ExpressRouteGateway,
    Response = OkResponse | ArmAcceptedLroResponse | NoContentResponse
  >;

  /**
   * Lists ExpressRouteConnections.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ExpressRouteConnections_List")
  @list
  @get
  list is ExpressRouteConnectionOps.List<
    ExpressRouteGateway,
    Response = ArmResponse<ExpressRouteConnectionList>
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
@@doc(ExpressRouteGateways.expressRouteConnectionsCreateOrUpdate::parameters.resource,
  "Parameters required in an ExpressRouteConnection PUT operation."
);
