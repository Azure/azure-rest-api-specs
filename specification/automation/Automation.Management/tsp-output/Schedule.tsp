import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automation;
/**
 * Definition of the schedule.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(AutomationAccount)
@Azure.ResourceManager.Private.armResourceInternal(ScheduleProperties)
@includeInapplicableMetadataInPayload(false)
model Schedule extends ProxyResourceBase {
  /**
   * The schedule name.
   */
  @path
  @key("scheduleName")
  @segment("schedules")
  name: string;

  /**
   * Gets or sets the properties of the schedule.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ScheduleProperties;
}

@armResourceOperations
interface Schedules {
  /**
   * Retrieve the schedule identified by schedule name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Schedule_Get")
  get is ArmResourceRead<Schedule>;

  /**
   * Create a schedule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Schedule_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Schedule>;

  /**
   * Update the schedule identified by schedule name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Schedule_Update")
  update is ArmCustomPatchSync<Schedule, ScheduleUpdateParameters>;

  /**
   * Delete the schedule identified by schedule name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Schedule_Delete")
  delete is ArmResourceDeleteSync<Schedule>;

  /**
   * Retrieve a list of schedules.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Schedule_ListByAutomationAccount")
  listByAutomationAccount is ArmResourceListByParent<Schedule>;
}

@@projectedName(Schedules.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(Schedules.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Schedules.createOrUpdate::parameters.resource,
  "The parameters supplied to the create or update schedule operation."
);
@@projectedName(Schedules.update::parameters.properties, "json", "parameters");
@@extension(Schedules.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Schedules.update::parameters.properties,
  "The parameters supplied to the update schedule operation."
);
