import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Web;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Matching AiGateway pattern - no provisioning state"
@added(Versions.v2026_05_01_preview)
@doc("The properties of a connector gateway.")
model ConnectorGatewayProperties {
  @doc("The description of the resource.")
  @visibility(Lifecycle.Read)
  connectorGatewayId?: string;
}

@added(Versions.v2026_05_01_preview)
@doc("A connector gateway resource.")
model ConnectorGateway
  is Azure.ResourceManager.TrackedResource<ConnectorGatewayProperties> {
  @key("name")
  @segment("connectorgateways")
  @doc("The name of the connector gateway")
  @path
  @pattern("[a-zA-Z0-9_.()-]{0,79}$")
  name: string;
}

@added(Versions.v2026_05_01_preview)
@armResourceOperations
@doc("The operations of connector gateways.")
interface ConnectorGateways {
  get is ArmResourceRead<ConnectorGateway>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<ConnectorGateway>;
  patch is ArmTagsPatchSync<ConnectorGateway>;
  delete is ArmResourceDeleteSync<ConnectorGateway>;
  listBySubscription is ArmListBySubscription<ConnectorGateway>;
  listByResourceGroup is ArmResourceListByParent<
    ConnectorGateway,
    Azure.ResourceManager.Foundations.BaseParameters<ConnectorGateway> &
      Azure.Core.StandardListQueryParameters &
      Azure.Core.FilterQueryParameter &
      Azure.Core.SelectQueryParameter &
      Azure.Core.ExpandQueryParameter &
      Azure.Core.OrderByQueryParameter
  >;
}
