import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@typespec/versioning";

import "../common/CommonModels.tsp";

using Azure.Core;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.MobileNetwork;

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "For backward compatibility."
@removed(Versions.v2024_06_01)
@doc("Whether to enable metrics ingestion for this radio access network. NOTE: this creates a metrics ingestion endpoint extension resource which introduces additional charges.")
union MetricsIngestionEnabled {
  @doc("Don't enable metrics ingestion.")
  Disabled: "Disabled",

  @doc("Enable metrics ingestion.")
  Enabled: "Enabled",
}

@removed(Versions.v2024_06_01)
@doc("Radio access network properties.")
model RadioAccessNetworkProperties {
  @doc("The provisioning state of the radio access network resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Site in which this radio access network is deployed.")
  site: SiteResourceId;

  @doc("Metrics ingestion configuration.")
  metricsIngestion?: MetricsIngestion;

  @doc("A list of Access Points for this radio access network.")
  @extension("x-ms-identifiers", [])
  accessPoints?: AccessPoint[];
}

@removed(Versions.v2024_06_01)
@doc("Metrics ingestion properties.")
model MetricsIngestion {
  @doc("Whether to enable metrics ingestion for this radio access network. NOTE: this creates a metrics ingestion endpoint extension resource which introduces additional charges.")
  enabled?: MetricsIngestionEnabled = MetricsIngestionEnabled.Disabled;
}

@removed(Versions.v2024_06_01)
@doc("Access Point properties.")
model AccessPoint {
  @doc("The name of this access point.")
  name: string;

  @doc("The geographic location of this access point.")
  location?: GeoLocation;
}

@removed(Versions.v2024_06_01)
@doc("A geographic location.")
model GeoLocation {
  @doc("A latitude between -90 and 90.")
  @maxValue(90)
  @minValue(-90)
  latitude: float32;

  @doc("A longitude between -180 and 180.")
  @maxValue(180)
  @minValue(-180)
  longitude: float32;
}
