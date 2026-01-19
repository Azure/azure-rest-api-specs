import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
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
  is Azure.ResourceManager.NspConfiguration;

alias NspConfigurationOperations = Azure.ResourceManager.NspConfigurations<NetworkSecurityPerimeterConfiguration>;

@armResourceOperations
@tag("NetworkSecurityPerimeter")
interface NetworkSecurityPerimeterConfigurations {
  /**
   * Gets information about the specified NSP configuration.
   */
  getConfiguration is NspConfigurationOperations.Read<
    ParentResource = BatchAccount,
    Resource = NetworkSecurityPerimeterConfiguration,
    Response = CommonTypes.NetworkSecurityPerimeterConfiguration,
    Error = CloudError
  >;

  /**
   * Lists all of the NSP configurations in the specified account.
   */
  @list
  listConfigurations is NspConfigurationOperations.ListByParent<
    ParentResource = BatchAccount,
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
    ParentResource = BatchAccount,
    Resource = NetworkSecurityPerimeterConfiguration,
    Response = ArmAcceptedLroResponse
  >;
}

@@doc(NetworkSecurityPerimeterConfiguration.properties,
  "Network security configuration properties."
);
@@pageItems(CommonTypes.NetworkSecurityPerimeterConfigurationListResult.value);
@@nextLink(CommonTypes.NetworkSecurityPerimeterConfigurationListResult.nextLink
);
