import "@typespec/rest";
import "../../models/common.tsp";
import "../../models/product.tsp";
import "../../models/api.tsp";
import "../../models/tag.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Traits;
using DeveloperServicesApi.Models;

namespace DeveloperServicesPublicApi.Resources.Products;

interface Products {
  @doc("List a collection of products.")
  listProducts is ResourceList<
    ProductResource,
    ListQueryParametersTrait<DefaultListQueryParameters>
  >;

  @doc("Get the details of the product specified by its identifier.")
  getProduct is ResourceRead<ProductResource>;

  @doc("List a collection of products APIs.")
  listProductApis is ResourceList<
    ProductApiResource,
    ListQueryParametersTrait<DefaultListQueryParameters>
  >;

  @doc("List a collection of products tags.")
  listProductTags is ResourceList<
    ProductTagResource,
    ListQueryParametersTrait<DefaultListQueryParameters>
  >;
}

@doc("Product resource model.")
@resource("products")
model ProductResource extends Product {
  @doc("Product identifier.")
  @key("productId")
  @visibility("query")
  productId: string;
}

@doc("Product APIs resource model.")
@resource("apis")
@parentResource(ProductResource)
model ProductApiResource extends Api {
  @doc("Product identifier.")
  @key("apiId")
  @visibility("query")
  apiId: string;
}

@doc("Product tags resource model.")
@resource("tags")
@parentResource(ProductResource)
model ProductTagResource extends Tag {
  @doc("Product identifier.")
  @key("tagId")
  @visibility("query")
  tagId: string;
}
