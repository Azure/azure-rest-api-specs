import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DatabaseAccountGetResults.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DocumentDB;
/**
 * Network security perimeter (NSP) configuration resource
 */
@parentResource(DatabaseAccountGetResults)
model NetworkSecurityPerimeterConfiguration
  is Azure.ResourceManager.ProxyResource<Azure.ResourceManager.CommonTypes.NetworkSecurityPerimeterConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = NetworkSecurityPerimeterConfiguration,
    KeyName = "networkSecurityPerimeterConfigurationName",
    SegmentName = "networkSecurityPerimeterConfigurations",
    NamePattern = "^.*$"
  >;
}

@armResourceOperations
interface NetworkSecurityPerimeterConfigurations {
  /**
   * Gets effective Network Security Perimeter Configuration for association
   */
  get is ArmResourceRead<NetworkSecurityPerimeterConfiguration>;

  /**
   * Gets list of effective Network Security Perimeter Configuration for cosmos db account
   */
  list is ArmResourceListByParent<NetworkSecurityPerimeterConfiguration>;

  /**
   * Refreshes any information about the association.
   */
  reconcile is ArmResourceActionAsyncBase<
    NetworkSecurityPerimeterConfiguration,
    void,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<NetworkSecurityPerimeterConfiguration>
  >;
}

@@doc(NetworkSecurityPerimeterConfiguration.name,
  "The name for Network Security Perimeter configuration"
);
@@doc(NetworkSecurityPerimeterConfiguration.properties,
  "Network security configuration properties."
);
