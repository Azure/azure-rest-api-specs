import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

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

alias NSPOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Legacy.Provider;

    /**
     * The name of the workspace.
     */
    @path
    @segment("workspaces")
    @key("workspaceName")
    @minLength(4)
    @maxLength(63)
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
    workspaceName: string;
  },
  {
    /**
     * The name for a network security perimeter configuration
     */
    @path
    @segment("networkSecurityPerimeterConfigurations")
    @key("networkSecurityPerimeterConfigurationName")
    @minLength(1)
    @maxLength(512)
    @pattern("^.*$")
    networkSecurityPerimeterConfigurationName: string;
  }
>;

@armResourceOperations
interface NetworkSecurityPerimeterConfigurations {
  /**
   * Gets a network security perimeter configuration.
   */
  @tag("NetworkSecurityPerimeterConfigurations")
  getNSP is NSPOps.Read<
    NetworkSecurityPerimeterConfiguration,
    Response = ArmResponse<CommonTypes.NetworkSecurityPerimeterConfiguration>
  >;

  /**
   * Gets a list of NSP configurations for specified workspace.
   */
  @tag("NetworkSecurityPerimeterConfigurations")
  listNSP is NSPOps.List<
    NetworkSecurityPerimeterConfiguration,
    Response = CommonTypes.NetworkSecurityPerimeterConfigurationListResult
  >;

  /**
   * Reconcile network security perimeter configuration for Workspace resource.
   */
  @action("reconcile")
  @tag("NetworkSecurityPerimeterConfigurations")
  reconcileNSP is NSPOps.ActionAsync<
    NetworkSecurityPerimeterConfiguration,
    void,
    void,
    Response = ArmAcceptedLroResponse
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
@@pageItems(CommonTypes.NetworkSecurityPerimeterConfigurationListResult.value);
@@nextLink(CommonTypes.NetworkSecurityPerimeterConfigurationListResult.nextLink
);
