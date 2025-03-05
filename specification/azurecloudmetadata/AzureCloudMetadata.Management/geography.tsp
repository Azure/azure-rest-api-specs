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

/** Geography resource. */
@tenantResource
model Geography is ProxyResource<GeographyProperties> {
  @doc("The geography short id")
  @segment("geographies")
  @key("geographyShortId")
  @visibility(Lifecycle.Read)
  @pattern("^[a-zA-Z-]{2,5}$")
  @path
  name: string;
}

/** Geography details. */
model GeographyProperties {
  ...MetadataProperties;

  /** Name of geography. */
  fullName: string;

  /** State of geography. */
  state: GeographyState;

  /** Resource Id of parent cloud. */
  cloudResourceId: string;

  /** The provisioning state of resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

/** The valid state of geography. */
union GeographyState {
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
interface Geographies {
  get is ArmResourceRead<Geography>;
  list is ArmResourceListAtScope<Geography>;
}
