import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevTestLab;
@doc("A schedule.")
model Schedule is TrackedResource<ScheduleProperties> {
  @doc("The name of the schedule.")
  @path
  @key("name")
  @segment("schedules")
  name: string;
}

@armResourceOperations
interface Schedules {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get schedule.")
  @operationId("GlobalSchedules_Get")
  get is ArmResourceRead<
    Schedule,
    {
      ...BaseParameters<Schedule>;

      @doc("Specify the $expand query. Example: 'properties($select=status)'")
      @query("$expand")
      $expand?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or replace an existing schedule.")
  @operationId("GlobalSchedules_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Schedule>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Allows modifying tags of schedules. All other properties will be ignored.")
  @operationId("GlobalSchedules_Update")
  update is ArmCustomPatchSync<Schedule, ScheduleFragment>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete schedule.")
  @operationId("GlobalSchedules_Delete")
  delete is ArmResourceDeleteSync<Schedule>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List schedules in a resource group.")
  @operationId("GlobalSchedules_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    Schedule,
    {
      ...BaseParameters<Schedule>;

      @doc("Specify the $expand query. Example: 'properties($select=status)'")
      @query("$expand")
      $expand?: string;

      @doc("The filter to apply to the operation. Example: '$filter=contains(name,'myName')")
      @query("$filter")
      $filter?: string;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'")
      @query("$top")
      $top?: int32;

      @doc("The ordering expression for the results, using OData notation. Example: '$orderby=name desc'")
      @query("$orderby")
      $orderby?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List schedules in a subscription.")
  @operationId("GlobalSchedules_ListBySubscription")
  listBySubscription is ArmListBySubscription<Schedule>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Execute a schedule. This operation can take a while to complete.")
  @operationId("GlobalSchedules_Execute")
  execute is ArmResourceActionAsync<Schedule, void, void>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates a schedule's target resource Id. This operation can take a while to complete.")
  @operationId("GlobalSchedules_Retarget")
  retarget is ArmResourceActionAsync<
    Schedule,
    RetargetScheduleProperties,
    void
  >;
}

@@projectedName(Schedules.createOrUpdate::parameters.resource,
  "json",
  "schedule"
);
@@extension(Schedules.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "schedule"
);
@@doc(Schedules.createOrUpdate::parameters.resource, "A schedule.");
@@projectedName(Schedules.update::parameters.properties, "json", "schedule");
@@extension(Schedules.update::parameters.properties,
  "x-ms-client-name",
  "schedule"
);
@@doc(Schedules.update::parameters.properties, "A schedule.");
@@projectedName(Schedules.retarget::parameters.body,
  "json",
  "retargetScheduleProperties"
);
@@extension(Schedules.retarget::parameters.body,
  "x-ms-client-name",
  "retargetScheduleProperties"
);
@@doc(Schedules.retarget::parameters.body,
  "Properties for retargeting a virtual machine schedule."
);
