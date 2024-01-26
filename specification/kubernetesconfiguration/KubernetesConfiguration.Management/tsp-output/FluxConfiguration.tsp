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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(FluxConfigurationProperties)
model FluxConfiguration extends ProxyResourceBase {
  /**
   * Name of the Flux Configuration.
   */
  @path
  @key("fluxConfigurationName")
  @segment("fluxConfigurations")
  @visibility("read")
  name: string;

  /**
   * Properties to create a Flux Configuration resource
   */
  @extension("x-ms-client-flatten", true)
  properties?: FluxConfigurationProperties;
}

@armResourceOperations
interface FluxConfigurations {
  /**
   * Gets details of the Flux Configuration.
   */
  get is ArmResourceRead<FluxConfiguration>;

  /**
   * Create a new Kubernetes Flux Configuration.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    FluxConfiguration,
    BaseParameters<FluxConfiguration>,
    ArmAsyncOperationHeader
  >;

  /**
   * Update an existing Kubernetes Flux Configuration.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    FluxConfiguration,
    FluxConfigurationPatch,
    BaseParameters<FluxConfiguration>,
    ArmAsyncOperationHeader
  >;

  /**
   * This will delete the YAML file used to set up the Flux Configuration, thus stopping future sync from the source repo.
   */
  delete is ArmResourceDeleteAsync<
    FluxConfiguration,
    {
      ...BaseParameters<FluxConfiguration>;

      /**
       * Delete the extension resource in Azure - not the normal asynchronous delete.
       */
      @query("forceDelete")
      forceDelete?: boolean;
    },
    ArmAsyncOperationHeader
  >;

  /**
   * List all Flux Configurations.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FluxConfigurations_List")
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
