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

@doc("Custom Capture Configuration on a firewall (singleton). Sync child resource — caller polls GET to track pcapStatus until terminal (Success / Failed).")
@singleton("default")
@parentResource(FirewallResource)
@added(Versions.v2026_05_11_preview)
model CustomCaptureConfigurationsFirewallResource
  is Azure.ResourceManager.ProxyResource<
    CustomCaptureConfigurationsProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = CustomCaptureConfigurationsFirewallResource,
    KeyName = "customCaptureConfigurationName",
    SegmentName = "customCaptureConfigurations",
    NamePattern = ""
  >;
}

@added(Versions.v2026_05_11_preview)
@armResourceOperations
interface CustomCaptureConfigurationsFirewallResources {
  @doc("Get the current Custom Capture Configuration for a firewall. Always returns 200 OK + body. Caller reads properties.pcapStatus to know whether to keep polling. Body field properties.nextCheckInSeconds advises when to poll next (omitted on terminal states).")
  get is ArmResourceRead<CustomCaptureConfigurationsFirewallResource>;

  @doc("Start a Custom Capture Configuration on a firewall. SYNC — returns 200 OK + body immediately. Body's properties.pcapStatus reflects current state (typically InProgress). Caller polls GET on its own clock using properties.nextCheckInSeconds as the cadence hint.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<CustomCaptureConfigurationsFirewallResource>;

  @doc("Delete the Custom Capture Configuration on a firewall. SYNC — clears any in-progress or terminal capture state. Returns 200 on success or 204 when no configuration exists.")
  delete is ArmResourceDeleteSync<CustomCaptureConfigurationsFirewallResource>;

  @doc("List Custom Capture Configurations under a firewall. The resource is a singleton (name is fixed to 'default'), so the response contains at most one entry.")
  listByFirewall is ArmResourceListByParent<CustomCaptureConfigurationsFirewallResource>;
}
