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
 * Defines the routing configuration
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(NetworkManager)
@Http.Private.includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model NetworkManagerRoutingConfiguration extends ChildResource {
  properties?: NetworkManagerRoutingConfigurationPropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("configurationName")
  @segment("routingConfigurations")
  @pattern("^[a-zA-Z0-9_.-]*$")
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
interface NetworkManagerRoutingConfigurations {
  /**
   * Retrieves a network manager routing configuration.
   */
  get is ArmResourceRead<
    NetworkManagerRoutingConfiguration,
    Error = CloudError
  >;

  /**
   * Creates or updates a network manager routing configuration.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    NetworkManagerRoutingConfiguration,
    Error = CloudError
  >;

  /**
   * Deletes a network manager routing configuration.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    NetworkManagerRoutingConfiguration,
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
   * Lists all the network manager routing configurations in a network manager, in a paginated format.
   */
  list is ArmResourceListByParent<
    NetworkManagerRoutingConfiguration,
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

@@doc(NetworkManagerRoutingConfiguration.name,
  "The name of the network manager Routing Configuration."
);
@@doc(NetworkManagerRoutingConfiguration.properties,
  "Indicates the properties for the network manager routing configuration."
);
@@doc(NetworkManagerRoutingConfigurations.createOrUpdate::parameters.resource,
  "The routing configuration to create or update"
);
