import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VnetInfoResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * The Virtual Network gateway contract. This is used to give the Virtual Network gateway access to the VPN package.
 */
@parentResource(VnetInfoResource)
model VnetGateway
  is Azure.ResourceManager.ProxyResource<VnetGatewayProperties> {
  ...ResourceNameParameter<
    Resource = VnetGateway,
    KeyName = "gatewayName",
    SegmentName = "gateways",
    NamePattern = ""
  >;

  /**
   * Kind of resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

@armResourceOperations
interface VnetGatewayOps
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

        /** Name of the Virtual Network. */
        @path
        @segment("virtualNetworkConnections")
        @key
        vnetName: string,
      },
      {
        /** Name of the gateway. Only the 'primary' gateway is supported. */
        @path
        @segment("gateways")
        @key
        gatewayName: string,
      }
    > {}

@armResourceOperations
interface VnetGateways {
  /**
   * Description for Get a Virtual Network gateway.
   */
  @summary("Get a Virtual Network gateway.")
  getVnetGateway is VnetGatewayOps.Read<
    VnetGateway,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Update a Virtual Network gateway.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Update a Virtual Network gateway.")
  updateVnetGateway is VnetGatewayOps.CreateOrUpdateSync<
    VnetGateway,
    Response = ArmResourceUpdatedResponse<VnetGateway>,
    OverrideErrorType = DefaultErrorResponse
  >;
}
@armResourceOperations
interface VnetGatewayOperationGroupOps
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

        /** Name of the deployment slot. If a slot is not specified, the API will get a gateway for the production slot's Virtual Network. */
        @path
        @segment("slots")
        @key
        slot: string,

        /** Name of the Virtual Network. */
        @path
        @segment("virtualNetworkConnections")
        @key
        vnetName: string,
      },
      {
        /** Name of the gateway. Currently, the only supported string is "primary". */
        @path
        @segment("gateways")
        @key
        gatewayName: string,
      }
    > {}

@armResourceOperations
interface VnetGatewayOperationGroup {
  /**
   * Description for Gets an app's Virtual Network gateway.
   */
  @summary("Gets an app's Virtual Network gateway.")
  getVnetConnectionGatewaySlot is VnetGatewayOperationGroupOps.Read<
    VnetGateway,
    Response = ArmResponse<VnetGateway> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Adds a gateway to a connected Virtual Network (PUT) or updates it (PATCH).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Adds a gateway to a connected Virtual Network (PUT) or updates it (PATCH).")
  createOrUpdateVnetConnectionGatewaySlot is VnetGatewayOperationGroupOps.CreateOrUpdateSync<
    VnetGateway,
    Response = ArmResourceUpdatedResponse<VnetGateway>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Adds a gateway to a connected Virtual Network (PUT) or updates it (PATCH).
   */
  @summary("Adds a gateway to a connected Virtual Network (PUT) or updates it (PATCH).")
  @patch(#{ implicitOptionality: false })
  updateVnetConnectionGatewaySlot is VnetGatewayOperationGroupOps.CustomPatchSync<
    VnetGateway,
    PatchModel = VnetGateway,
    OverrideErrorType = DefaultErrorResponse
  >;
}
@armResourceOperations
interface VnetConnectionGatewayOperationGroupOps
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

        /** Name of the Virtual Network. */
        @path
        @segment("virtualNetworkConnections")
        @key
        vnetName: string,
      },
      {
        /** Name of the gateway. Currently, the only supported string is "primary". */
        @path
        @segment("gateways")
        @key
        gatewayName: string,
      }
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface VnetConnectionGatewayOperationGroup {
  /**
   * Description for Gets an app's Virtual Network gateway.
   */
  @summary("Gets an app's Virtual Network gateway.")
  getVnetConnectionGateway is VnetConnectionGatewayOperationGroupOps.Read<
    VnetGateway,
    Response = ArmResponse<VnetGateway> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Adds a gateway to a connected Virtual Network (PUT) or updates it (PATCH).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Adds a gateway to a connected Virtual Network (PUT) or updates it (PATCH).")
  createOrUpdateVnetConnectionGateway is VnetConnectionGatewayOperationGroupOps.CreateOrUpdateSync<
    VnetGateway,
    Response = ArmResourceUpdatedResponse<VnetGateway>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Adds a gateway to a connected Virtual Network (PUT) or updates it (PATCH).
   */
  @summary("Adds a gateway to a connected Virtual Network (PUT) or updates it (PATCH).")
  @patch(#{ implicitOptionality: false })
  updateVnetConnectionGateway is VnetConnectionGatewayOperationGroupOps.CustomPatchSync<
    VnetGateway,
    PatchModel = VnetGateway,
    Response = ArmResponse<VnetGateway>,
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(VnetGateway.name,
  "Name of the gateway. Only the 'primary' gateway is supported."
);
@@doc(VnetGateway.properties, "VnetGateway resource specific properties");
@@doc(VnetGateways.updateVnetGateway::parameters.resource,
  "Definition of the gateway."
);
@@doc(VnetGatewayOperationGroup.createOrUpdateVnetConnectionGatewaySlot::parameters.resource,
  "The properties to update this gateway with."
);
@@doc(VnetGatewayOperationGroup.updateVnetConnectionGatewaySlot::parameters.properties,
  "The properties to update this gateway with."
);
@@doc(VnetConnectionGatewayOperationGroup.createOrUpdateVnetConnectionGateway::parameters.resource,
  "The properties to update this gateway with."
);
@@doc(VnetConnectionGatewayOperationGroup.updateVnetConnectionGateway::parameters.properties,
  "The properties to update this gateway with."
);
