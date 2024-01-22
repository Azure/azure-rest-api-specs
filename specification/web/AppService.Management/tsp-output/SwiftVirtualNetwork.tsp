import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * Swift Virtual Network Contract. This is used to enable the new Swift way of doing virtual network integration.
 */
@singleton("virtualNetwork")
@parentResource(Site)
model SwiftVirtualNetwork is ProxyResource<SwiftVirtualNetworkProperties> {
  @key("networkConfig")
  @segment("networkConfig")
  name: string;
}

@armResourceOperations
interface SwiftVirtualNetworks {
  /**
   * Description for Gets a Swift Virtual Network connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_GetSwiftVirtualNetworkConnection")
  getSwiftVirtualNetworkConnection is ArmResourceRead<SwiftVirtualNetwork>;

  /**
* Description for Integrates this Web App with a Virtual Network. This requires that 1) "swiftSupported" is true when doing a GET against this resource, and 2) that the target Subnet has already been delegated, and is not
in use by another App Service Plan other than the one this App is in.
*/
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_CreateOrUpdateSwiftVirtualNetworkConnectionWithCheck")
  createOrUpdateSwiftVirtualNetworkConnectionWithCheck is ArmResourceCreateOrReplaceSync<SwiftVirtualNetwork>;

  /**
* Description for Integrates this Web App with a Virtual Network. This requires that 1) "swiftSupported" is true when doing a GET against this resource, and 2) that the target Subnet has already been delegated, and is not
in use by another App Service Plan other than the one this App is in.
*/
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("WebApps_UpdateSwiftVirtualNetworkConnectionWithCheck")
  updateSwiftVirtualNetworkConnectionWithCheck is ArmCustomPatchSync<
    SwiftVirtualNetwork,
    SwiftVirtualNetwork
  >;

  /**
   * Description for Deletes a Swift Virtual Network connection from an app (or deployment slot).
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_DeleteSwiftVirtualNetwork")
  deleteSwiftVirtualNetwork is ArmResourceDeleteSync<SwiftVirtualNetwork>;
}

@@projectedName(SwiftVirtualNetworks.createOrUpdateSwiftVirtualNetworkConnectionWithCheck::parameters.resource,
  "json",
  "connectionEnvelope"
);
@@extension(SwiftVirtualNetworks.createOrUpdateSwiftVirtualNetworkConnectionWithCheck::parameters.resource,
  "x-ms-client-name",
  "connectionEnvelope"
);
@@doc(SwiftVirtualNetworks.createOrUpdateSwiftVirtualNetworkConnectionWithCheck::parameters.resource,
  "Properties of the Virtual Network connection. See example."
);
@@projectedName(SwiftVirtualNetworks.updateSwiftVirtualNetworkConnectionWithCheck::parameters.properties,
  "json",
  "connectionEnvelope"
);
@@extension(SwiftVirtualNetworks.updateSwiftVirtualNetworkConnectionWithCheck::parameters.properties,
  "x-ms-client-name",
  "connectionEnvelope"
);
@@doc(SwiftVirtualNetworks.updateSwiftVirtualNetworkConnectionWithCheck::parameters.properties,
  "Properties of the Virtual Network connection. See example."
);
