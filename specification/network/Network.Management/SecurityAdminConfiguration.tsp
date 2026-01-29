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
 * Defines the security admin configuration
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(NetworkManager)
@Http.Private.includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model SecurityAdminConfiguration extends ChildResource {
  properties?: SecurityAdminConfigurationPropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("configurationName")
  @segment("securityAdminConfigurations")
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
interface SecurityAdminConfigurations {
  /**
   * Retrieves a network manager security admin configuration.
   */
  get is ArmResourceRead<
    SecurityAdminConfiguration,
    Error = CommonErrorResponse
  >;

  /**
   * Creates or updates a network manager security admin configuration.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    SecurityAdminConfiguration,
    Error = CommonErrorResponse
  >;

  /**
   * Deletes a network manager security admin configuration.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    SecurityAdminConfiguration,
    Parameters = {
      /**
       * Deletes the resource even if it is part of a deployed configuration. If the configuration has been deployed, the service will do a cleanup deployment in the background, prior to the delete.
       */
      @query("force")
      force?: boolean;
    },
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CommonErrorResponse
  >;

  /**
   * Lists all the network manager security admin configurations in a network manager, in a paginated format.
   */
  list is ArmResourceListByParent<
    SecurityAdminConfiguration,
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
    Error = CommonErrorResponse
  >;
}

@@doc(SecurityAdminConfiguration.name,
  "The name of the network manager Security Configuration."
);
@@doc(SecurityAdminConfiguration.properties,
  "Indicates the properties for the network manager security admin configuration."
);
@@doc(SecurityAdminConfigurations.createOrUpdate::parameters.resource,
  "The security admin configuration to create or update"
);
