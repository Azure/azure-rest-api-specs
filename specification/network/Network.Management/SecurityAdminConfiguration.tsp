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
@parentResource(NetworkManager)
model SecurityAdminConfiguration
  is Azure.ResourceManager.ProxyResource<SecurityAdminConfigurationPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = SecurityAdminConfiguration,
    KeyName = "configurationName",
    SegmentName = "securityAdminConfigurations",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface SecurityAdminConfigurations {
  /**
   * Retrieves a network manager security admin configuration.
   */
  get is ArmResourceRead<SecurityAdminConfiguration>;

  /**
   * Creates or updates a network manager security admin configuration.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<SecurityAdminConfiguration>;

  /**
   * Deletes a network manager security admin configuration.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    SecurityAdminConfiguration,
    Parameters = {
      /**
       * Deletes the resource even if it is part of a deployed configuration. If the configuration has been deployed, the service will do a cleanup deployment in the background, prior to the delete.
       */
      @query("force")
      force?: boolean;
    },
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
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
    }
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
