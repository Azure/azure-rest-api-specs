import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Incident.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityInsights;
/**
 * Describes incident task properties
 */
@parentResource(Incident)
model IncidentTask
  is Azure.ResourceManager.ProxyResource<IncidentTaskProperties, false> {
  ...ResourceNameParameter<
    Resource = IncidentTask,
    KeyName = "incidentTaskId",
    SegmentName = "tasks",
    NamePattern = ""
  >;

  /**
   * Etag of the azure resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

alias IncidentTaskWorkspaceExternalResource = Extension.ExternalResource<
  "Microsoft.OperationalInsights",
  "workspaces",
  "{workspaceName}"
>;

@armResourceOperations
interface IncidentTasks {
  /**
   * Gets an incident task.
   */
  get is ArmResourceRead<IncidentTask>;

  /**
   * Creates or updates the incident task.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<IncidentTask>;

  /**
   * Delete the incident task.
   */
  delete is ArmResourceDeleteSync<IncidentTask>;

  /**
   * Gets all incident tasks.
   */
  list is ArmResourceListByParent<
    IncidentTask,
    Response = ArmResponse<IncidentTaskList>
  >;
}

@@doc(IncidentTask.name, "Incident task ID");
@@doc(IncidentTask.properties, "Describes the properties of an incident task");
@@doc(IncidentTasks.createOrUpdate::parameters.resource, "The incident task");
