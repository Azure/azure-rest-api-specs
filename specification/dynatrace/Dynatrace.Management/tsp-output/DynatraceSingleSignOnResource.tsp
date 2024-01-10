import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./MonitorResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Dynatrace.Observability;
@doc("Single sign-on configurations for a given monitor resource.")
@parentResource(MonitorResource)
model DynatraceSingleSignOnResource
  is ProxyResource<DynatraceSingleSignOnProperties> {
  @doc("Single Sign On Configuration Name")
  @key("configurationName")
  @segment("singleSignOnConfigurations")
  name: string;
}

@armResourceOperations
@projectedName("client", "SingleSignOn")
interface DynatraceSingleSignOnResources_SingleSignOn {
  @doc("Get a DynatraceSingleSignOnResource")
  get is ArmResourceRead<DynatraceSingleSignOnResource>;

  @doc("Create a DynatraceSingleSignOnResource")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DynatraceSingleSignOnResource>;

  @doc("List all DynatraceSingleSignOnResource by monitorName")
  list is ArmResourceListByParent<DynatraceSingleSignOnResource>;
}
