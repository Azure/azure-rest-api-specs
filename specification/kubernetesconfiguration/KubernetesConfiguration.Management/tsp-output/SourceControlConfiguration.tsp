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
 * The SourceControl Configuration object returned in Get & Put response.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(
  SourceControlConfigurationProperties
)
@includeInapplicableMetadataInPayload(false)
model SourceControlConfiguration extends ProxyResourceBase {
  /**
   * Name of the Source Control Configuration.
   */
  @path
  @key("sourceControlConfigurationName")
  @segment("sourceControlConfigurations")
  name: string;

  /**
   * Properties to create a Source Control Configuration resource
   */
  @extension("x-ms-client-flatten", true)
  properties?: SourceControlConfigurationProperties;
}

@armResourceOperations
interface SourceControlConfigurations {
  /**
   * Gets details of the Source Control Configuration.
   */
  get is ArmResourceRead<SourceControlConfiguration>;

  /**
   * Create a new Kubernetes Source Control Configuration.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<SourceControlConfiguration>;

  /**
   * This will delete the YAML file used to set up the Source control configuration, thus stopping future sync from the source repo.
   */
  delete is ArmResourceDeleteAsync<SourceControlConfiguration>;

  /**
   * List all Source Control Configurations.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SourceControlConfigurations_List")
  list is ArmResourceListByParent<SourceControlConfiguration>;
}

@@projectedName(SourceControlConfigurations.createOrUpdate::parameters.resource,
  "json",
  "sourceControlConfiguration"
);
@@extension(SourceControlConfigurations.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "sourceControlConfiguration"
);
@@doc(SourceControlConfigurations.createOrUpdate::parameters.resource,
  "Properties necessary to Create KubernetesConfiguration."
);
