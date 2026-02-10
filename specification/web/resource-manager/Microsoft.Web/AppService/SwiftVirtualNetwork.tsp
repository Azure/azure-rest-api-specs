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

namespace Microsoft.Web;
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

  /**
   * Kind of resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

@armResourceOperations
interface SwiftVirtualNetworkOps
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
        /** undefined */
        @path
        @segment("networkConfig")
        @key
        virtualNetwork: "virtualNetwork",
      }
    > {}

@armResourceOperations
interface SwiftVirtualNetworks {
  /**
   * Description for Gets a Swift Virtual Network connection.
   */
  @summary("Gets a Swift Virtual Network connection.")
  getSwiftVirtualNetworkConnection is SwiftVirtualNetworkOps.Read<
    SwiftVirtualNetwork,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Integrates this Web App with a Virtual Network. This requires that 1) "swiftSupported" is true when doing a GET against this resource, and 2) that the target Subnet has already been delegated, and is not
   * in use by another App Service Plan other than the one this App is in.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Integrates this Web App with a Virtual Network. This requires that 1) \"swiftSupported\" is true when doing a GET against this resource, and 2) that the target Subnet has already been delegated, and is not\r\nin use by another App Service Plan other than the one this App is in.")
  createOrUpdateSwiftVirtualNetworkConnectionWithCheck is SwiftVirtualNetworkOps.CreateOrUpdateSync<
    SwiftVirtualNetwork,
    Response = ArmResourceUpdatedResponse<SwiftVirtualNetwork>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Integrates this Web App with a Virtual Network. This requires that 1) "swiftSupported" is true when doing a GET against this resource, and 2) that the target Subnet has already been delegated, and is not
   * in use by another App Service Plan other than the one this App is in.
   */
  @summary("Integrates this Web App with a Virtual Network. This requires that 1) \"swiftSupported\" is true when doing a GET against this resource, and 2) that the target Subnet has already been delegated, and is not\r\nin use by another App Service Plan other than the one this App is in.")
  @patch(#{ implicitOptionality: false })
  updateSwiftVirtualNetworkConnectionWithCheck is SwiftVirtualNetworkOps.CustomPatchSync<
    SwiftVirtualNetwork,
    PatchModel = SwiftVirtualNetwork,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Deletes a Swift Virtual Network connection from an app (or deployment slot).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Deletes a Swift Virtual Network connection from an app (or deployment slot).")
  deleteSwiftVirtualNetwork is SwiftVirtualNetworkOps.DeleteSync<
    SwiftVirtualNetwork,
    Response = ArmDeletedResponse | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
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
      },
      {
        /** undefined */
        @path
        @segment("networkConfig")
        @key
        virtualNetwork: "virtualNetwork",
      }
    > {}

@armResourceOperations
interface SwiftVirtualNetworkOperationGroup {
  /**
   * Description for Gets a Swift Virtual Network connection.
   */
  @summary("Gets a Swift Virtual Network connection.")
  getSwiftVirtualNetworkConnectionSlot is SwiftVirtualNetworkOperationGroupOps.Read<
    SwiftVirtualNetwork,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Integrates this Web App with a Virtual Network. This requires that 1) "swiftSupported" is true when doing a GET against this resource, and 2) that the target Subnet has already been delegated, and is not
   * in use by another App Service Plan other than the one this App is in.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Integrates this Web App with a Virtual Network. This requires that 1) \"swiftSupported\" is true when doing a GET against this resource, and 2) that the target Subnet has already been delegated, and is not\r\nin use by another App Service Plan other than the one this App is in.")
  createOrUpdateSwiftVirtualNetworkConnectionWithCheckSlot is SwiftVirtualNetworkOperationGroupOps.CreateOrUpdateSync<
    SwiftVirtualNetwork,
    Response = ArmResourceUpdatedResponse<SwiftVirtualNetwork>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Integrates this Web App with a Virtual Network. This requires that 1) "swiftSupported" is true when doing a GET against this resource, and 2) that the target Subnet has already been delegated, and is not
   * in use by another App Service Plan other than the one this App is in.
   */
  @summary("Integrates this Web App with a Virtual Network. This requires that 1) \"swiftSupported\" is true when doing a GET against this resource, and 2) that the target Subnet has already been delegated, and is not\r\nin use by another App Service Plan other than the one this App is in.")
  @patch(#{ implicitOptionality: false })
  updateSwiftVirtualNetworkConnectionWithCheckSlot is SwiftVirtualNetworkOperationGroupOps.CustomPatchSync<
    SwiftVirtualNetwork,
    PatchModel = SwiftVirtualNetwork,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Deletes a Swift Virtual Network connection from an app (or deployment slot).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Deletes a Swift Virtual Network connection from an app (or deployment slot).")
  deleteSwiftVirtualNetworkSlot is SwiftVirtualNetworkOperationGroupOps.DeleteSync<
    SwiftVirtualNetwork,
    Response = ArmDeletedResponse | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
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
