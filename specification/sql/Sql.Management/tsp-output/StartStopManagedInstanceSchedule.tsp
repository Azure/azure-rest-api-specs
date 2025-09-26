import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * Managed instance's Start/Stop schedule.
 */
@parentResource(ManagedInstance)
model StartStopManagedInstanceSchedule
  is ProxyResource<StartStopManagedInstanceScheduleProperties> {
  /**
   * Name of the managed instance Start/Stop schedule.
   */
  @path
  @key("startStopScheduleName")
  @segment("startStopSchedules")
  name: StartStopScheduleName;
}

@armResourceOperations
interface StartStopManagedInstanceSchedules {
  /**
   * Gets the managed instance's Start/Stop schedule.
   */
  get is ArmResourceRead<StartStopManagedInstanceSchedule>;

  /**
   * Creates or updates the managed instance's Start/Stop schedule.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<StartStopManagedInstanceSchedule>;

  /**
   * Deletes the managed instance's Start/Stop schedule.
   */
  delete is ArmResourceDeleteSync<StartStopManagedInstanceSchedule>;

  /**
   * Lists the managed instance's Start/Stop schedules.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("StartStopManagedInstanceSchedules_ListByInstance")
  listByInstance is ArmResourceListByParent<StartStopManagedInstanceSchedule>;
}

@@projectedName(StartStopManagedInstanceSchedules.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(StartStopManagedInstanceSchedules.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(StartStopManagedInstanceSchedules.createOrUpdate::parameters.resource,
  "The requested managed instance Start/Stop schedule."
);
