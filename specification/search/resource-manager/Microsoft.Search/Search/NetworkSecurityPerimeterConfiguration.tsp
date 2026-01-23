import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SearchService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Search;
/**
 * Network security perimeter (NSP) configuration resource
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NetworkSecurityPerimeterConfiguration
  is CommonTypes.NspConfigurationResource<KeyName = "nspConfigName">;
alias NetworkSecurityPerimeterConfigurationOperations = NspConfigurations<
  NetworkSecurityPerimeterConfiguration,
  NspConfigurationKeyName = "nspConfigName"
>;

@armResourceOperations
interface NetworkSecurityPerimeterConfigurationsOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /**
         * The name of the Azure AI Search service associated with the specified resource group.
         */
        @path
        @segment("searchServices")
        @pattern("^(?=.{2,60}$)[a-z0-9][a-z0-9]+(-[a-z0-9]+)*$")
        searchServiceName: string,
      },
      {
        /**
         * The network security perimeter configuration name.
         */
        @path
        @segment("networkSecurityPerimeterConfigurations")
        @minLength(38)
        @maxLength(100)
        @pattern("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}\\.[a-z][a-z0-9]*$")
        nspConfigName: string,
      }
    > {}

@armResourceOperations
interface NetworkSecurityPerimeterConfigurations {
  /**
   * Gets a network security perimeter configuration.
   */
  get is NetworkSecurityPerimeterConfigurationOperations.Read<
    SearchService,
    Error = CloudError
  >;

  /**
   * Gets a list of network security perimeter configurations for a search service.
   */
  listByService is NetworkSecurityPerimeterConfigurationOperations.ListByParent<
    SearchService,
    Error = CloudError
  >;

  /**
   * Reconcile network security perimeter configuration for the Azure AI Search resource provider. This triggers a manual resync with network security perimeter configurations by ensuring the search service carries the latest configuration.
   */
  reconcile is NetworkSecurityPerimeterConfigurationOperations.Action<
    SearchService,
    void,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader>,
    Error = CloudError
  >;
}

@@doc(NetworkSecurityPerimeterConfiguration.properties,
  "Network security configuration properties."
);
