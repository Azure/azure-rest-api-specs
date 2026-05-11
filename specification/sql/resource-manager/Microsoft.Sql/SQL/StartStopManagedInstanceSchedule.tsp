import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * Managed instance's Start/Stop schedule.
 */
@parentResource(ManagedInstance)
model StartStopManagedInstanceSchedule
  is Azure.ResourceManager.ProxyResource<StartStopManagedInstanceScheduleProperties> {
  ...ResourceNameParameter<
    Resource = StartStopManagedInstanceSchedule,
    KeyName = "startStopScheduleName",
    SegmentName = "startStopSchedules",
    NamePattern = "",
    Type = StartStopScheduleName
  >;
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
  listByInstance is ArmResourceListByParent<StartStopManagedInstanceSchedule>;
}

@@doc(StartStopManagedInstanceSchedule.name,
  "Name of the managed instance Start/Stop schedule."
);
@@doc(StartStopManagedInstanceSchedule.properties, "Resource properties.");
@@doc(StartStopManagedInstanceSchedules.createOrUpdate::parameters.resource,
  "The requested managed instance Start/Stop schedule."
);
