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
  @action("{connectionName}")
  expressRouteConnectionsCreateOrUpdate is ArmResourceActionAsyncBase<
    ExpressRouteGateway,
    ExpressRouteConnection,
    ArmResponse<ExpressRouteConnection> | ArmResourceCreatedResponse<ExpressRouteConnection>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ExpressRouteGateway>,
    Parameters = {
      /**
       * The name of the connection subresource.
       */
      @path
      connectionName: string;
    }
  >;

  /**
   * Gets the specified ExpressRouteConnection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ExpressRouteConnections_Get")
  @get
  @action("{connectionName}")
  expressRouteConnectionsGet is ArmResourceActionSync<
    ExpressRouteGateway,
    void,
    ArmResponse<ExpressRouteConnection>,
    Parameters = {
      /**
       * The name of the ExpressRoute connection.
       */
      @path
      connectionName: string;
    }
  >;

  /**
   * Deletes a connection to a ExpressRoute circuit.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ExpressRouteConnections_Delete")
  @delete
  @action("{connectionName}")
  expressRouteConnectionsDelete is ArmResourceActionAsync<
    ExpressRouteGateway,
    void,
    OkResponse | NoContentResponse,
    Parameters = {
      /**
       * The name of the connection subresource.
       */
      @path
      connectionName: string;
    }
  >;

  /**
   * Lists ExpressRouteConnections.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ExpressRouteConnections_List")
  @list
  @get
  @action("expressRouteConnections")
  list is ArmResourceActionSync<
    ExpressRouteGateway,
    void,
    ArmResponse<ExpressRouteConnectionList>
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
