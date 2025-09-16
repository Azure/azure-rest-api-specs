import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.Core;

namespace Microsoft.DependencyMap;

@doc("The properties of Maps resource")
model MapsResourceProperties {
  @doc("Provisioning state of Maps resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Provisioning state of the resource")
@lroStatus
union ProvisioningState {
  @doc("Resource has been created.")
  Succeeded: "Succeeded",

  @doc("Resource creation failed.")
  Failed: "Failed",

  @doc("Resource creation was canceled.")
  Canceled: "Canceled",

  @doc("This state indicates that the resource is being provisioned.")
  Provisioning: "Provisioning",

  @doc("This state indicates that the resource is being updated.")
  Updating: "Updating",

  @doc("This state indicates that the resource is being deleted.")
  Deleting: "Deleting",

  @doc("This state indicates that the operation on the resource has been accepted.")
  Accepted: "Accepted",

  string,
}

@doc("Filters for dependency map visualization apis")
model DependencyMapVisualizationFilter {
  @doc("DateTime filter")
  dateTime?: DateTimeFilter;

  @doc("Process name filter")
  processNameFilter?: ProcessNameFilter;
}

@doc("UTC DateTime filter for dependency map visualization apis")
model DateTimeFilter {
  @doc("Start date time for dependency map visualization query")
  startDateTimeUtc?: utcDateTime;

  @doc("End date time for dependency map visualization query")
  endDateTimeUtc?: utcDateTime;
}

@doc("Process name filter for dependency map visualization apis")
model ProcessNameFilter {
  @doc("Operator for process name filter")
  operator: ProcessNameFilterOperator;

  @doc("List of process names on which the operator should be applied")
  processNames: string[];
}

@doc("Operator enum for process name filter")
union ProcessNameFilterOperator {
  @doc("Operator to include items in the result")
  contains: "contains",

  @doc("Operator to exclude items in the result")
  notContains: "notContains",

  string,
}

@doc("DependencyProcessFilter model")
@added(Versions.v2025_07_01_preview)
model DependencyProcessFilter {
  @doc("Process name filter")
  processNameFilter?: ProcessNameFilter;
}

@doc("GetDependencyViewForFocusedMachine request model")
model GetDependencyViewForFocusedMachineRequest {
  @doc("Machine arm id")
  focusedMachineId: string;

  @doc("Filters for GetSingleMachineDependencyView")
  filters?: DependencyMapVisualizationFilter;
}

@doc("GetConnectionsWithConnectedMachineForFocusedMachine request model")
model GetConnectionsWithConnectedMachineForFocusedMachineRequest {
  @doc("Source machine arm id")
  focusedMachineId: string;

  @doc("Destination machine arm id")
  connectedMachineId: string;

  @doc("Filters for GetNetworkConnectionsBetweenMachines")
  filters?: DependencyMapVisualizationFilter;
}

@doc("GetConnectionsForProcessOnFocusedMachine request model")
model GetConnectionsForProcessOnFocusedMachineRequest {
  @doc("Machine arm id")
  focusedMachineId: string;

  @doc("Process id")
  processIdOnFocusedMachine: string;

  @doc("Filters for GetProcessNetworkConnections")
  filters?: DependencyMapVisualizationFilter;
}

@doc("ExportDependencies request model")
model ExportDependenciesRequest {
  @doc("Machine arm id")
  focusedMachineId?: string;

  @doc("Filters for ExportDependencies")
  filters?: DependencyMapVisualizationFilter;

  @added(Versions.v2025_05_01_preview)
  @doc("List of Appliance Names")
  applianceNameList?: string[];
}

@added(Versions.v2025_07_01_preview)
@doc("GetDependencyViewForAllMachines request model")
model GetDependencyViewForAllMachinesRequest {
  @doc("Filters for GetDependencyViewForAllMachines")
  filters?: DependencyProcessFilter;
}

@doc("Model representing the result of the export dependencies asynchronous operation.")
@added(Versions.v2025_07_01_preview)
model GetDependencyViewForAllMachinesOperationResult {
  @doc("The status URL of the asynchronous operation.")
  id?: string;

  @doc("The resource name of the operation status. It must match the last segment of 'id' field.")
  name?: string;

  @doc("The overall arm status of the operation. It has one of the terminal states - Succeeded/Failed/Canceled.")
  status: string;

  @doc("Contains error details if status is Failed/Canceled.")
  error?: Azure.ResourceManager.Foundations.ErrorDetail;

  @doc("The start time of the operation.")
  startTime?: utcDateTime;

  @doc("The end time of the operation.")
  endTime?: utcDateTime;

  @doc("Properties for export dependencies. These should only be set if the status is Succeeded.")
  properties?: GetDependencyViewForAllMachinesResultProperties;
}

@doc("Model representing properties returned upon successful completion of the export dependencies asynchronous operation.")
@added(Versions.v2025_07_01_preview)
model GetDependencyViewForAllMachinesResultProperties {
  @doc("The SAS URI of the blob containing the layout file for the multi-server view.")
  layoutFileSasUrl: string;
}

@doc("The properties of Discovery Source resource")
@discriminator("sourceType")
model DiscoverySourceResourceProperties {
  @doc("Provisioning state of Discovery Source resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Source type of Discovery Source resource.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  sourceType: SourceType;

  @doc("Source ArmId of Discovery Source resource")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  sourceId: string;
}

@doc("OffAzure discovery source resource properties")
model OffAzureDiscoverySourceResourceProperties
  extends DiscoverySourceResourceProperties {
  @doc("OffAzure discovery source type")
  sourceType: SourceType.OffAzure;
}

@doc("Source type of the discoverySource")
union SourceType {
  @doc("OffAzure source type")
  OffAzure: "OffAzure",

  string,
}

@doc("Model representing the result of the export dependencies asynchronous operation.")
model ExportDependenciesOperationResult {
  @doc("The status URL of export dependencies operation.")
  id?: string;

  @doc("The resource name of the operation status. It must match the last segment of 'id' field.")
  name?: string;

  @doc("The overall arm status of the operation. It has one of the terminal states - Succeeded/Failed/Canceled.")
  status: string;

  @doc("Contains error details if status is Failed/Canceled.")
  error?: Azure.ResourceManager.Foundations.ErrorDetail;

  @doc("The start time of the operation.")
  startTime?: utcDateTime;

  @doc("The end time of the operation.")
  endTime?: utcDateTime;

  @doc("Properties for export dependencies. These should only be set if the status is Succeeded.")
  properties?: ExportDependenciesResultProperties;
}

@doc("Model representing properties returned upon successful completion of the export dependencies asynchronous operation.")
model ExportDependenciesResultProperties {
  @doc("The SAS URI of the blob containing the exported dependencies data.")
  exportedDataSasUri?: string;

  @doc("A status code returned by the service with additional context about the export dependencies operation.")
  statusCode?: ExportDependenciesStatusCode;

  @doc("Additional information about the exported data.")
  additionalInfo?: ExportDependenciesAdditionalInfo;
}

/** Status codes for export dependencies operation */
union ExportDependenciesStatusCode {
  string,

  /** Operation completed but no data was found for the requested time range */
  NoMatch: "NoMatch",

  /** Operation completed with data found for the entire requested time range */
  CompleteMatch: "CompleteMatch",

  /** Operation completed with data found for a portion of the requested time range */
  PartialMatch: "PartialMatch",
}

@doc("Additional information about the exported dependencies data.")
model ExportDependenciesAdditionalInfo {
  @doc("Number of days for which data was available in the exported results.")
  availableDaysCount?: int32;
}
