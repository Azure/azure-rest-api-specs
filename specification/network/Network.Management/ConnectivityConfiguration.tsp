import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkManager.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * The network manager connectivity configuration resource
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(NetworkManager)
@Http.Private.includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model ConnectivityConfiguration extends ChildResource {
  properties?: ConnectivityConfigurationProperties;

  @visibility(Lifecycle.Read)
  @path
  @key("configurationName")
  @segment("connectivityConfigurations")
  name: string;

  /**
   * The system metadata related to this resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: Azure.ResourceManager.Foundations.SystemData;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
@armResourceOperations
interface ConnectivityConfigurations {
  /**
   * Gets a Network Connectivity Configuration, specified by the resource group, network manager name, and connectivity Configuration name
   */
  get is ArmResourceRead<ConnectivityConfiguration, Error = CloudError>;

  /**
   * Creates/Updates a new network manager connectivity configuration
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ConnectivityConfiguration,
    Error = CloudError
  >;

  /**
   * Deletes a network manager connectivity configuration, specified by the resource group, network manager name, and connectivity configuration name
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    ConnectivityConfiguration,
    Parameters = {
      /**
       * Deletes the resource even if it is part of a deployed configuration. If the configuration has been deployed, the service will do a cleanup deployment in the background, prior to the delete.
       */
      @query("force")
      force?: boolean;
    },
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists all the network manager connectivity configuration in a specified network manager.
   */
  list is ArmResourceListByParent<
    ConnectivityConfiguration,
    Parameters = {
      /**
       * An optional query parameter which specifies the maximum number of records to be returned by the server.
       */
      @maxValue(20)
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * SkipToken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Error = CloudError
  >;
}

@@doc(ConnectivityConfiguration.name,
  "The name of the network manager connectivity configuration."
);
@@doc(ConnectivityConfiguration.properties,
  "Properties of a network manager connectivity configuration"
);
@@doc(ConnectivityConfigurations.createOrUpdate::parameters.resource,
  "Parameters supplied to create/update a network manager connectivity configuration"
);
