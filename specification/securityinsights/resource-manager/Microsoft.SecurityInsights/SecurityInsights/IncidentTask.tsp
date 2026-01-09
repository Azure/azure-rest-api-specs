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

@armResourceOperations
interface IncidentTasks {
  /**
   * Gets an incident task.
   */
  get is Extension.Read<OperationalInsights, IncidentTask, Error = CloudError>;

  /**
   * Creates or updates the incident task.
   */
  createOrUpdate is Extension.CreateOrReplaceSync<
    OperationalInsights,
    IncidentTask,
    Error = CloudError
  >;

  /**
   * Delete the incident task.
   */
  delete is Extension.DeleteSync<
    OperationalInsights,
    IncidentTask,
    Error = CloudError
  >;

  /**
   * Gets all incident tasks.
   */
  list is Extension.ListByTarget<
    OperationalInsights,
    IncidentTask,
    Response = ArmResponse<IncidentTaskList>,
    Error = CloudError
  >;
}

@@doc(IncidentTask.name, "Incident task ID");
@@doc(IncidentTask.properties, "Describes the properties of an incident task");
@@doc(IncidentTasks.createOrUpdate::parameters.resource, "The incident task");
