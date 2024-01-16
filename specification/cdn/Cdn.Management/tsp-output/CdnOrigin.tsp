import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./CdnEndpoint.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Cdn;
@doc("CDN origin is the source of the content being delivered via CDN. When the edge nodes represented by an endpoint do not have the requested content cached, they attempt to fetch it from one or more of the configured origins.")
@parentResource(CdnEndpoint)
model CdnOrigin is ProxyResource<OriginProperties> {
  @doc("Name of the origin which is unique within the endpoint.")
  @path
  @key("originName")
  @segment("origins")
  name: string;
}

@armResourceOperations
interface CdnOrigins {
  @doc("Gets an existing origin within an endpoint.")
  get is ArmResourceRead<CdnOrigin>;

  @doc("Creates a new origin within the specified endpoint.")
  create is ArmResourceCreateOrUpdateAsync<CdnOrigin>;

  @doc("Updates an existing origin within an endpoint.")
  update is ArmCustomPatchAsync<CdnOrigin, OriginUpdateParameters>;

  @doc("Deletes an existing origin within an endpoint.")
  delete is ArmResourceDeleteAsync<CdnOrigin>;

  @doc("Lists all of the existing origins within an endpoint.")
  listByEndpoint is ArmResourceListByParent<CdnOrigin>;
}

@@projectedName(CdnOrigins.create::parameters.resource, "json", "origin");
@@extension(CdnOrigins.create::parameters.resource,
  "x-ms-client-name",
  "origin"
);
@@doc(CdnOrigins.create::parameters.resource, "Origin properties");
@@projectedName(CdnOrigins.update::parameters.properties,
  "json",
  "originUpdateProperties"
);
@@extension(CdnOrigins.update::parameters.properties,
  "x-ms-client-name",
  "originUpdateProperties"
);
@@doc(CdnOrigins.update::parameters.properties, "Origin properties");
