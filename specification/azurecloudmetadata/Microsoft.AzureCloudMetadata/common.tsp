import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

scalar ParentResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "string",
    }
  ]>;

/** Valid states for cloud or geography. */
union State {
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

/** Basic properties of medadata resources. */
model MetadataProperties {
  /** Guid of the resource. */
  guid: string;

  /** Short id of the resource */
  @pattern("^[a-zA-Z-]{2,6}$")
  shortId: string;

  /** Index of the resource */
  @minValue(1)
  @maxValue(9999)
  index: int32;
}
