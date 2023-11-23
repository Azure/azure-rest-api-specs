import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Incident.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.SecurityInsights;

@parentResource(Incident)
model IncidentTask is ProxyResource<IncidentTaskProperties> {
  @doc("Incident task ID")
  @path
  @key("incidentTaskId")
  @segment("tasks")
  name: string;
}

@armResourceOperations
interface IncidentTasks {
  @doc("Gets an incident task.")
  get is ArmResourceRead<IncidentTask>;
  @doc("Creates or updates the incident task.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<IncidentTask>;
  @doc("Delete the incident task.")
  delete is ArmResourceDeleteSync<IncidentTask>;
  @doc("Gets all incident tasks.")
  list is ArmResourceListByParent<IncidentTask>;
}
