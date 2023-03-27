import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "../../models/common.tsp";
import "../../models/product.tsp";
import "../../models/api.tsp";
import "../../models/tag.tsp";

using TypeSpec.Http;
using Azure.Core;
using DeveloperServicesApi.Models;

namespace DeveloperServicesAuthorizedApi.Routes.Products;

@route("/users/{userId}/products")
@doc("List a collection of products.")
@get
op ListProducts(...UserParams, ...ListParams): ApiResponse<Page<Product>>;

@route("/users/{userId}/products/{productId}")
@doc("Get the details of the product specified by its identifier.")
@get
op GetProduct(...UserParams, @path productId: string): ApiResponse<Product>;

@route("/users/{userId}/products/{productId}/apis")
@doc("List a collection of products APIs.")
@get
op ListProductApis(
  ...UserParams,
  @path productId: string,
  ...ListParams
): ApiResponse<Page<Api>>;

@route("/users/{userId}/products/{productId}/tags")
@doc("List a collection of products tags.")
@get
op ListProductTags(
  ...UserParams,
  @path productId: string,
  ...ListParams
): ApiResponse<Page<Tag>>;
