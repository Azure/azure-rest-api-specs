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

@doc("Log Ingestion Settings on a firewall (singleton — the name is always 'default'). This is the modern Azure Monitor Log Ingestion (Data Collection Rule based) surface that supersedes the legacy getLogProfile/saveLogProfile actions. Sync child resource — PUT/GET/DELETE forward to the partner synchronously; the caller does not poll a long-running operation.")
@singleton("default")
@parentResource(FirewallResource)
@added(Versions.v2026_07_29_preview)
model LogIngestionSettingsResource is Azure.ResourceManager.ProxyResource<
  LogIngestionSettingsProperties,
  false
> {
  ...ResourceNameParameter<
    Resource = LogIngestionSettingsResource,
    KeyName = "logIngestionSettingsName",
    SegmentName = "logIngestionSettings",
    NamePattern = ""
  >;
}

@added(Versions.v2026_07_29_preview)
@armResourceOperations
interface LogIngestionSettingsResources {
  @doc("Get the Log Ingestion Settings for a firewall. Live read from the partner. Returns 200 OK with the current settings, or 404 when log ingestion has not been configured.")
  get is ArmResourceRead<LogIngestionSettingsResource>;

  @doc("Create or update the Log Ingestion Settings for a firewall. SYNC — forwards to the partner and returns 200 OK (or 201 Created on first create) with the persisted settings. commonDestination.monitorConfigurationsV2 (dcrId, logIngestionEndpoint, dcrImmutableId, streamName) drives where the firewall logs are ingested.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<LogIngestionSettingsResource>;

  @doc("Delete (clear) the Log Ingestion Settings for a firewall. SYNC — soft-clears the DCR destination on the partner (logs have no partner delete API). Returns 200 on success or 204 when nothing is configured.")
  delete is ArmResourceDeleteSync<LogIngestionSettingsResource>;

  @doc("List the Log Ingestion Settings under a firewall. The resource is a singleton (name is fixed to 'default'), so the response contains at most one entry.")
  listByFirewall is ArmResourceListByParent<LogIngestionSettingsResource>;
}
