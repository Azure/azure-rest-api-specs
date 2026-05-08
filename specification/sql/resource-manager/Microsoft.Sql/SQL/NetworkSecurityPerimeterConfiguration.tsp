import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * NSP Configuration for a server.
 */
@parentResource(Server)
model NetworkSecurityPerimeterConfiguration
  is Azure.ResourceManager.ProxyResource<NetworkSecurityPerimeterConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = NetworkSecurityPerimeterConfiguration,
    KeyName = "nspConfigName",
    SegmentName = "networkSecurityPerimeterConfigurations",
    NamePattern = ""
  >;
}

@armResourceOperations
interface NetworkSecurityPerimeterConfigurations {
  /**
   * Gets a network security perimeter configuration.
   */
  get is ArmResourceRead<NetworkSecurityPerimeterConfiguration>;

  /**
   * Gets a list of NSP configurations for a server.
   */
  listByServer is ArmResourceListByParent<NetworkSecurityPerimeterConfiguration>;

  /**
   * Reconcile network security perimeter configuration for SQL Resource Provider
   */
  reconcile is ArmResourceActionAsync<
    NetworkSecurityPerimeterConfiguration,
    void,
    Response = NetworkSecurityPerimeterConfiguration
  >;
}

@@doc(NetworkSecurityPerimeterConfiguration.name, "");
@@doc(NetworkSecurityPerimeterConfiguration.properties, "Resource properties.");
