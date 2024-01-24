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
/**
 * A schedule.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(ScheduleProperties)
@includeInapplicableMetadataInPayload(false)
model Schedule extends Resource {
  /**
   * The name of the schedule.
   */
  @path
  @key("name")
  @segment("schedules")
  name: string;

  /**
   * The properties of the resource.
   */
  @extension("x-ms-client-flatten", true)
  properties: ScheduleProperties;
}

@armResourceOperations
interface Schedules {
  /**
   * Get schedule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GlobalSchedules_Get")
  get is ArmResourceRead<
    Schedule,
    {
      ...BaseParameters<Schedule>;

      /**
       * Specify the $expand query. Example: 'properties($select=status)'
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Create or replace an existing schedule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GlobalSchedules_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Schedule>;

  /**
   * Allows modifying tags of schedules. All other properties will be ignored.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("GlobalSchedules_Update")
  update is ArmCustomPatchSync<Schedule, ScheduleFragment>;

  /**
   * Delete schedule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GlobalSchedules_Delete")
  delete is ArmResourceDeleteSync<Schedule>;

  /**
   * List schedules in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GlobalSchedules_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    Schedule,
    {
      ...BaseParameters<Schedule>;

      /**
       * Specify the $expand query. Example: 'properties($select=status)'
       */
      @query("$expand")
      $expand?: string;

      /**
       * The filter to apply to the operation. Example: '$filter=contains(name,'myName')
       */
      @query("$filter")
      $filter?: string;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'
       */
      @query("$top")
      $top?: int32;

      /**
       * The ordering expression for the results, using OData notation. Example: '$orderby=name desc'
       */
      @query("$orderby")
      $orderby?: string;
    }
  >;

  /**
   * List schedules in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GlobalSchedules_ListBySubscription")
  listBySubscription is ArmListBySubscription<Schedule>;

  /**
   * Execute a schedule. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GlobalSchedules_Execute")
  execute is ArmResourceActionAsync<Schedule, void, void>;

  /**
   * Updates a schedule's target resource Id. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
