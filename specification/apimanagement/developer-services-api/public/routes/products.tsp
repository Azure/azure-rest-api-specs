import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "../../models/common.tsp";
import "../../models/product.tsp";
import "../../models/api.tsp";
import "../../models/tag.tsp";

using TypeSpec.Http;
using Azure.Core;
using DeveloperServicesApi.Models;

namespace DeveloperServicesPublicApi.Routes.Products;

@route("/products")
@doc("List a collection of products.")
@get
op ListProducts(...ListParams): ApiResponse<Page<Product>>;

@route("/products/{productId}")
@doc("Get the details of the product specified by its identifier.")
@get
op GetProduct(
  @doc("The product identifier.")
  @path
  productId: string
): ApiResponse<Product>;

@route("/products/{productId}/apis")
@doc("List a collection of products APIs.")
@get
op ListProductApis(
  @doc("The product identifier.")
  @path
  productId: string,
  ...ListParams
): ApiResponse<Page<Api>>;

@route("/products/{productId}/tags")
@doc("List a collection of products tags.")
@get
op ListProductTags(
  @doc("The product identifier.")
  @path
  productId: string,
  ...ListParams
): ApiResponse<Page<Tag>>;
