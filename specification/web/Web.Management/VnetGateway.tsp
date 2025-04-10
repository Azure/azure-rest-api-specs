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

namespace Microsoft.CertificateRegistration;
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
}

@armResourceOperations
interface VnetGatewayOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = AppServicePlan,
          KeyName = "name",
          SegmentName = "serverfarms",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = VnetInfoResource,
          KeyName = "vnetName",
          SegmentName = "virtualNetworkConnections",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = VnetGateway,
        KeyName = "gatewayName",
        SegmentName = "gateways",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface VnetGateways {
  /**
   * Description for Get a Virtual Network gateway.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AppServicePlans_GetVnetGateway")
  getVnetGateway is VnetGatewayOps.Read<VnetGateway>;

  /**
   * Description for Update a Virtual Network gateway.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("AppServicePlans_UpdateVnetGateway")
  updateVnetGateway is VnetGatewayOps.CreateOrUpdateSync<
    VnetGateway,
    Response = ArmResourceUpdatedResponse<VnetGateway>
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
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "name",
          SegmentName = "sites",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "slot",
          SegmentName = "slots",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = VnetInfoResource,
          KeyName = "vnetName",
          SegmentName = "virtualNetworkConnections",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = VnetGateway,
        KeyName = "gatewayName",
        SegmentName = "gateways",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface VnetGatewayOperationGroup {
  /**
   * Description for Gets an app's Virtual Network gateway.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetVnetConnectionGatewaySlot")
  getVnetConnectionGatewaySlot is VnetGatewayOperationGroupOps.Read<VnetGateway>;

  /**
   * Description for Adds a gateway to a connected Virtual Network (PUT) or updates it (PATCH).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_CreateOrUpdateVnetConnectionGatewaySlot")
  createOrUpdateVnetConnectionGatewaySlot is VnetGatewayOperationGroupOps.CreateOrUpdateSync<
    VnetGateway,
    Response = ArmResourceUpdatedResponse<VnetGateway>
  >;

  /**
   * Description for Adds a gateway to a connected Virtual Network (PUT) or updates it (PATCH).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("WebApps_UpdateVnetConnectionGatewaySlot")
  updateVnetConnectionGatewaySlot is VnetGatewayOperationGroupOps.CustomPatchSync<
    VnetGateway,
    PatchModel = VnetGateway
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
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "name",
          SegmentName = "sites",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = VnetInfoResource,
          KeyName = "vnetName",
          SegmentName = "virtualNetworkConnections",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = VnetGateway,
        KeyName = "gatewayName",
        SegmentName = "gateways",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface VnetGatewayOperationGroup {
  /**
   * Description for Gets an app's Virtual Network gateway.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetVnetConnectionGateway")
  getVnetConnectionGateway is VnetGatewayOperationGroupOps.Read<VnetGateway>;

  /**
   * Description for Adds a gateway to a connected Virtual Network (PUT) or updates it (PATCH).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_CreateOrUpdateVnetConnectionGateway")
  createOrUpdateVnetConnectionGateway is VnetGatewayOperationGroupOps.CreateOrUpdateSync<
    VnetGateway,
    Response = ArmResourceUpdatedResponse<VnetGateway>
  >;

  /**
   * Description for Adds a gateway to a connected Virtual Network (PUT) or updates it (PATCH).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("WebApps_UpdateVnetConnectionGateway")
  updateVnetConnectionGateway is VnetGatewayOperationGroupOps.CustomPatchSync<
    VnetGateway,
    PatchModel = VnetGateway
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
@@doc(VnetGatewayOperationGroup.createOrUpdateVnetConnectionGateway::parameters.resource,
  "The properties to update this gateway with."
);
@@doc(VnetGatewayOperationGroup.updateVnetConnectionGateway::parameters.properties,
  "The properties to update this gateway with."
);
