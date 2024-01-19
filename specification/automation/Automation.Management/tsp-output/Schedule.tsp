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
@doc("Definition of the schedule.")
@parentResource(AutomationAccount)
model Schedule is ProxyResource<ScheduleProperties> {
  @doc("The schedule name.")
  @path
  @key("scheduleName")
  @segment("schedules")
  name: string;
}

@armResourceOperations
interface Schedules {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve the schedule identified by schedule name.")
  @operationId("Schedule_Get")
  get is ArmResourceRead<Schedule>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a schedule.")
  @operationId("Schedule_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Schedule>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update the schedule identified by schedule name.")
  @operationId("Schedule_Update")
  update is ArmCustomPatchSync<Schedule, ScheduleUpdateParameters>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete the schedule identified by schedule name.")
  @operationId("Schedule_Delete")
  delete is ArmResourceDeleteSync<Schedule>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve a list of schedules.")
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
