import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "../main.tsp";
import "@typespec/openapi";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

@doc("Model Version Definition")
@Rest.resource("models")
@added(Versions.v1)
model ModelVersion {
  @doc("System related metadata")
  @visibility(Lifecycle.Read)
  systemData?: SystemData;

  @doc("Catalog information for the model")
  catalogInfo: ModelCatalogInformation;

  @doc("Derived model information")
  derivedModelInformation?: DerivedModelInformation;

  ...AssetBase;
}

@doc("Derived model information")
model DerivedModelInformation {
  @doc("Base model")
  baseModel: string;
}

@doc("Catalog information for the model")
model ModelCatalogInformation {
    ...CatalogInformation;  
}