import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automanage;
/**
 * Definition of the configuration profile.
 */
model ConfigurationProfile
  is Azure.ResourceManager.TrackedResource<ConfigurationProfileProperties> {
  ...ResourceNameParameter<
    Resource = ConfigurationProfile,
    KeyName = "configurationProfileName",
    SegmentName = "configurationProfiles",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ConfigurationProfileBySubScriptionOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      {
        /** The configuration profile name. */
        @path
        @segment("configurationProfiles")
        @key
        configurationProfileName: string,
      }
    > {}

@armResourceOperations
interface ConfigurationProfileOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      {
        /** The configuration profile name. */
        @path
        @segment("configurationProfiles")
        @key
        configurationProfileName: string,
      }
    > {}

@armResourceOperations
interface ConfigurationProfiles {
  /**
   * Get information about a configuration profile
   */
  get is ConfigurationProfileOps.Read<ConfigurationProfile>;

  /**
   * Creates a configuration profile
   */
  createOrUpdate is ConfigurationProfileOps.CreateOrUpdateSync<ConfigurationProfile>;

  /**
   * Updates a configuration profile
   */
  @patch(#{ implicitOptionality: false })
  update is ConfigurationProfileOps.CustomPatchSync<
    ConfigurationProfile,
    PatchModel = ConfigurationProfileUpdate
  >;

  /**
   * Delete a configuration profile
   */
  delete is ConfigurationProfileOps.DeleteSync<ConfigurationProfile>;

  /**
   * Retrieve a list of configuration profile within a subscription
   */
  listBySubscription is ConfigurationProfileBySubScriptionOps.List<
    ConfigurationProfile,
    Response = ArmResponse<ConfigurationProfileList>
  >;

  /**
   * Retrieve a list of configuration profile within a resource group
   */
  listByResourceGroup is ConfigurationProfileOps.List<
    ConfigurationProfile,
    Response = ArmResponse<ConfigurationProfileList>
  >;
}
@armResourceOperations
interface ConfigurationProfilesVersionOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The configuration profile name. */
        @path
        @segment("configurationProfiles")
        @key
        configurationProfileName: string,
      },
      {
        /** The configuration profile version name. */
        @path
        @segment("versions")
        @key
        versionName: string,
      }
    > {}

@armResourceOperations
interface ConfigurationProfilesVersions {
  /**
   * Get information about a configuration profile version
   */
  get is ConfigurationProfilesVersionOps.Read<ConfigurationProfile>;

  /**
   * Creates a configuration profile version
   */
  createOrUpdate is ConfigurationProfilesVersionOps.CreateOrUpdateSync<ConfigurationProfile>;

  /**
   * Delete a configuration profile version
   */
  delete is ConfigurationProfilesVersionOps.DeleteSync<ConfigurationProfile>;

  /**
   * Retrieve a list of configuration profile within a given resource group
   */
  listByResourceGroup is ConfigurationProfilesVersionOps.List<
    ConfigurationProfile,
    Response = ArmResponse<ConfigurationProfileList>
  >;
}

@@doc(ConfigurationProfile.name, "The configuration profile name.");
@@doc(ConfigurationProfile.properties,
  "Properties of the configuration profile."
);
@@doc(ConfigurationProfiles.createOrUpdate::parameters.resource,
  "Parameters supplied to create or update configuration profile."
);
@@doc(ConfigurationProfiles.update::parameters.properties,
  "Parameters supplied to update configuration profile."
);
@@doc(ConfigurationProfilesVersions.createOrUpdate::parameters.resource,
  "Parameters supplied to create or update configuration profile."
);
