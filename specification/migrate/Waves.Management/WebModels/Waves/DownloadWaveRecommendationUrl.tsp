import "@typespec/versioning";
using TypeSpec.Versioning;

namespace Microsoft.Migrate;

@doc("Data model of Download URL for wave recommendation report.")
@added(ApiVersions.v2025_12_01_preview)
model DownloadWaveRecommendationUrl {
  @doc("Hyperlink to download report.")
  @visibility(Lifecycle.Read)
  waveRecommendationReportUrl: string;

  @doc("Expiry date of download url.")
  @visibility(Lifecycle.Read)
  expirationTime: utcDateTime;
}
