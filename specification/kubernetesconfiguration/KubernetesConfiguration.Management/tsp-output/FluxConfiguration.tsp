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

namespace Microsoft.KubernetesConfiguration;
@doc("The Flux Configuration object returned in Get & Put response.")
model FluxConfiguration is ProxyResource<FluxConfigurationProperties> {
  @doc("Name of the Flux Configuration.")
  @path
  @key("fluxConfigurationName")
  @segment("fluxConfigurations")
  name: string;
}

@armResourceOperations
interface FluxConfigurations {
  @doc("Gets details of the Flux Configuration.")
  get is ArmResourceRead<FluxConfiguration>;

  @doc("Create a new Kubernetes Flux Configuration.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    FluxConfiguration,
    BaseParameters<FluxConfiguration>,
    ArmAsyncOperationHeader
  >;

  @doc("Update an existing Kubernetes Flux Configuration.")
  update is ArmCustomPatchAsync<
    FluxConfiguration,
    FluxConfigurationPatch,
    BaseParameters<FluxConfiguration>,
    ArmAsyncOperationHeader
  >;

  @doc("This will delete the YAML file used to set up the Flux Configuration, thus stopping future sync from the source repo.")
  delete is ArmResourceDeleteAsync<
    FluxConfiguration,
    {
      ...BaseParameters<FluxConfiguration>;

      @doc("Delete the extension resource in Azure - not the normal asynchronous delete.")
      @query("forceDelete")
      forceDelete?: boolean;
    },
    ArmAsyncOperationHeader
  >;

  @doc("List all Flux Configurations.")
  list is ArmResourceListByParent<FluxConfiguration>;
}

@@projectedName(FluxConfigurations.createOrUpdate::parameters.resource,
  "json",
  "fluxConfiguration"
);
@@extension(FluxConfigurations.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "fluxConfiguration"
);
@@doc(FluxConfigurations.createOrUpdate::parameters.resource,
  "Properties necessary to Create a FluxConfiguration."
);
@@projectedName(FluxConfigurations.update::parameters.properties,
  "json",
  "fluxConfigurationPatch"
);
@@extension(FluxConfigurations.update::parameters.properties,
  "x-ms-client-name",
  "fluxConfigurationPatch"
);
@@doc(FluxConfigurations.update::parameters.properties,
  "Properties to Patch in an existing Flux Configuration."
);
