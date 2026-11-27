import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./FirewallResource.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace PaloAltoNetworks.Cloudngfw;

@doc("AI Gateway log settings on an AIRSM firewall (singleton — the name is always 'default'). The firewall must be in AIRSM mode and have a user-assigned managed identity. Sync child resource — PUT/GET/DELETE forward to the partner synchronously.")
@singleton("default")
@parentResource(FirewallResource)
@added(Versions.v2026_11_27_preview)
model AiGatewayLogSettingsResource is Azure.ResourceManager.ProxyResource<
  AiGatewayLogSettingsProperties,
  false
> {
  ...ResourceNameParameter<
    Resource = AiGatewayLogSettingsResource,
    KeyName = "aiGatewayLogSettingsName",
    SegmentName = "aiGatewayLogSettings",
    NamePattern = ""
  >;
}

@added(Versions.v2026_11_27_preview)
@armResourceOperations
interface AiGatewayLogSettingsResources {
  @doc("Get the AI Gateway log settings for a firewall. Returns 200 OK with the current settings, or 404 when they have not been configured.")
  get is ArmResourceRead<AiGatewayLogSettingsResource>;

  @doc("Create or update the AI Gateway log settings for a firewall. SYNC — forwards to the partner and returns the persisted settings.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AiGatewayLogSettingsResource>;

  @doc("Delete the AI Gateway log settings for a firewall. SYNC — returns 200 on success or 204 when nothing is configured.")
  delete is ArmResourceDeleteSync<AiGatewayLogSettingsResource>;

  @doc("List the AI Gateway log settings under a firewall. The resource is a singleton (name is fixed to 'default'), so the response contains at most one entry.")
  listByFirewall is ArmResourceListByParent<AiGatewayLogSettingsResource>;
}
