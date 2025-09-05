import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AppServicePlan.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * Virtual Network information ARM resource.
 */
@parentResource(AppServicePlan)
model VnetInfoResource is Azure.ResourceManager.ProxyResource<VnetInfo> {
  ...ResourceNameParameter<
    Resource = VnetInfoResource,
    KeyName = "vnetName",
    SegmentName = "virtualNetworkConnections",
    NamePattern = ""
  >;
}

@armResourceOperations
interface VnetInfoResourceOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the App Service plan. */
        @path
        @segment("serverfarms")
        @key
        name: string,
      },
      {
        /** Name of the Virtual Network. */
        @path
        @segment("virtualNetworkConnections")
        @key
        vnetName: string,
      }
    > {}

@armResourceOperations
interface VnetInfoResources {
  /**
   * Description for Get a Virtual Network associated with an App Service plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AppServicePlans_GetVnetFromServerFarm")
  getVnetFromServerFarm is VnetInfoResourceOps.Read<
    VnetInfoResource,
    Response = ArmResponse<VnetInfoResource> | ArmNotFoundResponse
  >;

  /**
   * Description for Get all Virtual Networks associated with an App Service plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AppServicePlans_ListVnets")
  listVnets is VnetInfoResourceOps.ListSinglePage<
    VnetInfoResource,
    Response = ArmResponse<VnetInfoResource[]>
  >;
}
@armResourceOperations
interface VnetInfoResourceOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the app. */
        @path
        @segment("sites")
        @key
        name: string,

        /** Name of the deployment slot. If a slot is not specified, the API will get the named virtual network for the production slot. */
        @path
        @segment("slots")
        @key
        slot: string,
      },
      {
        /** Name of the virtual network. */
        @path
        @segment("virtualNetworkConnections")
        @key
        vnetName: string,
      }
    > {}

@armResourceOperations
interface VnetInfoResourceOperationGroup {
  /**
   * Description for Gets a virtual network the app (or deployment slot) is connected to by name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetVnetConnectionSlot")
  getVnetConnectionSlot is VnetInfoResourceOperationGroupOps.Read<VnetInfoResource>;

  /**
   * Description for Adds a Virtual Network connection to an app or slot (PUT) or updates the connection properties (PATCH).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_CreateOrUpdateVnetConnectionSlot")
  createOrUpdateVnetConnectionSlot is VnetInfoResourceOperationGroupOps.CreateOrUpdateSync<
    VnetInfoResource,
    Response = ArmResourceUpdatedResponse<VnetInfoResource>
  >;

  /**
   * Description for Adds a Virtual Network connection to an app or slot (PUT) or updates the connection properties (PATCH).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_UpdateVnetConnectionSlot")
  @patch(#{ implicitOptionality: false })
  updateVnetConnectionSlot is VnetInfoResourceOperationGroupOps.CustomPatchSync<
    VnetInfoResource,
    PatchModel = VnetInfoResource
  >;

  /**
   * Description for Deletes a connection from an app (or deployment slot to a named virtual network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_DeleteVnetConnectionSlot")
  deleteVnetConnectionSlot is VnetInfoResourceOperationGroupOps.DeleteSync<
    VnetInfoResource,
    Response = ArmDeletedResponse | ArmNotFoundResponse
  >;

  /**
   * Description for Gets the virtual networks the app (or deployment slot) is connected to.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListVnetConnectionsSlot")
  listVnetConnectionsSlot is VnetInfoResourceOperationGroupOps.ListSinglePage<
    VnetInfoResource,
    Response = ArmResponse<VnetInfoResource[]>
  >;
}
@armResourceOperations
interface VnetConnectionOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the app. */
        @path
        @segment("sites")
        @key
        name: string,
      },
      {
        /** Name of the virtual network. */
        @path
        @segment("virtualNetworkConnections")
        @key
        vnetName: string,
      }
    > {}

@armResourceOperations
interface VnetConnectionOperationGroup {
  /**
   * Description for Gets a virtual network the app (or deployment slot) is connected to by name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetVnetConnection")
  getVnetConnection is VnetConnectionOperationGroupOps.Read<VnetInfoResource>;

  /**
   * Description for Adds a Virtual Network connection to an app or slot (PUT) or updates the connection properties (PATCH).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_CreateOrUpdateVnetConnection")
  createOrUpdateVnetConnection is VnetConnectionOperationGroupOps.CreateOrUpdateSync<
    VnetInfoResource,
    Response = ArmResourceUpdatedResponse<VnetInfoResource>
  >;

  /**
   * Description for Adds a Virtual Network connection to an app or slot (PUT) or updates the connection properties (PATCH).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_UpdateVnetConnection")
  @patch(#{ implicitOptionality: false })
  updateVnetConnection is VnetConnectionOperationGroupOps.CustomPatchSync<
    VnetInfoResource,
    PatchModel = VnetInfoResource
  >;

  /**
   * Description for Deletes a connection from an app (or deployment slot to a named virtual network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_DeleteVnetConnection")
  deleteVnetConnection is VnetConnectionOperationGroupOps.DeleteSync<
    VnetInfoResource,
    Response = ArmDeletedResponse | ArmNotFoundResponse
  >;

  /**
   * Description for Gets the virtual networks the app (or deployment slot) is connected to.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListVnetConnections")
  @segment("virtualNetworkConnections")
  listVnetConnections is VnetConnectionOperationGroupOps.ListSinglePage<
    VnetInfoResource,
    Response = ArmResponse<VnetInfoResource[]>
  >;
}

@@doc(VnetInfoResource.name, "Name of the Virtual Network.");
@@doc(VnetInfoResource.properties, "Core resource properties");
@@doc(VnetInfoResourceOperationGroup.createOrUpdateVnetConnectionSlot::parameters.resource,
  "Properties of the Virtual Network connection. See example."
);
@@doc(VnetInfoResourceOperationGroup.updateVnetConnectionSlot::parameters.properties,
  "Properties of the Virtual Network connection. See example."
);
@@doc(VnetConnectionOperationGroup.createOrUpdateVnetConnection::parameters.resource,
  "Properties of the Virtual Network connection. See example."
);
@@doc(VnetConnectionOperationGroup.updateVnetConnection::parameters.properties,
  "Properties of the Virtual Network connection. See example."
);
