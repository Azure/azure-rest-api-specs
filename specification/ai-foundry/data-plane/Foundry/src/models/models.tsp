import "../common/models.tsp";
import "../common/service.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

@doc("Model Version Definition")
@Rest.resource("models")
model ModelVersion {
  @doc("System related metadata")
  system_data?: SystemDataV3;

  @doc("URI of the model artifact in blob storage")
  blobUri?: url;

  @doc("Derived model information")
  derivedModelInformation?: DerivedModelInformation;

  ...AssetBase;
}

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

@doc("Derived model information")
model DerivedModelInformation {
  @doc("Base model asset ID")
  baseModel: string;
}

@doc("Accepted response for asynchronous model version creation, with polling location.")
model CreateModelVersionAsyncResponse {
  @statusCode statusCode: 202;

  @doc("URL to poll for operation status.")
  @header("Location")
  location: string;
}
