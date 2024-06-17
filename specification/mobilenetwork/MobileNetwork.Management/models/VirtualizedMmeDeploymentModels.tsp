import "@typespec/versioning";

import "../common/CommonModels.tsp";

using TypeSpec.Versioning;

namespace Microsoft.MobileNetwork;

@added(Versions.v2024_05_15_preview)
@doc("Virtualized MME Deployment Properties.")
model VirtualizedMmeDeploymentResourceProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Operational status")
  @visibility("read")
  operationalStatus?: OperationalStatus;

  @doc("Virtual Network Function (VNF) Agent instance managing this Virtualized MME")
  @visibility("read", "create")
  vnfAgent: VnfAgentDeploymentIdProperty;

  @doc("Azure for Operators 5G Core Release Version for Virtualized MME.")
  releaseVersion: ReleaseVersion;

  @doc("Virtualized MME parameters")
  @visibility("read", "create")
  parameters: VirtualizedMmeParameters;

  @doc("Virtualized MME non-builtin local users")
  additionalLocalUsernames?: AdditionalLocalUsername[];

  @doc("Managed On Behalf Of Configuration.")
  @visibility("read")
  managedOnBehalfOfConfiguration?: ManagedOnBehalfOfConfiguration;
}

@added(Versions.v2024_05_15_preview)
@doc("Virtualized MME Parameters")
scalar VirtualizedMmeParameters extends string;
