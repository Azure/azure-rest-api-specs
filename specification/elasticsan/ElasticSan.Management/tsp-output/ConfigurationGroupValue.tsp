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

namespace Microsoft.HybridNetwork;
@doc("Hybrid configuration group value resource.")
model ConfigurationGroupValue
  is TrackedResource<ConfigurationGroupValuePropertiesFormat> {
  @doc("The name of the configuration group value.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("configurationGroupValueName")
  @segment("configurationGroupValues")
  name: string;
}

@armResourceOperations
interface ConfigurationGroupValues {
  @doc("Gets information about the specified hybrid configuration group values.")
  get is ArmResourceRead<ConfigurationGroupValue>;

  @doc("Creates or updates a hybrid configuration group value.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    ConfigurationGroupValue,
    BaseParameters<ConfigurationGroupValue>,
    ArmAsyncOperationHeader
  >;

  @doc("Updates a hybrid configuration group tags.")
  updateTags is ArmCustomPatchSync<ConfigurationGroupValue, TagsObject>;

  @doc("Deletes the specified hybrid configuration group value.")
  delete is ArmResourceDeleteWithoutOkAsync<
    ConfigurationGroupValue,
    BaseParameters<ConfigurationGroupValue>,
    ArmLroLocationHeader
  >;

  @doc("Lists all the hybrid network configurationGroupValues in a resource group.")
  listByResourceGroup is ArmResourceListByParent<ConfigurationGroupValue>;

  @doc("Lists all sites in the configuration group value in a subscription.")
  listBySubscription is ArmListBySubscription<ConfigurationGroupValue>;
}

@@projectedName(ConfigurationGroupValues.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ConfigurationGroupValues.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ConfigurationGroupValues.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update configuration group value resource."
);
@@projectedName(ConfigurationGroupValues.updateTags::parameters.properties,
  "json",
  "parameters"
);
@@extension(ConfigurationGroupValues.updateTags::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(ConfigurationGroupValues.updateTags::parameters.properties,
  "Parameters supplied to update configuration group values tags."
);
