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
@doc("Definition of the configuration profile.")
model ConfigurationProfile is TrackedResource<ConfigurationProfileProperties> {
  @doc("The configuration profile name.")
  @path
  @key("configurationProfileName")
  @segment("configurationProfiles")
  name: string;
}

@armResourceOperations
interface ConfigurationProfiles {
  @doc("Get information about a configuration profile")
  get is ArmResourceRead<ConfigurationProfile>;

  @doc("Creates a configuration profile")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ConfigurationProfile>;

  @doc("Updates a configuration profile")
  update is ArmCustomPatchSync<
    ConfigurationProfile,
    ConfigurationProfileUpdate
  >;

  @doc("Delete a configuration profile")
  delete is ArmResourceDeleteSync<ConfigurationProfile>;

  @doc("Retrieve a list of configuration profile within a given resource group")
  listByResourceGroup is ArmResourceListByParent<ConfigurationProfile>;

  @doc("Retrieve a list of configuration profile within a subscription")
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
