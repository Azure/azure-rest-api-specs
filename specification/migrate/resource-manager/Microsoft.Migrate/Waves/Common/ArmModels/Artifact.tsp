import "../Enums/Enums.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.Migrate;

@doc("Request payload for generating an artifact upload URL.")
@added(ApiVersions.v2026_08_01_preview)
model ArtifactUploadUrlRequest {
  @doc("Relative path of the artifact content to upload.")
  path: string;
}

@doc("Artifact upload URL response.")
@added(ApiVersions.v2026_08_01_preview)
model ArtifactUploadUrlResponse {
  @doc("Relative path of the artifact content to upload.")
  path: string;

  @doc("URL for uploading artifact content.")
  uploadUrl: url;

  @doc("Expiration time for the upload URL.")
  expiresAt: utcDateTime;
}

@doc("Base request payload for generating an artifact download URL.")
@discriminator("mode")
@added(ApiVersions.v2026_08_01_preview)
model ArtifactDownloadUrlRequest {
  @doc("Artifact download mode.")
  mode: ArtifactDownloadMode;
}

@doc("Request payload for downloading an artifact directory.")
@added(ApiVersions.v2026_08_01_preview)
model ArtifactDirectoryDownloadUrlRequest extends ArtifactDownloadUrlRequest {
  @doc("Artifact download mode.")
  mode: ArtifactDownloadMode.Directory;

  @doc("Whether to include artifact metadata in the download.")
  includeMetadata?: boolean = false;
}

@doc("Request payload for downloading an artifact file.")
@added(ApiVersions.v2026_08_01_preview)
model ArtifactFileDownloadUrlRequest extends ArtifactDownloadUrlRequest {
  @doc("Artifact download mode.")
  mode: ArtifactDownloadMode.File;

  @doc("Relative path of the artifact file to download.")
  path: string;
}

@doc("Artifact download URL response.")
@added(ApiVersions.v2026_08_01_preview)
model ArtifactDownloadUrlResponse {
  @doc("Artifact download mode.")
  mode: ArtifactDownloadMode;

  @doc("Name of the artifact.")
  artifactName: string;

  @doc("Downloaded directory or file path.")
  path: string;

  @doc("URL for downloading artifact content.")
  downloadUrl: url;

  @doc("Expiration time for the download URL.")
  expiresAt: utcDateTime;
}
