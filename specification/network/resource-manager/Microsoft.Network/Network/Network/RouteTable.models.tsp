import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Route table resource.
 */
@featureFile(Features.virtualNetwork)
model RouteTable is ResourceInstance<RouteTablePropertiesFormat> {
  @visibility(Lifecycle.Read)
  @path
  @key("routeTableName")
  @segment("routeTables")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

@@doc(RouteTable.name, "The name of the route table.");
@@doc(RouteTable.properties, "Properties of the route table.");
