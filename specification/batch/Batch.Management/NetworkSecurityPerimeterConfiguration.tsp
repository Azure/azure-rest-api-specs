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
using TypeSpec.Versioning;

namespace Microsoft.Batch;
/**
 * Network security perimeter (NSP) configuration resource
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(BatchAccount)
model NetworkSecurityPerimeterConfiguration
  is Azure.ResourceManager.NspConfiguration;

alias NspConfigurationOperations = Azure.ResourceManager.NspConfigurations<NetworkSecurityPerimeterConfiguration>;

@armResourceOperations
interface NetworkSecurityPerimeterConfigurations {
  /**
   * Gets information about the specified NSP configuration.
   */
  getConfiguration is NspConfigurationOperations.Read<
    ParentResource = BatchAccount,
    Resource = NetworkSecurityPerimeterConfiguration,
    Response = CommonTypes.NetworkSecurityPerimeterConfiguration,
    Error = ErrorResponse
  >;

  /**
   * Lists all of the NSP configurations in the specified account.
   */
  @list
  listConfigurations is NspConfigurationOperations.ListByParent<
    ParentResource = BatchAccount,
    Resource = NetworkSecurityPerimeterConfiguration,
    Response = CommonTypes.NetworkSecurityPerimeterConfigurationListResult
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

@@pageItems(CommonTypes.NetworkSecurityPerimeterConfigurationListResult.value);
@@nextLink(CommonTypes.NetworkSecurityPerimeterConfigurationListResult.nextLink
);
