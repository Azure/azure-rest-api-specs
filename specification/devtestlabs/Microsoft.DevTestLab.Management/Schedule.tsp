import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevTestLab;
/**
 * A schedule.
 */
model Schedule is Azure.ResourceManager.TrackedResource<ScheduleProperties> {
  ...ResourceNameParameter<
    Resource = Schedule,
    KeyName = "name",
    SegmentName = "schedules",
    NamePattern = ""
  >;
}


/**
 * A virtual machine schedule.
 */
@parentResource(LabVirtualMachine)
model VirtualMachineSchedule is Azure.ResourceManager.TrackedResource<ScheduleProperties> {
  ...ResourceNameParameter<
    Resource = VirtualMachineSchedule,
    KeyName = "virtualMachineName",
    SegmentName = "schedules",
    NamePattern = ""
  >;
}

/**
 * A Service Fabric schedule.
 */
@parentResource(ServiceFabric)
model ServiceFabricSchedule is Azure.ResourceManager.TrackedResource<ScheduleProperties> {
  ...ResourceNameParameter<
    Resource = ServiceFabricSchedule,
    KeyName = "serviceFabricName",
    SegmentName = "schedules",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ScheduleOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      KeysOf<ResourceNameParameter<
        Resource = Schedule,
        KeyName = "name",
        SegmentName = "schedules",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface Schedules {
  /**
   * Get schedule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GlobalSchedules_Get")
  get is ScheduleOps.Read<
    Schedule,
    Parameters = {
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GlobalSchedules_CreateOrUpdate")
  createOrUpdate is ScheduleOps.CreateOrUpdateSync<Schedule>;

  /**
   * Allows modifying tags of schedules. All other properties will be ignored.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("GlobalSchedules_Update")
  update is ArmTagsPatchAsync<Schedule>;

  /**
   * Delete schedule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GlobalSchedules_Delete")
  delete is ScheduleOps.DeleteSync<Schedule>;

  /**
   * List schedules in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GlobalSchedules_ListByResourceGroup")
  listByResourceGroup is ScheduleOps.List<
    Schedule,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($select=status)'
       */
      @query("$expand")
      $expand?: string;

      /**
       * The filter to apply to the operation. Example: '$filter=contains(name,'myName')'
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
    },
    Response = ArmResponse<ScheduleList>
  >;

  /**
   * List schedules in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GlobalSchedules_ListBySubscription")
  listBySubscription is ArmListBySubscription<
    Schedule,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($select=status)'
       */
      @query("$expand")
      $expand?: string;

      /**
       * The filter to apply to the operation. Example: '$filter=contains(name,'myName')'
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
    },
    Response = ArmResponse<ScheduleList>
  >;

  /**
   * Execute a schedule. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GlobalSchedules_Execute")
  execute is ScheduleOps.ActionAsync<Schedule, void, OkResponse>;

  /**
   * Updates a schedule's target resource Id. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GlobalSchedules_Retarget")
  retarget is ScheduleOps.ActionAsync<
    Schedule,
    RetargetScheduleProperties,
    OkResponse
  >;
}

@armResourceOperations
interface ServiceFabricScheduleOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** labs */
        @path @segment("labs") labName: string,

        /** users */
        @path @segment("users") userName: string,

        /** servicefabrics */
        @path @segment("servicefabrics") serviceFabricName: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = Schedule,
        KeyName = "name",
        SegmentName = "schedules",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface ServiceFabricSchedules {
  /**
   * Get schedule.
   */
  get is ServiceFabricScheduleOps.Read<
    ServiceFabricSchedule,
    Parameters = {
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
  createOrUpdate is ServiceFabricScheduleOps.CreateOrUpdateSync<ServiceFabricSchedule>;

  /**
   * Allows modifying tags of schedules. All other properties will be ignored.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmTagsPatchAsync<ServiceFabricSchedule>;

  /**
   * Delete schedule.
   */
  delete is ServiceFabricScheduleOps.DeleteSync<ServiceFabricSchedule>;

  /**
   * List schedules in a given service fabric.
   */
  list is ServiceFabricScheduleOps.List<
    ServiceFabricSchedule,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($select=status)'
       */
      @query("$expand")
      $expand?: string;

      /**
       * The filter to apply to the operation. Example: '$filter=contains(name,'myName')'
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
    },
    Response = ArmResponse<ScheduleList>
  >;

  /**
   * Execute a schedule. This operation can take a while to complete.
   */
  execute is ServiceFabricScheduleOps.ActionAsync<ServiceFabricSchedule, void, OkResponse>;
}
@armResourceOperations
interface VirtualMachineScheduleOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** labs */
        @path @segment("labs") labName: string,

        /** virtualmachines */
        @path @segment("virtualmachines") virtualMachineName: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = Schedule,
        KeyName = "name",
        SegmentName = "schedules",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface VirtualMachineSchedules {
  /**
   * Get schedule.
   */
  get is VirtualMachineScheduleOps.Read<
    VirtualMachineSchedule,
    Parameters = {
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
  createOrUpdate is VirtualMachineScheduleOps.CreateOrUpdateSync<VirtualMachineSchedule>;

  /**
   * Allows modifying tags of schedules. All other properties will be ignored.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmTagsPatchAsync<VirtualMachineSchedule>;

  /**
   * Delete schedule.
   */
  delete is VirtualMachineScheduleOps.DeleteSync<VirtualMachineSchedule>;

  /**
   * List schedules in a given virtual machine.
   */
  list is VirtualMachineScheduleOps.List<
    VirtualMachineSchedule,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($select=status)'
       */
      @query("$expand")
      $expand?: string;

      /**
       * The filter to apply to the operation. Example: '$filter=contains(name,'myName')'
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
    },
    Response = ArmResponse<ScheduleList>
  >;

  /**
   * Execute a schedule. This operation can take a while to complete.
   */
  execute is VirtualMachineScheduleOps.ActionAsync<VirtualMachineSchedule, void, OkResponse>;
}

@@doc(Schedule.name, "The name of the schedule.");
@@doc(Schedule.properties, "The properties of the resource.");
@@doc(Schedules.createOrUpdate::parameters.resource, "A schedule.");
@@doc(Schedules.update::parameters.properties,
  "Allows modifying tags of schedules. All other properties will be ignored."
);
@@doc(Schedules.retarget::parameters.body,
  "Properties for retargeting a virtual machine schedule."
);
@@doc(ServiceFabricSchedules.createOrUpdate::parameters.resource,
  "A schedule."
);
@@doc(ServiceFabricSchedules.update::parameters.properties,
  "Allows modifying tags of schedules. All other properties will be ignored."
);
@@doc(VirtualMachineSchedules.createOrUpdate::parameters.resource,
  "A schedule."
);
@@doc(VirtualMachineSchedules.update::parameters.properties,
  "Allows modifying tags of schedules. All other properties will be ignored."
);
