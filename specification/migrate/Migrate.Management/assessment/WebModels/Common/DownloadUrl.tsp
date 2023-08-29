@doc("Download URL for assessment report.")
model DownloadUrl {
    @doc("Hyperlink to download report.")
    @visibility("read")
    assessmentReportUrl?: string;

    @doc("Expiry date of download url.")
    @visibility("read")
    expirationTime?: utcDateTime;
}
