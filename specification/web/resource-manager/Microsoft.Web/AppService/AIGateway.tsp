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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@added(Versions.v2026_03_01_preview)
@doc("The properties of an AI gateway.")
model AiGatewayProperties {
  @doc("The description of the resource.")
  @visibility(Lifecycle.Read)
  aiGatewayId?: string;
}

@added(Versions.v2026_03_01_preview)
@doc("An AI gateway resource.")
model AiGateway is Azure.ResourceManager.TrackedResource<AiGatewayProperties> {
  @key("name")
  @segment("aigateways")
  @doc("The name of the AI gateway")
  @path
  @pattern("[a-zA-Z0-9_.()-]{0,79}$")
  name: string;
}

@added(Versions.v2026_03_01_preview)
@armResourceOperations
@doc("The operations of AI gateways.")
interface AiGateways {
  get is ArmResourceRead<AiGateway>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<AiGateway>;
  patch is ArmTagsPatchSync<AiGateway>;
  delete is ArmResourceDeleteSync<AiGateway>;
  listBySubscription is ArmListBySubscription<AiGateway>;
  listByResourceGroup is ArmResourceListByParent<
    AiGateway,
    Azure.ResourceManager.Foundations.BaseParameters<AiGateway> &
      Azure.Core.StandardListQueryParameters &
      Azure.Core.FilterQueryParameter &
      Azure.Core.SelectQueryParameter &
      Azure.Core.ExpandQueryParameter &
      Azure.Core.OrderByQueryParameter
  >;
}
