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
model SourceControlConfiguration
  is ProxyResource<SourceControlConfigurationProperties> {
  /**
   * Name of the Source Control Configuration.
   */
  @path
  @key("sourceControlConfigurationName")
  @segment("sourceControlConfigurations")
  @visibility("read")
  @pattern("/^[a-zA-Z0-9-]{3,24}$/")
  name: string;
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
  delete is ArmResourceDeleteWithoutOkAsync<SourceControlConfiguration>;

  /**
   * List all Source Control Configurations.
   */
  list is ArmResourceListByParent<SourceControlConfiguration>;
}

@@doc(SourceControlConfigurations.createOrUpdate::parameters.resource,
  "Properties necessary to Create KubernetesConfiguration."
);
