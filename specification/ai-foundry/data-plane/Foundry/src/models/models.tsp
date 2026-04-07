import "../common/models.tsp";
import "../common/service.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("Model Version Definition")
@Rest.resource("models")
model ModelVersion {
  @doc("System related metadata")
  systemData?: Record<string>;

  @doc("URI of the model artifact in blob storage")
  blobUri?: string;

  @doc("Derived model information")
  derivedModelInformation?: DerivedModelInformation;

  @doc("Deployment templates allowed for this model")
  allowedDeploymentTemplates?: string[];

  ...AssetBase;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("Derived model information")
model DerivedModelInformation {
  @doc("Base model name")
  baseModel: string;
}
