namespace Microsoft.Migrate;

@doc("Data model of Download URL for wave recommendation report.")
model DownloadUrl {
  @doc("Hyperlink to download report.")
  @visibility(Lifecycle.Read)
  waveRecommendationReportUrl: string;

  @doc("Expiry date of download url.")
  @visibility(Lifecycle.Read)
  expirationTime: utcDateTime;
}
