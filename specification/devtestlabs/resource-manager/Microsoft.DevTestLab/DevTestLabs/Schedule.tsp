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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@Azure.ResourceManager.Legacy.customAzureResource
@Http.Private.includeInapplicableMetadataInPayload(false)
model Schedule extends Resource {
  @visibility(Lifecycle.Read)
  @path
  @key
  @segment("schedules")
  name: string;

  properties: ScheduleProperties;
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
interface GlobalSchedules {
  /**
   * Get schedule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
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
  createOrUpdate is ScheduleOps.CreateOrUpdateSync<Schedule>;

  /**
   * Allows modifying tags of schedules. All other properties will be ignored.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "Already contains tags"
  @patch(#{ implicitOptionality: false })
  update is ScheduleOps.CustomPatchSync<
    Schedule,
    PatchModel = ScheduleFragment
  >;

  /**
   * Delete schedule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  delete is ScheduleOps.DeleteSync<Schedule>;

  /**
   * List schedules in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  listByResourceGroup is ScheduleOps.List<
    Schedule,
    Parameters = {
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
    },
    Response = ArmResponse<ScheduleList>
  >;

  /**
   * List schedules in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  listBySubscription is ArmListBySubscription<
    Schedule,
    Parameters = {
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
    },
    Response = ArmResponse<ScheduleList>
  >;

  /**
   * Execute a schedule. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  execute is ScheduleOps.ActionAsync<Schedule, void, OkResponse>;

  /**
   * Updates a schedule's target resource Id. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  retarget is ScheduleOps.ActionAsync<
    Schedule,
    RetargetScheduleProperties,
    OkResponse
  >;
}
@armResourceOperations
interface ScheduleOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** labs */
        @path @segment("labs") labName: string,
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
  get is ScheduleOperationGroupOps.Read<
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
  createOrUpdate is ScheduleOperationGroupOps.CreateOrUpdateSync<Schedule>;

  /**
   * Allows modifying tags of schedules. All other properties will be ignored.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "Already contains tags"
  @patch(#{ implicitOptionality: false })
  update is ScheduleOperationGroupOps.CustomPatchSync<
    Schedule,
    PatchModel = ScheduleFragment
  >;

  /**
   * Delete schedule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  delete is ScheduleOperationGroupOps.DeleteSync<Schedule>;

  /**
   * List schedules in a given lab.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  list is ScheduleOperationGroupOps.List<
    Schedule,
    Parameters = {
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
    },
    Response = ArmResponse<ScheduleList>
  >;

  /**
   * Execute a schedule. This operation can take a while to complete.
   */
  execute is ScheduleOperationGroupOps.ActionAsync<Schedule, void, OkResponse>;

  /**
   * Lists all applicable schedules
   */
  @list
  listApplicable is ScheduleOperationGroupOps.ActionSync<
    Schedule,
    void,
    ArmResponse<ScheduleList>
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
  createOrUpdate is ServiceFabricScheduleOps.CreateOrUpdateSync<Schedule>;

  /**
   * Allows modifying tags of schedules. All other properties will be ignored.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "Already contains tags"
  @patch(#{ implicitOptionality: false })
  update is ServiceFabricScheduleOps.CustomPatchSync<
    Schedule,
    PatchModel = ScheduleFragment
  >;

  /**
   * Delete schedule.
   */
  delete is ServiceFabricScheduleOps.DeleteSync<Schedule>;

  /**
   * List schedules in a given service fabric.
   */
  list is ServiceFabricScheduleOps.List<
    Schedule,
    Parameters = {
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
    },
    Response = ArmResponse<ScheduleList>
  >;

  /**
   * Execute a schedule. This operation can take a while to complete.
   */
  execute is ServiceFabricScheduleOps.ActionAsync<Schedule, void, OkResponse>;
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
  createOrUpdate is VirtualMachineScheduleOps.CreateOrUpdateSync<Schedule>;

  /**
   * Allows modifying tags of schedules. All other properties will be ignored.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "Already contains tags"
  @patch(#{ implicitOptionality: false })
  update is VirtualMachineScheduleOps.CustomPatchSync<
    Schedule,
    PatchModel = ScheduleFragment
  >;

  /**
   * Delete schedule.
   */
  delete is VirtualMachineScheduleOps.DeleteSync<Schedule>;

  /**
   * List schedules in a given virtual machine.
   */
  list is VirtualMachineScheduleOps.List<
    Schedule,
    Parameters = {
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
    },
    Response = ArmResponse<ScheduleList>
  >;

  /**
   * Execute a schedule. This operation can take a while to complete.
   */
  execute is VirtualMachineScheduleOps.ActionAsync<Schedule, void, OkResponse>;
}

@@doc(Schedule.name, "The name of the schedule.");
@@doc(Schedule.properties, "The properties of the resource.");
@@doc(Schedule.location, "The location of the resource.");
@@doc(Schedule.tags, "The tags of the resource.");
@@doc(GlobalSchedules.createOrUpdate::parameters.resource, "A schedule.");
@@doc(GlobalSchedules.update::parameters.properties, "A schedule.");
@@doc(GlobalSchedules.retarget::parameters.body,
  "Properties for retargeting a virtual machine schedule."
);
@@doc(Schedules.createOrUpdate::parameters.resource, "A schedule.");
@@doc(Schedules.update::parameters.properties, "A schedule.");
@@doc(ServiceFabricSchedules.createOrUpdate::parameters.resource,
  "A schedule."
);
@@doc(ServiceFabricSchedules.update::parameters.properties, "A schedule.");
@@doc(VirtualMachineSchedules.createOrUpdate::parameters.resource,
  "A schedule."
);
@@doc(VirtualMachineSchedules.update::parameters.properties, "A schedule.");
