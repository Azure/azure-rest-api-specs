import "@typespec/openapi";
import "@typespec/rest";

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.Impact;

using TypeSpec.Http;
using TypeSpec.Rest;
using OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;

@doc("Details about impacted performance metrics. Applicable for performance related impact")
model Performance {
  @doc("Name of the Metric examples:  Disk, IOPs, CPU, GPU, Memory, details can be found from /impactCategories API")
  metricName?: string;

  @doc("Threshold value for the metric")
  expected?: float64;

  @doc("Observed value for the metric")
  actual?: float64;

  @doc("Max and Min Threshold values for the metric")
  expectedValueRange?: ExpectedValueRange;

  @doc("Unit of the metric ex: Bytes, Percentage, Count, Seconds, Milliseconds, Bytes/Second, Count/Second, etc.., Other")
  unit?: MetricUnit;
}

@doc("Details about connectivity issue. Applicable when root resource causing the issue is not identified. For example, when a VM is impacted due to a network issue, the impacted resource could be VM or the network. In such cases, the connectivity field will have the details about both VM and network.")
model Connectivity {
  @doc("Protocol used for the connection")
  protocol?: Protocol;

  @doc("Port number for the connection")
  port?: int32;

  @doc("Source from which the connection was attempted")
  source?: SourceOrTarget;

  @doc("target which connection was attempted")
  target?: SourceOrTarget;
}

@doc("Max and Min Threshold values for the metric")
model ExpectedValueRange {
  @doc("Min threshold value for the metric")
  min: float64;

  @doc("Max threshold value for the metric")
  max: float64;
}

@doc("ARM error code and error message associated with the impact")
model ErrorDetailProperties {
  @doc("ARM Error code associated with the impact.")
  errorCode?: string;

  @doc("ARM Error Message associated with the impact")
  errorMessage?: string;
}

@doc("Information about the impacted workload")
model Workload {
  @doc("the scenario for the workload")
  context?: string;

  @doc("Tool used to interact with Azure. SDK, AzPortal, etc.., Other")
  toolset?: Toolset;
}

@doc("Client incident details ex: incidentId , incident source")
model ClientIncidentDetails {
  @doc("Client incident id. ex : id of the incident created to investigate and address the impact if any.")
  clientIncidentId?: string;

  @doc("Client incident source. ex : source system name where the incident is created")
  clientIncidentSource?: IncidentSource;
}

@doc("List of incident interfaces.")
enum IncidentSource {
  /** When source of Incident is AzureDevops */
  AzureDevops,

  /** When source of Incident is Microsoft ICM */
  ICM,

  /** When source of Incident is Jira */
  Jira,

  /** When source of Incident is ServiceNow */
  ServiceNow,

  /** When source of Incident is Other */
  Other,
}

@doc("List of impact categories.")
enum ImpactCategoryEnum {
  /** Availability category */
  Availability,

  /** Performance category */
  Performance,

  /** Other category */
  Other,
}

@doc("List of azure interfaces.")
enum Toolset {
  /** If communication toolset is Terraform */
  Terraform,

  /** If communication toolset is Puppet */
  Puppet,

  /** If communication toolset is Chef */
  Chef,

  /** If communication toolset is SDK */
  SDK,

  /** If communication toolset is Ansible */
  Ansible,

  /** If communication toolset is ARM */
  ARM,

  /** If communication toolset is Portal */
  Portal,

  /** If communication toolset is Shell */
  Shell,

  /** If communication toolset is Other */
  Other,
}

#suppress "@azure-tools/typespec-azure-core/use-extensible-enum" "This really is a fixed enum"
@doc("Degree of confidence on the impact being a platform issue.")
@fixed
enum ConfidenceLevel {
  /** Low confidence on azure being the source of impact */
  Low,

  /** Medium confidence on azure being the source of impact */
  Medium,

  /** High confidence on azure being the source of impact */
  High,
}

@doc("List of unit of the metric.")
enum MetricUnit {
  /** When measurement is in ByteSeconds */
  ByteSeconds,

  /** When measurement is in Bytes */
  Bytes,

  /** When measurement is in BytesPerSecond */
  BytesPerSecond,

  /** When measurement is in Cores */
  Cores,

  /** When measurement is in Count */
  Count,

  /** When measurement is in CountPerSecond */
  CountPerSecond,

  /** When measurement is in MilliCores */
  MilliCores,

  /** When measurement is in MilliSeconds */
  MilliSeconds,

  /** When measurement is in NanoCores */
  NanoCores,

  /** When measurement is in Percent */
  Percent,

  /** When measurement is in Seconds */
  Seconds,

  /** When measurement is in Other than listed */
  Other,
}

@doc("List of protocols")
enum Protocol {
  /** When communication protocol is TCP */
  TCP,

  /** When communication protocol is UDP */
  UDP,

  /** When communication protocol is HTTP */
  HTTP,

  /** When communication protocol is HTTPS */
  HTTPS,

  /** When communication protocol is RDP */
  RDP,

  /** When communication protocol is FTP */
  FTP,

  /** When communication protocol is SSH */
  SSH,

  /** When communication protocol is Other */
  Other,
}

@doc("Resource details")
model SourceOrTarget {
  @doc("Azure resource id, example /subscription/{subscription}/resourceGroup/{rg}/Microsoft.compute/virtualMachine/{vmName}")
  @pattern("(\\/[0-9a-zA-Z]+)*")
  azureResourceId?: string;
}
