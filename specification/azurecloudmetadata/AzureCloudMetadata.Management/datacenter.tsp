import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";
import "./cloud.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.AzureCloudMetadata;

/** DataCenter resource. */
@tenantResource
@parentResource(Cloud)
model DataCenter is ProxyResource<DataCenterProperties> {
  @doc("The DataCenter name")
  @segment("datacenters")
  @key("datacenterName")
  @visibility(Lifecycle.Read)
  @pattern("^[a-zA-Z]{2,5}[0-9]{0,3}$")
  @path
  name: string;
}

/** DataCenter details. */
model DataCenterProperties {
  ...MetadataProperties;

  /** State of the DataCenter. */
  state: DataCenterState;

  /** Tenant of the DataCenter. */
  tenants: Tenant[];

  /** Resource Id of parent region. */
  regionResourceId: string;

  /** Resource Id of parent availabilityZone. */
  availabilityZoneResourceId?: string;

  /** Name of the PhysicalDatacenter of the DataCenter. */
  physicalDatacenterId?: string;

  /** Common name of the DataCenter. */
  commonName?: string;

  /** AvailabilityZone Exceptions of the DataCenter. */
  azExceptions?: AZException[];

  /** The provisioning state of resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

/** Valid AvailabilityZone Exceptions. */
union AZException {
  /** The Datacenter has an Isolation exception to its parent availability zone. */
  Isolation: "Isolation",

  /** The Datacenter has a Latency exception to its parent availability zone. */
  Latency: "Latency",

  string,
}

/** Valid tenants for DataCenters. */
union Tenant {
  /** The Tenant type is Azure. */
  Azure: "Azure",

  /** The Tenant type is PilotFish. */
  PilotFish: "PilotFish",

  /** The Tenant type is Exchange. */
  Exchange: "Exchange",

  /** The Tenant type is Office365. */
  Office365: "Office365",

  /** The Tenant type is Bing. */
  Bing: "Bing",

  /** The Tenant type is Region Network Gateway. */
  RNG: "RNG",

  /** The Tenant type is Availability Zone Network Gateway. */
  AZNG: "AZNG",

  /** The Tenant type is OneFleetEdge. */
  OneFleetEdge: "OneFleetEdge",

  string,
}

/** Valid Datacenter State. */
union DataCenterState {
  /** The Datacenter is Proposed. */
  Proposed: "Proposed",

  /** The Datacenter is Approved. */
  Approved: "Approved",

  /** The Datacenter is Cancelled. */
  Cancelled: "Cancelled",

  /** The Datacenter is On Hold. */
  OnHold: "On Hold",

  /** The Datacenter is Buildout. */
  Buildout: "Buildout",

  /** The Datacenter is ready in production with a Service-Level agreement. */
  ProductionSLA: "Production SLA",

  /** The Datacenter is Decommissioning. */
  Decommissioning: "Decommissioning",

  /** The Datacenter is Retired. */
  Retired: "Retired",

  /** The Datacenter state is Unknown. */
  Unknown: "Unknown",

  string,
}

@armResourceOperations
interface DataCenters {
  get is ArmResourceRead<DataCenter>;
  listByCloud is ArmResourceListByParent<DataCenter>;
}
