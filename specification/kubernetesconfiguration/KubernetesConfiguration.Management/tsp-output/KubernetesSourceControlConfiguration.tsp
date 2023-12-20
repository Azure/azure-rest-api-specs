import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.KubernetesConfiguration;
@doc("The SourceControl Configuration object returned in Get & Put response.")
model KubernetesSourceControlConfiguration
  is ProxyResource<SourceControlConfigurationProperties> {
  @doc("Name of the Source Control Configuration.")
  @path
  @key("sourceControlConfigurationName")
  @segment("sourceControlConfigurations")
  name: string;
}

@armResourceOperations
interface KubernetesSourceControlConfigurations {
  @doc("Gets details of the Source Control Configuration.")
  get is ArmResourceRead<KubernetesSourceControlConfiguration>;
  @doc("Create a new Kubernetes Source Control Configuration.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<KubernetesSourceControlConfiguration>;
  @doc("This will delete the YAML file used to set up the Source control configuration, thus stopping future sync from the source repo.")
  delete is ArmResourceDeleteAsync<KubernetesSourceControlConfiguration>;
  @doc("List all Source Control Configurations.")
  list is ArmResourceListByParent<KubernetesSourceControlConfiguration>;
}
