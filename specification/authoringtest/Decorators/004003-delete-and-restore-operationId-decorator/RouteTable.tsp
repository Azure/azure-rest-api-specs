import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";
import "./models.tsp";

using Azure.ResourceManager;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.Network;

#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Fixture parent resource for Route."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Fixture parent resource for Route."
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Fixture parent resource for Route."
@Http.Private.includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model RouteTable extends Resource {
  properties?: RouteTablePropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("routeTableName")
  @segment("routeTables")
  name: string;

  @visibility(Lifecycle.Read)
  etag?: string;
}
