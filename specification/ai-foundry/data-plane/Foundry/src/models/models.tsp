import "../common/models.tsp";
import "../common/service.tsp";

using TypeSpec.Rest;

namespace Azure.AI.Projects;

@doc("Model Version Definition")
@Rest.resource("models")
model ModelVersion {
  @doc("System related metadata")
  systemData?: Record<string>;

  @doc("Catalog information for the model")
  catalogInfo: ModelCatalogInformation;

  @doc("Derived model information")
  derivedModelInformation?: DerivedModelInformation;

  ...AssetBase;
}

@doc("Catalog information for the model")
model ModelCatalogInformation {
  @doc("The id of the publisher of the asset")
  publisherId: string;

  @doc("The license the asset is under")
  license: string;
}

@doc("Derived model information")
model DerivedModelInformation {
  @doc("Base model name")
  baseModel: string;
}
