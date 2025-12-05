import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BatchAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Batch;
/**
 * Network security perimeter (NSP) configuration resource
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(BatchAccount)
model NetworkSecurityPerimeterConfiguration extends AzureProxyResource {}

alias NetworkSecurityPerimeterConfigurationOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the Batch account. */
    @path
    @segment("batchAccounts")
    @key
    @pattern("^[a-zA-Z0-9]+$")
    @maxLength(24)
    @minLength(3)
    accountName: string;
  },
  {
    /** The name for Network Security Perimeter configuration */
    @path
    @segment("networkSecurityPerimeterConfigurations")
    @key
    @pattern("^.*$")
    networkSecurityPerimeterConfigurationName: string;
  },
  ErrorType = CloudError
>;

@armResourceOperations
interface NetworkSecurityPerimeterConfigurations {
  /**
   * Gets information about the specified NSP configuration.
   */
  getConfiguration is NetworkSecurityPerimeterConfigurationOps.Read<
    NetworkSecurityPerimeterConfiguration,
    Response = CommonTypes.NetworkSecurityPerimeterConfiguration
  >;

  /**
   * Lists all of the NSP configurations in the specified account.
   */
  @list
  listConfigurations is NetworkSecurityPerimeterConfigurationOps.List<
    NetworkSecurityPerimeterConfiguration,
    Response = CommonTypes.NetworkSecurityPerimeterConfigurationListResult
  >;

  /**
   * Reconciles the specified NSP configuration.
   */
  @action("reconcile")
  reconcileConfiguration is NetworkSecurityPerimeterConfigurationOps.ActionAsync<
    NetworkSecurityPerimeterConfiguration,
    void,
    void,
    Response = ArmAcceptedLroResponse,
    OverrideErrorType = ErrorResponse
  >;
}

@@pageItems(CommonTypes.NetworkSecurityPerimeterConfigurationListResult.value);
@@nextLink(CommonTypes.NetworkSecurityPerimeterConfigurationListResult.nextLink
);
