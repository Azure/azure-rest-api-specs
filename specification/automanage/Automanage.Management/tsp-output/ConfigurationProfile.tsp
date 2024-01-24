import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automanage;
/**
 * Definition of the configuration profile.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(
  ConfigurationProfileProperties
)
@includeInapplicableMetadataInPayload(false)
model ConfigurationProfile extends TrackedResourceBase {
  /**
   * The configuration profile name.
   */
  @path
  @key("configurationProfileName")
  @segment("configurationProfiles")
  name: string;

  /**
   * Properties of the configuration profile.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ConfigurationProfileProperties;
}

@armResourceOperations
interface ConfigurationProfiles {
  /**
   * Get information about a configuration profile
   */
  get is ArmResourceRead<ConfigurationProfile>;

  /**
   * Creates a configuration profile
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<ConfigurationProfile>;

  /**
   * Updates a configuration profile
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<
    ConfigurationProfile,
    ConfigurationProfileUpdate
  >;

  /**
   * Delete a configuration profile
   */
  delete is ArmResourceDeleteSync<ConfigurationProfile>;

  /**
   * Retrieve a list of configuration profile within a given resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConfigurationProfiles_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<ConfigurationProfile>;

  /**
   * Retrieve a list of configuration profile within a subscription
   */
  listBySubscription is ArmListBySubscription<ConfigurationProfile>;
}

@@projectedName(ConfigurationProfiles.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ConfigurationProfiles.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ConfigurationProfiles.createOrUpdate::parameters.resource,
  "Parameters supplied to create or update configuration profile."
);
@@projectedName(ConfigurationProfiles.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(ConfigurationProfiles.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(ConfigurationProfiles.update::parameters.properties,
  "Parameters supplied to update configuration profile."
);
