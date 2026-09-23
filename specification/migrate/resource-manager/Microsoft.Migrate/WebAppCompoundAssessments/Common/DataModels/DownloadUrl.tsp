namespace Microsoft.Migrate;

@doc("Data model of Download URL for assessment report.")
model DownloadUrl {
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Name kept for backward compatibility"
  @doc("Hyperlink to download report.")
  @visibility(Lifecycle.Read)
  assessmentReportUrl: string;

  @doc("Expiry date of download url.")
  @visibility(Lifecycle.Read)
  expirationTime: utcDateTime;
}
