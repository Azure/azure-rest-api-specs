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

/** Cloud resource. */
@tenantResource
model Cloud is ProxyResource<CloudProperties> {
  @doc("The cloud name")
  @segment("clouds")
  @key("cloudName")
  @visibility(Lifecycle.Read)
  @pattern("^[a-zA-Z-]{3,24}$")
  @path
  name: string;
}

/** Cloud details. */
model CloudProperties {
  ...MetadataProperties;

  /** Environment type of cloud. */
  environmentType: EnvironmentType;

  /** State of cloud. */
  state: CloudState;

  /** The provisioning state of resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

/** The cloud environment type. */
union EnvironmentType {
  /** This is a Public cloud */
  Public: "Public",

  /** This is a Sovereign cloud */
  Sovereign: "Sovereign",

  /** This is an Airgapped cloud */
  Airgapped: "Airgapped",

  string,
}

/** The valid state of cloud. */
union CloudState {
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
interface Clouds {
  get is ArmResourceRead<Cloud>;
  list is ArmResourceListAtScope<Cloud>;
}
