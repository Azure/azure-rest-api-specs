import "./NetworkEnums.tsp";
import "../Common/StandardizedContracts/CommonModels.tsp";
import "../Common/StandardizedContracts/AssessedWorkloadProperties.tsp";
import "../Common/StandardizedContracts/CostComponent.tsp";
import "../Common/StandardizedContracts/ProductSupportStatus.tsp";

using Azure.ResourceManager;

namespace Microsoft.Migrate;

@doc("Recommendations for assessed network entities.")
model NetworkEntityRecommendations
  is Recommendations<
    MigrationIssues,
    MigrationSuitability,
    Skus<MigrationSuitability>
  > {
  @doc("Gets the list of migration guidelines applicable to this target.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  migrationGuidelines?: NetworkMigrationGuideline[];

  @doc("Gets the list of recommendation reasonings.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  recommendationReasonings?: NetworkRecommendationReasoning[];
}

@doc("Network migration guideline.")
model NetworkMigrationGuideline {
  @doc("Gets the guideline id.")
  guidelineId?: string;

  @doc("Gets the migration guideline category.")
  migrationGuidelineCategory?: NetworkMigrationGuidelineCategory;

  @doc("Gets the migration guideline context.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  migrationGuidelineContext?: MigrationGuidelineContext[];
}

@doc("Network migration guideline category.")
union NetworkMigrationGuidelineCategory {
  @doc("General network migration guideline.")
  General: "General",

  @doc("Topology migration guideline related to regional resiliency.")
  TopologyWithRegionalResiliencyGuideline: "TopologyWithRegionalResiliencyGuideline",

  @doc("Security-related network migration guideline.")
  Security: "Security",

  @doc("Performance-related network migration guideline.")
  Performance: "Performance",

  string,
}

@doc("Network recommendation reasoning.")
model NetworkRecommendationReasoning {
  @doc("Gets the reasoning id.")
  @visibility(Lifecycle.Read)
  reasoningId?: string;

  @doc("Gets the reasoning string.")
  @visibility(Lifecycle.Read)
  reasoningString?: string;

  @doc("Gets the context details.")
  @visibility(Lifecycle.Read)
  contextDetails?: string[];
}

@doc("Frontend IP configuration reference for a load balancer rule.")
model LbRuleFrontendIpConfig {
  @doc("The name of the frontend IP configuration.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("The IP address of the frontend IP configuration in IPv4 or IPv6 format.")
  @visibility(Lifecycle.Read)
  ipAddress?: string;
}

@doc("Health probe reference for a load balancer rule.")
model LbRuleHealthProbe {
  @doc("The name of the health probe.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("The protocol of the health probe.")
  @visibility(Lifecycle.Read)
  protocol?: LbProbeProtocol;

  @doc("The port for the health probe.")
  @visibility(Lifecycle.Read)
  port?: int32;
}

// ──────────────────────────────────────────────
// Application Gateway helper models
// ──────────────────────────────────────────────

@doc("Application gateway frontend IP configuration.")
model AppGwFrontendIpConfig {
  @doc("The name of the frontend IP configuration.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("The type of the frontend IP configuration indicating public or private.")
  @visibility(Lifecycle.Read)
  type?: AppGwType;

  @doc("The name of the public IP resource associated with this frontend IP configuration. Applicable for public frontends.")
  @visibility(Lifecycle.Read)
  publicIpName?: string;

  @doc("The IP address of the frontend IP configuration. For public frontends this is the public IP; for private frontends this is the private IP allocated from the application gateway's dedicated subnet.")
  @visibility(Lifecycle.Read)
  ipAddress?: string;
}

@doc("Application gateway backend address pool.")
model AppGwBackendAddressPool {
  @doc("The name of the backend address pool.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("ARM resource IDs of the backend targets (VMs, VMSS instances, or App Services) in this pool.")
  @visibility(Lifecycle.Read)
  workloadIds?: string[];
}

@doc("Application gateway backend settings.")
model AppGwBackendSettings {
  @doc("The name of the backend settings.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("The destination port on the backend.")
  @visibility(Lifecycle.Read)
  port?: int32;

  @doc("The protocol used to communicate with the backend.")
  @visibility(Lifecycle.Read)
  protocol?: AppGwProtocol;

  @doc("Request timeout in seconds. Acceptable values are from 1 second to 86400 seconds.")
  @visibility(Lifecycle.Read)
  requestTimeout?: int32;

  @doc("Host header to be sent to the backend servers.")
  @visibility(Lifecycle.Read)
  hostName?: string;
}

@doc("Application gateway listener.")
model AppGwListener {
  @doc("The name of the listener.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("The frontend IP configuration associated with this listener.")
  @visibility(Lifecycle.Read)
  frontendIpConfiguration?: AppGwFrontendIpConfig;

  @doc("The frontend port number.")
  @visibility(Lifecycle.Read)
  port?: int32;

  @doc("Protocol of the listener.")
  @visibility(Lifecycle.Read)
  protocol?: AppGwProtocol;

  @doc("Host name of the listener.")
  @visibility(Lifecycle.Read)
  hostName?: string;
}

@doc("Application gateway health probe.")
model AppGwHealthProbe {
  @doc("The name of the health probe.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("The protocol used for the probe.")
  @visibility(Lifecycle.Read)
  protocol?: AppGwProtocol;

  @doc("Host name to send the probe to.")
  @visibility(Lifecycle.Read)
  host?: string;

  @doc("Relative path of the probe. Valid path starts from '/'.")
  @visibility(Lifecycle.Read)
  path?: string;

  @doc("The probing interval in seconds.")
  @visibility(Lifecycle.Read)
  interval?: int32;

  @doc("The probe timeout in seconds.")
  @visibility(Lifecycle.Read)
  timeout?: int32;

  @doc("Custom port used for probing the backend servers.")
  @visibility(Lifecycle.Read)
  port?: int32;
}

@doc("Application gateway autoscale configuration.")
model AppGwAutoscaleConfiguration {
  @doc("Lower bound on number of Application Gateway capacity.")
  @visibility(Lifecycle.Read)
  minCapacity?: int32;

  @doc("Upper bound on number of Application Gateway capacity.")
  @visibility(Lifecycle.Read)
  maxCapacity?: int32;
}
