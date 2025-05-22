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
union IncidentSource {
  string,

  /** When source of Incident is AzureDevops */
  AzureDevops: "AzureDevops",

  /** When source of Incident is Microsoft ICM */
  ICM: "ICM",

  /** When source of Incident is Jira */
  Jira: "Jira",

  /** When source of Incident is ServiceNow */
  ServiceNow: "ServiceNow",

  /** When source of Incident is Other */
  Other: "Other",
}

@doc("List of impact categories.")
union ImpactCategoryEnum {
  string,

  /** Availability category */
  Availability: "Availability",

  /** Performance category */
  Performance: "Performance",

  /** Other category */
  Other: "Other",
}

@doc("List of azure interfaces.")
union Toolset {
  string,

  /** If communication toolset is Terraform */
  Terraform: "Terraform",

  /** If communication toolset is Puppet */
  Puppet: "Puppet",

  /** If communication toolset is Chef */
  Chef: "Chef",

  /** If communication toolset is SDK */
  SDK: "SDK",

  /** If communication toolset is Ansible */
  Ansible: "Ansible",

  /** If communication toolset is ARM */
  ARM: "ARM",

  /** If communication toolset is Portal */
  Portal: "Portal",

  /** If communication toolset is Shell */
  Shell: "Shell",

  /** If communication toolset is Other */
  Other: "Other",
}

#suppress "@azure-tools/typespec-azure-core/use-extensible-enum" "This really is a fixed enum"
@doc("Degree of confidence on the impact being a platform issue.")
union ConfidenceLevel {
  string,

  /** Low confidence on azure being the source of impact */
  Low: "Low",

  /** Medium confidence on azure being the source of impact */
  Medium: "Medium",

  /** High confidence on azure being the source of impact */
  High: "High",
}

@doc("List of unit of the metric.")
union MetricUnit {
  string,

  /** When measurement is in ByteSeconds */
  ByteSeconds: "ByteSeconds",

  /** When measurement is in Bytes */
  Bytes: "Bytes",

  /** When measurement is in BytesPerSecond */
  BytesPerSecond: "BytesPerSecond",

  /** When measurement is in Cores */
  Cores: "Cores",

  /** When measurement is in Count */
  Count: "Count",

  /** When measurement is in CountPerSecond */
  CountPerSecond: "CountPerSecond",

  /** When measurement is in MilliCores */
  MilliCores: "MilliCores",

  /** When measurement is in MilliSeconds */
  MilliSeconds: "MilliSeconds",

  /** When measurement is in NanoCores */
  NanoCores: "NanoCores",

  /** When measurement is in Percent */
  Percent: "Percent",

  /** When measurement is in Seconds */
  Seconds: "Seconds",

  /** When measurement is in Other than listed */
  Other: "Other",
}

@doc("List of protocols")
union Protocol {
  string,

  /** When communication protocol is TCP */
  TCP: "TCP",

  /** When communication protocol is UDP */
  UDP: "UDP",

  /** When communication protocol is HTTP */
  HTTP: "HTTP",

  /** When communication protocol is HTTPS */
  HTTPS: "HTTPS",

  /** When communication protocol is RDP */
  RDP: "RDP",

  /** When communication protocol is FTP */
  FTP: "FTP",

  /** When communication protocol is SSH */
  SSH: "SSH",

  /** When communication protocol is Other */
  Other: "Other",
}

@doc("Resource details")
model SourceOrTarget {
  @doc("Azure resource id, example /subscription/{subscription}/resourceGroup/{rg}/Microsoft.compute/virtualMachine/{vmName}")
  @pattern("(\\/[0-9a-zA-Z]+)*")
  azureResourceId?: string;
}
