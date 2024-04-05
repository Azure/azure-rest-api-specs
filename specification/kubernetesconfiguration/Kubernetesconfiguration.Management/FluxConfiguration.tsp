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
/**
 * The Flux Configuration object returned in Get & Put response.
 */
model FluxConfiguration is ProxyResource<FluxConfigurationProperties> {
  /**
   * Name of the Flux Configuration.
   */
  @path
  @key("fluxConfigurationName")
  @segment("fluxConfigurations")
  @visibility("read")
  @pattern("[^]*")
  name: string;
}

@armResourceOperations
interface FluxConfigurations {
  /**
   * Gets details of the Flux Configuration.
   */
  get is ArmResourceRead<
    FluxConfiguration,
    BaseParameters = CustomBaseParameters<FluxConfiguration>
  >;

  /**
   * Create a new Kubernetes Flux Configuration.
   */
  create is ArmResourceCreateOrReplaceAsync<
    FluxConfiguration,
    BaseParameters = CustomBaseParameters<FluxConfiguration>
  >;

  /**
   * Update an existing Kubernetes Flux Configuration.
   */
  @parameterVisibility("read")
  update is ArmResourcePatchSync<
    FluxConfiguration,
    FluxConfigurationPatch,
    BaseParameters = CustomBaseParameters<FluxConfiguration>
  >;

  /**
   * This will delete the YAML file used to set up the Flux Configuration, thus stopping future sync from the source repo.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    FluxConfiguration,
    {
      ...CustomBaseParameters<FluxConfiguration>;

      /**
       * Delete the extension resource in Azure - not the normal asynchronous delete.
       */
      @query("forceDelete")
      forceDelete?: boolean;
    }
  >;

  /**
   * List all Flux Configurations.
   */
  list is ArmResourceListByParent<
    FluxConfiguration,
    BaseParameters = CustomBaseParameters<FluxConfiguration>
  >;

  /**
   * Get Async Operation status
   */
  operationStatus is ArmResourceRead<
    FluxConfiguration,
    BaseParameters = CustomBaseParameters<FluxConfiguration>,
    Parameters = OperationsParameter,
    Response = ArmOperationStatus
  >;
}

@@doc(FluxConfigurations.create::parameters.resource,
  "Properties necessary to Create a FluxConfiguration."
);

@@doc(FluxConfigurations.update::parameters.properties,
  "Properties to Patch in an existing Flux Configuration."
);
