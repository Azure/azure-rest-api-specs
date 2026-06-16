import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./StorageAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Storage;
/**
 * The Network Security Perimeter configuration resource.
 */
@parentResource(StorageAccount)
model NetworkSecurityPerimeterConfiguration
  is Azure.ResourceManager.ProxyResource<NetworkSecurityPerimeterConfigurationProperties> {
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
   * Gets effective NetworkSecurityPerimeterConfiguration for association
   */
  get is ArmResourceRead<
    NetworkSecurityPerimeterConfiguration,
    Error = ErrorResponse
  >;

  /**
   * Gets list of effective NetworkSecurityPerimeterConfiguration for storage account
   */
  list is ArmResourceListByParent<
    NetworkSecurityPerimeterConfiguration,
    Response = ArmResponse<NetworkSecurityPerimeterConfigurationList>,
    Error = ErrorResponse
  >;

  /**
   * Refreshes any information about the association.
   */
  reconcile is ArmResourceActionAsyncBase<
    NetworkSecurityPerimeterConfiguration,
    void,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<NetworkSecurityPerimeterConfiguration>,
    Error = ErrorResponse
  >;
}

@@doc(NetworkSecurityPerimeterConfiguration.name,
  "The name for Network Security Perimeter configuration"
);
@@doc(NetworkSecurityPerimeterConfiguration.properties,
  "Properties of the Network Security Perimeter Configuration"
);
