import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./NginxDeployment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Nginx.NginxPlus;

@parentResource(NginxDeployment)
model NginxConfiguration is TrackedResource<NginxConfigurationProperties> {
  @doc("The name of configuration, only 'default' is supported value due to the singleton of Nginx conf")
  @path
  @key("configurationName")
  @segment("configurations")
  name: string;
}

@armResourceOperations
interface NginxConfigurations {
  @doc("Get the Nginx configuration of given Nginx deployment")
  get is ArmResourceRead<NginxConfiguration>;
  @doc("Create or update the Nginx configuration for given Nginx deployment")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<NginxConfiguration>;
  @doc("Reset the Nginx configuration of given Nginx deployment to default")
  delete is ArmResourceDeleteAsync<NginxConfiguration>;
  @doc("List the Nginx configuration of given Nginx deployment.")
  list is ArmResourceListByParent<NginxConfiguration>;
}
