import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;
using Azure.ResourceManager.Foundations;
using Azure.ResourceManager.CommonTypes;

namespace Microsoft.ApplicationMigration;

@doc("The top level management resource for Application Discovery.")
model DiscoveryHub
  is Azure.ResourceManager.TrackedResource<DiscoveryHubProperties> {
  ...ResourceNameParameter<
    Resource = DiscoveryHub,
    KeyName = "discoveryHubName",
    SegmentName = "discoveryHubs",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

@doc("The properties of the DiscoveryHub resource.")
model DiscoveryHubProperties {
  @doc("The status of the DiscoveryHub resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The masterSite identifier associated with the discovery hub.")
  @added(Microsoft.ApplicationMigration.Versions.v2026_01_01_preview)
  masterSiteId?: Azure.Core.armResourceIdentifier;

  @doc("Application discovery settings and runtime status.")
  @added(Microsoft.ApplicationMigration.Versions.v2026_01_01_preview)
  appDiscovery?: AppDiscoveryState;
}

@doc("Application discovery settings and runtime status.")
@added(Microsoft.ApplicationMigration.Versions.v2026_01_01_preview)
model AppDiscoveryState {
  @doc("Indicates whether the application discovery feature is enabled or disabled.")
  featureState?: AppDiscoveryFeatureState;

  @doc("The current operational status of application discovery.")
  @visibility(Lifecycle.Read)
  status?: AppDiscoveryStatus;

  @doc("The timestamp when discovery was last attempted.")
  @visibility(Lifecycle.Read)
  lastAttemptedTime?: utcDateTime;

  @doc("Errors encountered during the most recent discovery operation.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  errors?: Azure.ResourceManager.Foundations.ErrorDetail[];

  @doc("Summary of the current or most recent discovery operation.")
  @visibility(Lifecycle.Read)
  summary?: AppDiscoverySummary;
}

@doc("The operational status of application discovery.")
@added(Microsoft.ApplicationMigration.Versions.v2026_01_01_preview)
union AppDiscoveryStatus {
  @doc("Application discovery has not been started.")
  NotStarted: "NotStarted",

  @doc("Application discovery is in progress.")
  InProgress: "InProgress",

  @doc("Application discovery has completed successfully.")
  Completed: "Completed",

  @doc("Application discovery has failed.")
  Failed: "Failed",

  string,
}

@doc("The feature state of application discovery.")
@added(Microsoft.ApplicationMigration.Versions.v2026_01_01_preview)
union AppDiscoveryFeatureState {
  @doc("Application discovery feature is enabled.")
  Enabled: "Enabled",

  @doc("Application discovery feature is disabled.")
  Disabled: "Disabled",

  string,
}

@doc("Request model for the auto-discover applications operation.")
@added(Microsoft.ApplicationMigration.Versions.v2026_01_01_preview)
model AutoDiscoverAppsRequest {
  @doc("Flag to force rediscovery even if discovery was already completed.")
  forceDiscover?: boolean;
}

@doc("Progress tracking information for application discovery.")
@added(Microsoft.ApplicationMigration.Versions.v2026_01_01_preview)
model AppDiscoverySummary {
  @doc("Percentage of machines that have been processed for application discovery.")
  @minValue(0)
  @maxValue(100)
  machineProcessingPercentage?: float32;

  @doc("The start time of the auto app discovery operation.")
  startTime?: utcDateTime;

  @doc("The end time the auto app discovery operation.")
  endTime?: utcDateTime;

  @doc("Total number of applications discovered so far.")
  @minValue(0)
  discoveredApplications?: int32;

  @doc("Percentage of machines that have been identified as part of applications.")
  @minValue(0)
  @maxValue(100)
  machineCoveragePercentage?: float32;

  @doc("Total number of machines being processed for discovery.")
  @minValue(0)
  totalMachines?: int32;

  @doc("Number of machines that have been processed.")
  @minValue(0)
  processedMachines?: int32;

  @doc("Number of machines that are part of discovered applications.")
  @minValue(0)
  machinesInApplications?: int32;
}
