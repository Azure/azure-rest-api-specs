import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace WorkloadMonitorAPI;

interface OperationsOperations {
  @summary("Get a list of all available REST API operations.")
  @doc("Get a list of all available REST API operations.")
  @route("/providers/Microsoft.WorkloadMonitor/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationList>;
}

interface HealthMonitorsOperations {
  @summary("""
Get the current health status of all monitors of a virtual machine. Optional
parameters: $expand (retrieve the monitor's evidence and configuration) and
$filter (filter by monitor name).
""")
  @doc("""
Get the current health status of all monitors of a virtual machine. Optional
parameters: $expand (retrieve the monitor's evidence and configuration) and
$filter (filter by monitor name).
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{providerName}/{resourceCollectionName}/{resourceName}/providers/Microsoft.WorkloadMonitor/monitors")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription Id of the virtual machine.")
      @path
      subscriptionId: string;

      @doc("The resource group of the virtual machine.")
      @path
      resourceGroupName: string;

      @doc("The provider name (ex: Microsoft.Compute for virtual machines).")
      @path
      providerName: string;

      @doc("The resource collection name (ex: virtualMachines for virtual machines).")
      @path
      resourceCollectionName: string;

      @doc("The name of the virtual machine.")
      @path
      resourceName: string;

      @doc("""
Optionally filter by monitor name. Example: $filter=monitorName eq
'logical-disks|C:|disk-free-space-mb.'
""")
      @query
      $filter: string;

      @doc("""
Optionally expand the monitor’s evidence and/or configuration. Example:
$expand=evidence,configuration.
""")
      @query
      $expand: string;
    },
    HealthMonitorList
  >;

  @summary("""
Get the current health status of a monitor of a virtual machine. Optional
parameter: $expand (retrieve the monitor's evidence and configuration).
""")
  @doc("""
Get the current health status of a monitor of a virtual machine. Optional
parameter: $expand (retrieve the monitor's evidence and configuration).
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{providerName}/{resourceCollectionName}/{resourceName}/providers/Microsoft.WorkloadMonitor/monitors/{monitorId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription Id of the virtual machine.")
      @path
      subscriptionId: string;

      @doc("The resource group of the virtual machine.")
      @path
      resourceGroupName: string;

      @doc("The provider name (ex: Microsoft.Compute for virtual machines).")
      @path
      providerName: string;

      @doc("The resource collection name (ex: virtualMachines for virtual machines).")
      @path
      resourceCollectionName: string;

      @doc("The name of the virtual machine.")
      @path
      resourceName: string;

      @doc("The monitor Id of the virtual machine.")
      @path
      monitorId: string;

      @doc("""
Optionally expand the monitor’s evidence and/or configuration. Example:
$expand=evidence,configuration.
""")
      @query
      $expand: string;
    },
    HealthMonitor
  >;

  @summary("""
Get the health state changes of a monitor of a virtual machine within the
provided time window (default is the last 24 hours). Optional parameters:
$expand (retrieve the monitor's evidence and configuration) and $filter (filter
by heartbeat condition).
""")
  @doc("""
Get the health state changes of a monitor of a virtual machine within the
provided time window (default is the last 24 hours). Optional parameters:
$expand (retrieve the monitor's evidence and configuration) and $filter (filter
by heartbeat condition).
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{providerName}/{resourceCollectionName}/{resourceName}/providers/Microsoft.WorkloadMonitor/monitors/{monitorId}/history")
  @get
  ListStateChanges is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription Id of the virtual machine.")
      @path
      subscriptionId: string;

      @doc("The resource group of the virtual machine.")
      @path
      resourceGroupName: string;

      @doc("The provider name (ex: Microsoft.Compute for virtual machines).")
      @path
      providerName: string;

      @doc("The resource collection name (ex: virtualMachines for virtual machines).")
      @path
      resourceCollectionName: string;

      @doc("The name of the virtual machine.")
      @path
      resourceName: string;

      @doc("The monitor Id of the virtual machine.")
      @path
      monitorId: string;

      @doc("Optionally filter by heartbeat condition. Example: $filter=isHeartbeat eq false.")
      @query
      $filter: string;

      @doc("""
Optionally expand the monitor’s evidence and/or configuration. Example:
$expand=evidence,configuration.
""")
      @query
      $expand: string;

      @doc("The start of the time window.")
      @query
      startTimestampUtc: utcDateTime;

      @doc("The end of the time window.")
      @query
      endTimestampUtc: utcDateTime;
    },
    HealthMonitorStateChangeList
  >;

  @summary("""
Get the health state change of a monitor of a virtual machine at the provided
timestamp. Optional parameter: $expand (retrieve the monitor's evidence and
configuration).
""")
  @doc("""
Get the health state change of a monitor of a virtual machine at the provided
timestamp. Optional parameter: $expand (retrieve the monitor's evidence and
configuration).
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{providerName}/{resourceCollectionName}/{resourceName}/providers/Microsoft.WorkloadMonitor/monitors/{monitorId}/history/{timestampUnix}")
  @get
  GetStateChange is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription Id of the virtual machine.")
      @path
      subscriptionId: string;

      @doc("The resource group of the virtual machine.")
      @path
      resourceGroupName: string;

      @doc("The provider name (ex: Microsoft.Compute for virtual machines).")
      @path
      providerName: string;

      @doc("The resource collection name (ex: virtualMachines for virtual machines).")
      @path
      resourceCollectionName: string;

      @doc("The name of the virtual machine.")
      @path
      resourceName: string;

      @doc("The monitor Id of the virtual machine.")
      @path
      monitorId: string;

      @doc("The timestamp of the state change (unix format).")
      @path
      timestampUnix: string;

      @doc("""
Optionally expand the monitor’s evidence and/or configuration. Example:
$expand=evidence,configuration.
""")
      @query
      $expand: string;
    },
    HealthMonitorStateChange
  >;
}
