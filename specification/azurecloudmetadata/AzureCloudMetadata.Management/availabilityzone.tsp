import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.AzureCloudMetadata;

/** Availability resource. */
@tenantResource
model AvailabilityZone is ProxyResource<AvailabilityProperties> {
  @doc("The AvailabilityZone name")
  @segment("availabilityZones")
  @key("zoneName")
  @visibility(Lifecycle.Read)
  @pattern("^[a-z0-9]{2,20}-AZ[0-9]{2}$")
  @path
  name: string;
}

/** Availability details. */
model AvailabilityProperties {
  ...MetadataProperties;

  /** State of the AvailabilityZone. */
  state: AvailabilityZoneState;

  /** List of PilotFish Clusters of the AvailabilityZone. */
  pfClusters: string[];

  /** List of artifact datacenters of the AvailabilityZone. */
  artifactDatacenters: string[];

  /** Resource Id of parent */
  regionResourceId: string;

  /** Future changes of region. */
  @added(Versions.v2025_10_01_preview)
  futureChanges: string;

  /** The provisioning state of resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

/** The valid states availabilityZone. */
union AvailabilityZoneState {
  /** The resource is being proposed */
  Proposed: "Proposed",

  /** The resource is approved */
  Approved: "Approved",

  /** The resource is on hold */
  OnHold: "On Hold",

  /** The resource is in buildout */
  Buildout: "Buildout",

  /** The resource is ready in production with a Service-Level agreement */
  ProductionSLA: "Production SLA",

  /** The resource is in decommissioning */
  Decommissioning: "Decommissioning",

  /** The resource is retired */
  Retired: "Retired",

  /** The resource is cancelled */
  Cancelled: "Cancelled",

  string,
}

@armResourceOperations
interface AvailabilityZones {
  get is ArmResourceRead<AvailabilityZone>;
  list is ArmResourceListAtScope<AvailabilityZone>;
}
