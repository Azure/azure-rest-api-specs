import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DatadogMonitorResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Datadog;

@parentResource(DatadogMonitorResource)
model DatadogSingleSignOnResource
  is ProxyResource<DatadogSingleSignOnProperties> {
  @doc("Configuration name")
  @key("configurationName")
  @segment("singleSignOnConfigurations")
  name: string;
}

@armResourceOperations
interface SingleSignOnConfigurations {
  @doc("Gets the datadog single sign-on resource for the given Monitor.")
  get is ArmResourceRead<DatadogSingleSignOnResource>;
  @doc("Configures single-sign-on for this resource.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DatadogSingleSignOnResource>;
  @doc("List the single sign-on configurations for a given monitor resource.")
  list is ArmResourceListByParent<DatadogSingleSignOnResource>;
}
