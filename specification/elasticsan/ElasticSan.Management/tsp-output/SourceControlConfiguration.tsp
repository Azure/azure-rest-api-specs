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
@doc("The SourceControl Configuration object returned in Get & Put response.")
model SourceControlConfiguration
  is ProxyResource<SourceControlConfigurationProperties> {
  @doc("Name of the Source Control Configuration.")
  @path
  @key("sourceControlConfigurationName")
  @segment("sourceControlConfigurations")
  name: string;
}

@armResourceOperations
interface SourceControlConfigurations {
  @doc("Gets details of the Source Control Configuration.")
  get is ArmResourceRead<SourceControlConfiguration>;

  @doc("Create a new Kubernetes Source Control Configuration.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SourceControlConfiguration>;

  @doc("This will delete the YAML file used to set up the Source control configuration, thus stopping future sync from the source repo.")
  delete is ArmResourceDeleteAsync<SourceControlConfiguration>;

  @doc("List all Source Control Configurations.")
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
