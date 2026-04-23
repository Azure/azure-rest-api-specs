import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Vault.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.KeyVault;
/**
 * Network security perimeter (NSP) configuration resource
 */
@parentResource(Vault)
model NetworkSecurityPerimeterConfiguration
  is Azure.ResourceManager.NspConfiguration;

alias NspConfigurationOperations = Azure.ResourceManager.NspConfigurations<NetworkSecurityPerimeterConfiguration>;

@armResourceOperations
@tag("NetworkSecurityPerimeterConfigurations")
@added(Versions.v2026_04_01)
interface NetworkSecurityPerimeterConfigurations {
  /**
   * Gets information about the specified NSP configuration.
   */
  getConfiguration is NspConfigurationOperations.Read<
    ParentResource = Vault,
    Resource = NetworkSecurityPerimeterConfiguration,
    Response = CommonTypes.NetworkSecurityPerimeterConfiguration,
    Error = CloudError
  >;

  /**
   * Lists all of the NSP configurations in the specified account.
   */
  @list
  listConfigurations is NspConfigurationOperations.ListByParent<
    ParentResource = Vault,
    Resource = NetworkSecurityPerimeterConfiguration,
    Response = CommonTypes.NetworkSecurityPerimeterConfigurationListResult,
    Error = CloudError
  >;

  /**
   * Reconciles the specified NSP configuration.
   */
  @post
  @action("reconcile")
  reconcileConfiguration is NspConfigurationOperations.Read<
    ParentResource = Vault,
    Resource = NetworkSecurityPerimeterConfiguration,
    Response = ArmNoContentResponse
  >;
}

@@doc(NetworkSecurityPerimeterConfiguration.properties,
  "Network security configuration properties."
);
@@pageItems(CommonTypes.NetworkSecurityPerimeterConfigurationListResult.value);
@@nextLink(CommonTypes.NetworkSecurityPerimeterConfigurationListResult.nextLink
);
