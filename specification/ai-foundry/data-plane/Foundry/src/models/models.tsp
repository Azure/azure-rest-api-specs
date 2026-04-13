import "../common/models.tsp";
import "../common/service.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

@added(Versions.v1)
@doc("Model Version Definition")
@Rest.resource("models")
model ModelVersion {
  @doc("System related metadata")
  systemData?: SystemDataV3;

  @doc("URI of the model artifact in blob storage")
  blobUri?: string;

  @doc("Derived model information")
  derivedModelInformation?: DerivedModelInformation;

  ...AssetBase;
}

@added(Versions.v1)
@doc("System metadata for a resource")
model SystemDataV3 {
  @doc("Timestamp of resource creation")
  createdAt?: utcDateTime;

  @doc("Identity that created the resource")
  createdBy?: string;

  @doc("Type of identity that created the resource")
  createdByType?: string;

  @doc("Timestamp of last resource modification")
  lastModifiedAt?: utcDateTime;
}

@added(Versions.v1)
@doc("Derived model information")
model DerivedModelInformation {
  @doc("Base model asset ID")
  baseModel: string;
}
