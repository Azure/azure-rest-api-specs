import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BatchAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Batch;
/**
 * Network security perimeter (NSP) configuration resource
 */
@parentResource(BatchAccount)
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
   * Gets information about the specified NSP configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkSecurityPerimeter_GetConfiguration")
  getConfiguration is ArmResourceRead<NetworkSecurityPerimeterConfiguration>;

  /**
   * Lists all of the NSP configurations in the specified account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkSecurityPerimeter_ListConfigurations")
  listConfigurations is ArmResourceListByParent<NetworkSecurityPerimeterConfiguration>;

  /**
   * Reconciles the specified NSP configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkSecurityPerimeter_ReconcileConfiguration")
  @action("reconcile")
  reconcileConfiguration is ArmResourceActionAsyncBase<
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
