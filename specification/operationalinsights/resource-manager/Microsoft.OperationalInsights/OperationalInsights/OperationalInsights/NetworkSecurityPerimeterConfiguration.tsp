import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OperationalInsights;
/**
 * Network security perimeter (NSP) configuration resource
 */
model NetworkSecurityPerimeterConfiguration
  is Azure.ResourceManager.ProxyResource<CommonTypes.NetworkSecurityPerimeterConfigurationProperties> {
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
   * Gets a network security perimeter configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Workspaces_GetNSP")
  getNSP is ArmResourceRead<NetworkSecurityPerimeterConfiguration>;

  /**
   * Gets a list of NSP configurations for specified workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Workspaces_ListNSP")
  listNSP is ArmResourceListByParent<NetworkSecurityPerimeterConfiguration>;

  /**
   * Reconcile network security perimeter configuration for Workspace resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Workspaces_ReconcileNSP")
  @action("reconcile")
  reconcileNSP is ArmResourceActionAsyncBase<
    NetworkSecurityPerimeterConfiguration,
    void,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<NetworkSecurityPerimeterConfiguration>
  >;
}

@@maxLength(NetworkSecurityPerimeterConfiguration.name, 512);
@@minLength(NetworkSecurityPerimeterConfiguration.name, 1);
@@doc(NetworkSecurityPerimeterConfiguration.name,
  "The name for a network security perimeter configuration"
);
@@doc(NetworkSecurityPerimeterConfiguration.properties,
  "Network security configuration properties."
);
