import "@typespec/rest";
import "../models/common.tsp";
import "../models/product.tsp";
import "../models/api.tsp";
import "../models/tag.tsp";

using TypeSpec.Http;
using DeveloperServicesAPI.Models;

namespace DeveloperServicesPublicAPI.Routes.Products;

//Routes

@route("/products")
@doc("List a collection of products.")
@get
op ListProducts(...ListParams): ApiResponse<Collection<Product>>;

@route("/products/{productId}")
@doc("Get the details of the product specified by its identifier.")
@get
op GetProduct(@path productId: string): ApiResponse<Product>;

@route("/products/{productId}/apis")
@doc("List a collection of products APIs.")
@get
op ListProductApis(
  @path productId: string,
  ...ListParams
): ApiResponse<Collection<Api>>;

@route("/products/{productId}/tags")
@doc("List a collection of products tags.")
@get
op ListProductTags(
  @path productId: string,
  ...ListParams
): ApiResponse<Collection<Tag>>;
