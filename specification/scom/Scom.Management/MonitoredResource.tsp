import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Scom;
@doc("A monitored resource.")
@parentResource(ManagedInstance)
model MonitoredResource is ProxyResource<MonitoredResourceProperties> {
  @doc("The monitored resource name.")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
  @path
  @key("monitoredResourceName")
  @segment("monitoredResources")
  name: string;
}

@armResourceOperations
interface MonitoredResources {
  @doc("Retrieve the details of the monitored resource.")
  get is ArmResourceRead<MonitoredResource>;
  @doc("Create or update a monitored resource.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<MonitoredResource>;
  @doc("Delete a monitored resource.")
  delete is ArmResourceDeleteSync<MonitoredResource>;
  @doc("A comprehensive list of all monitored resources within a SCOM managed instance.")
  listByManagedInstance is ArmResourceListByParent<MonitoredResource>;
}
