import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * Swift Virtual Network Contract. This is used to enable the new Swift way of doing virtual network integration.
 */
@singleton("virtualNetwork")
@parentResource(Site)
model SwiftVirtualNetwork
  is Azure.ResourceManager.ProxyResource<SwiftVirtualNetworkProperties> {
  ...ResourceNameParameter<
    Resource = SwiftVirtualNetwork,
    KeyName = "networkConfig",
    SegmentName = "networkConfig",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SwiftVirtualNetworkOps
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
      },
      KeysOf<ResourceNameParameter<
        Resource = SwiftVirtualNetwork,
        KeyName = "virtualNetwork",
        SegmentName = "networkConfig",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface SwiftVirtualNetworks {
  /**
   * Description for Gets a Swift Virtual Network connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetSwiftVirtualNetworkConnection")
  getSwiftVirtualNetworkConnection is SwiftVirtualNetworkOps.Read<SwiftVirtualNetwork>;

  /**
   * Description for Integrates this Web App with a Virtual Network. This requires that 1) "swiftSupported" is true when doing a GET against this resource, and 2) that the target Subnet has already been delegated, and is not
   * in use by another App Service Plan other than the one this App is in.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_CreateOrUpdateSwiftVirtualNetworkConnectionWithCheck")
  createOrUpdateSwiftVirtualNetworkConnectionWithCheck is SwiftVirtualNetworkOps.CreateOrUpdateSync<
    SwiftVirtualNetwork,
    Response = ArmResourceUpdatedResponse<SwiftVirtualNetwork>
  >;

  /**
   * Description for Integrates this Web App with a Virtual Network. This requires that 1) "swiftSupported" is true when doing a GET against this resource, and 2) that the target Subnet has already been delegated, and is not
   * in use by another App Service Plan other than the one this App is in.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("WebApps_UpdateSwiftVirtualNetworkConnectionWithCheck")
  updateSwiftVirtualNetworkConnectionWithCheck is SwiftVirtualNetworkOps.CustomPatchSync<
    SwiftVirtualNetwork,
    PatchModel = SwiftVirtualNetwork
  >;

  /**
   * Description for Deletes a Swift Virtual Network connection from an app (or deployment slot).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_DeleteSwiftVirtualNetwork")
  deleteSwiftVirtualNetwork is SwiftVirtualNetworkOps.DeleteSync<
    SwiftVirtualNetwork,
    Response = ArmDeletedResponse
  >;
}
@armResourceOperations
interface SwiftVirtualNetworkOperationGroupOps
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
      },
      KeysOf<ResourceNameParameter<
        Resource = SwiftVirtualNetwork,
        KeyName = "virtualNetwork",
        SegmentName = "networkConfig",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface SwiftVirtualNetworkOperationGroup {
  /**
   * Description for Gets a Swift Virtual Network connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetSwiftVirtualNetworkConnectionSlot")
  getSwiftVirtualNetworkConnectionSlot is SwiftVirtualNetworkOperationGroupOps.Read<SwiftVirtualNetwork>;

  /**
   * Description for Integrates this Web App with a Virtual Network. This requires that 1) "swiftSupported" is true when doing a GET against this resource, and 2) that the target Subnet has already been delegated, and is not
   * in use by another App Service Plan other than the one this App is in.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_CreateOrUpdateSwiftVirtualNetworkConnectionWithCheckSlot")
  createOrUpdateSwiftVirtualNetworkConnectionWithCheckSlot is SwiftVirtualNetworkOperationGroupOps.CreateOrUpdateSync<
    SwiftVirtualNetwork,
    Response = ArmResourceUpdatedResponse<SwiftVirtualNetwork>
  >;

  /**
   * Description for Integrates this Web App with a Virtual Network. This requires that 1) "swiftSupported" is true when doing a GET against this resource, and 2) that the target Subnet has already been delegated, and is not
   * in use by another App Service Plan other than the one this App is in.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("WebApps_UpdateSwiftVirtualNetworkConnectionWithCheckSlot")
  updateSwiftVirtualNetworkConnectionWithCheckSlot is SwiftVirtualNetworkOperationGroupOps.CustomPatchSync<
    SwiftVirtualNetwork,
    PatchModel = SwiftVirtualNetwork
  >;

  /**
   * Description for Deletes a Swift Virtual Network connection from an app (or deployment slot).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_DeleteSwiftVirtualNetworkSlot")
  deleteSwiftVirtualNetworkSlot is SwiftVirtualNetworkOperationGroupOps.DeleteSync<
    SwiftVirtualNetwork,
    Response = ArmDeletedResponse
  >;
}

@@doc(SwiftVirtualNetwork.name, "");
@@doc(SwiftVirtualNetwork.properties,
  "SwiftVirtualNetwork resource specific properties"
);
@@doc(SwiftVirtualNetworks.createOrUpdateSwiftVirtualNetworkConnectionWithCheck::parameters.resource,
  "Properties of the Virtual Network connection. See example."
);
@@doc(SwiftVirtualNetworks.updateSwiftVirtualNetworkConnectionWithCheck::parameters.properties,
  "Properties of the Virtual Network connection. See example."
);
@@doc(SwiftVirtualNetworkOperationGroup.createOrUpdateSwiftVirtualNetworkConnectionWithCheckSlot::parameters.resource,
  "Properties of the Virtual Network connection. See example."
);
@@doc(SwiftVirtualNetworkOperationGroup.updateSwiftVirtualNetworkConnectionWithCheckSlot::parameters.properties,
  "Properties of the Virtual Network connection. See example."
);
