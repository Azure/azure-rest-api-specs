import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DynatraceMonitor.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Dynatrace;
@doc("Single sign-on configurations for a given monitor resource.")
@parentResource(DynatraceMonitor)
model DynatraceSingleSignOn is ProxyResource<DynatraceSingleSignOnProperties> {
  @doc("Single Sign On Configuration Name")
  @path
  @key("configurationName")
  @segment("singleSignOnConfigurations")
  name: string;
}

@armResourceOperations
interface DynatraceSingleSignOns {
  @doc("Get a DynatraceSingleSignOnResource")
  get is ArmResourceRead<DynatraceSingleSignOn>;
  @doc("Create a DynatraceSingleSignOnResource")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DynatraceSingleSignOn>;
  @doc("List all DynatraceSingleSignOnResource by monitorName")
  list is ArmResourceListByParent<DynatraceSingleSignOn>;
}
