import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.DevTestLab;

interface OperationsOperations {
  /**
   * Get operation.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DevTestLab/locations/{locationName}/operations/{name}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the location.
       */
      @path
      locationName: string;

      /**
       * The name of the operation.
       */
      @path
      name: string;
    },
    OperationResult
  >;
}

interface SchedulesOperations {
  /**
   * List schedules in a given lab.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevTestLab/labs/{labName}/schedules")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the lab.
       */
      @path
      labName: string;

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
    ResourceListResult<Schedule>
  >;

  /**
   * Get schedule.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevTestLab/labs/{labName}/schedules/{name}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the lab.
       */
      @path
      labName: string;

      /**
       * The name of the schedule.
       */
      @path
      name: string;

      /**
       * Specify the $expand query. Example: 'properties($select=status)'
       */
      @query("$expand")
      $expand?: string;
    },
    Schedule
  >;

  /**
   * Create or replace an existing schedule.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevTestLab/labs/{labName}/schedules/{name}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the lab.
       */
      @path
      labName: string;

      /**
       * The name of the schedule.
       */
      @path
      name: string;

      /**
       * A schedule.
       */
      @body
      schedule: Schedule;
    },
    Schedule
  >;

  /**
   * Delete schedule.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevTestLab/labs/{labName}/schedules/{name}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the lab.
       */
      @path
      labName: string;

      /**
       * The name of the schedule.
       */
      @path
      name: string;
    },
    void
  >;

  /**
   * Allows modifying tags of schedules. All other properties will be ignored.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevTestLab/labs/{labName}/schedules/{name}")
  @patch
  update is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the lab.
       */
      @path
      labName: string;

      /**
       * The name of the schedule.
       */
      @path
      name: string;

      /**
       * A schedule.
       */
      @body
      schedule: ScheduleFragment;
    },
    Schedule
  >;

  /**
   * Execute a schedule. This operation can take a while to complete.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevTestLab/labs/{labName}/schedules/{name}/execute")
  @post
  execute is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the lab.
       */
      @path
      labName: string;

      /**
       * The name of the schedule.
       */
      @path
      name: string;
    },
    void
  >;

  /**
   * Lists all applicable schedules
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevTestLab/labs/{labName}/schedules/{name}/listApplicable")
  @post
  listApplicable is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the lab.
       */
      @path
      labName: string;

      /**
       * The name of the schedule.
       */
      @path
      name: string;
    },
    ResourceListResult<Schedule>
  >;
}

interface ServiceFabricSchedulesOperations {
  /**
   * List schedules in a given service fabric.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevTestLab/labs/{labName}/users/{userName}/servicefabrics/{serviceFabricName}/schedules")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the lab.
       */
      @path
      labName: string;

      /**
       * The name of the user profile.
       */
      @path
      userName: string;

      /**
       * The name of the service fabric.
       */
      @path
      serviceFabricName: string;

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
    ResourceListResult<Schedule>
  >;

  /**
   * Get schedule.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevTestLab/labs/{labName}/users/{userName}/servicefabrics/{serviceFabricName}/schedules/{name}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the lab.
       */
      @path
      labName: string;

      /**
       * The name of the user profile.
       */
      @path
      userName: string;

      /**
       * The name of the service fabric.
       */
      @path
      serviceFabricName: string;

      /**
       * The name of the schedule.
       */
      @path
      name: string;

