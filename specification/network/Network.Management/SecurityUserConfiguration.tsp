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
 * Defines the security user configuration
 */
@parentResource(NetworkManager)
model SecurityUserConfiguration
  is Azure.ResourceManager.ProxyResource<SecurityUserConfigurationPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = SecurityUserConfiguration,
    KeyName = "configurationName",
    SegmentName = "securityUserConfigurations",
    NamePattern = "^[a-zA-Z0-9_.-]*$"
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface SecurityUserConfigurations {
  /**
   * Retrieves a network manager security user configuration.
   */
  get is ArmResourceRead<SecurityUserConfiguration>;

  /**
   * Creates or updates a network manager security user configuration.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<SecurityUserConfiguration>;

  /**
   * Deletes a network manager security user configuration.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    SecurityUserConfiguration,
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
   * Lists all the network manager security user configurations in a network manager, in a paginated format.
   */
  list is ArmResourceListByParent<
    SecurityUserConfiguration,
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

@@doc(SecurityUserConfiguration.name,
  "The name of the network manager Security Configuration."
);
@@doc(SecurityUserConfiguration.properties,
  "Indicates the properties for the network manager security user configuration."
);
@@doc(SecurityUserConfigurations.createOrUpdate::parameters.resource,
  "The security user configuration to create or update"
);
