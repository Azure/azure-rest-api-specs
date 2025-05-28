import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using Azure.Core;

namespace Products;

interface ProductOperations {
  @summary("GetProducts")
  @doc("Retrieves a list of products available in the marketplace catalog.")
  @get
  list is ResourceOperations.ResourceList<ProductSummary>;
}