      /**
       * Specify the $expand query. Example: 'properties($select=status)'
       */
      @query("$expand")
      $expand?: string;
    },
    Schedule
  >;

  /**
   * Create or replace an existing schedule.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevTestLab/labs/{labName}/users/{userName}/servicefabrics/{serviceFabricName}/schedules/{name}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the lab.
       */
      @path
      labName: string;

      /**
       * The name of the user profile.
       */
      @path
      userName: string;

      /**
       * The name of the service fabric.
       */
      @path
      serviceFabricName: string;

      /**
       * The name of the schedule.
       */
      @path
      name: string;

      /**
       * A schedule.
       */
      @body
      schedule: Schedule;
    },
    Schedule
  >;

  /**
   * Delete schedule.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevTestLab/labs/{labName}/users/{userName}/servicefabrics/{serviceFabricName}/schedules/{name}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the lab.
       */
      @path
      labName: string;

      /**
       * The name of the user profile.
       */
      @path
      userName: string;

      /**
       * The name of the service fabric.
       */
      @path
      serviceFabricName: string;

      /**
       * The name of the schedule.
       */
      @path
      name: string;
    },
    void
  >;

  /**
   * Allows modifying tags of schedules. All other properties will be ignored.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevTestLab/labs/{labName}/users/{userName}/servicefabrics/{serviceFabricName}/schedules/{name}")
  @patch
  update is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the lab.
       */
      @path
      labName: string;

      /**
       * The name of the user profile.
       */
      @path
      userName: string;

      /**
       * The name of the service fabric.
       */
      @path
      serviceFabricName: string;

      /**
       * The name of the schedule.
       */
      @path
      name: string;

      /**
       * A schedule.
       */
      @body
      schedule: ScheduleFragment;
    },
    Schedule
  >;

  /**
   * Execute a schedule. This operation can take a while to complete.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevTestLab/labs/{labName}/users/{userName}/servicefabrics/{serviceFabricName}/schedules/{name}/execute")
  @post
  execute is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the lab.
       */
      @path
      labName: string;

      /**
       * The name of the user profile.
       */
      @path
      userName: string;

      /**
       * The name of the service fabric.
       */
      @path
      serviceFabricName: string;

      /**
       * The name of the schedule.
       */
      @path
      name: string;
    },
    void
  >;
}

interface VirtualMachineSchedulesOperations {
  /**
   * List schedules in a given virtual machine.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevTestLab/labs/{labName}/virtualmachines/{virtualMachineName}/schedules")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the lab.
       */
      @path
      labName: string;

      /**
       * The name of the virtual machine.
       */
      @path
      virtualMachineName: string;

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
    ResourceListResult<Schedule>
  >;

  /**
   * Get schedule.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevTestLab/labs/{labName}/virtualmachines/{virtualMachineName}/schedules/{name}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the lab.
       */
      @path
      labName: string;

      /**
       * The name of the virtual machine.
       */
      @path
      virtualMachineName: string;

      /**
       * The name of the schedule.
       */
      @path
      name: string;

      /**
       * Specify the $expand query. Example: 'properties($select=status)'
       */
      @query("$expand")
      $expand?: string;
    },
    Schedule
  >;

  /**
   * Create or replace an existing schedule.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevTestLab/labs/{labName}/virtualmachines/{virtualMachineName}/schedules/{name}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the lab.
       */
      @path
      labName: string;

      /**
       * The name of the virtual machine.
       */
      @path
      virtualMachineName: string;

      /**
       * The name of the schedule.
       */
      @path
      name: string;

      /**
       * A schedule.
       */
      @body
      schedule: Schedule;
    },
    Schedule
  >;

  /**
   * Delete schedule.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevTestLab/labs/{labName}/virtualmachines/{virtualMachineName}/schedules/{name}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the lab.
       */
      @path
      labName: string;

      /**
       * The name of the virtual machine.
       */
      @path
      virtualMachineName: string;

      /**
       * The name of the schedule.
       */
      @path
      name: string;
    },
    void
  >;

  /**
   * Allows modifying tags of schedules. All other properties will be ignored.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevTestLab/labs/{labName}/virtualmachines/{virtualMachineName}/schedules/{name}")
  @patch
  update is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the lab.
       */
      @path
      labName: string;

      /**
       * The name of the virtual machine.
       */
      @path
      virtualMachineName: string;

      /**
       * The name of the schedule.
       */
      @path
      name: string;

      /**
       * A schedule.
       */
      @body
      schedule: ScheduleFragment;
    },
    Schedule
  >;

  /**
   * Execute a schedule. This operation can take a while to complete.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevTestLab/labs/{labName}/virtualmachines/{virtualMachineName}/schedules/{name}/execute")
  @post
  execute is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the lab.
       */
      @path
      labName: string;

      /**
       * The name of the virtual machine.
       */
      @path
      virtualMachineName: string;

      /**
       * The name of the schedule.
       */
      @path
      name: string;
    },
    void
  >;
}
