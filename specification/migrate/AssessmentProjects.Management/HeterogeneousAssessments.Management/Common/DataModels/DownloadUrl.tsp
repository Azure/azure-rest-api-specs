namespace Microsoft.Migrate;

@doc("Data model of Download URL for assessment report.")
model DownloadUrl {
  @doc("Hyperlink to download report.")
  @visibility(Lifecycle.Read)
  assessmentReportUrl: string;

  @doc("Expiry date of download url.")
  @visibility(Lifecycle.Read)
  expirationTime: utcDateTime;
}
