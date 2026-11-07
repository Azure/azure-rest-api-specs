import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./shared-models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Route resource.
 */
@featureFile(Features.virtualNetwork)
@parentResource(RouteTable)
model Route is SubResourceInstance<RoutePropertiesFormat> {
  @visibility(Lifecycle.Read)
  @path
  @key("routeName")
  @segment("routes")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

@@doc(SubResourceModel.type, "Resource type.");
