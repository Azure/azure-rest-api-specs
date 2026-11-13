// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./models-jobs.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Quantum.Workspace;

/** The existing job creation properties, without client-supplied storage locations. */
#suppress "@azure-tools/typespec-autorest/unsupported-multipart-type" "Swagger 2 cannot represent a structured JSON multipart part; it emits properties as a string. Keep the typed JSON model for direct TypeSpec SDK generation."
@added(QuantumWorkspaceAPIVersion.v2026_11_01_preview)
model JobCreateProperties {
  ...Create<{
    ...JobDetails;
  }>;
}

/** A job submission. Properties precede input, which is streamed as bytes rather than base64. */
@added(QuantumWorkspaceAPIVersion.v2026_11_01_preview)
model JobSubmission {
  /** The JSON job properties, sent as the first part with Content-Type application/json. */
  properties: HttpPart<JobCreateProperties>;

  /** The binary input, sent as the second part. */
  input: HttpPart<TypeSpec.Http.File<"application/octet-stream">>;
}

/** The job ID is already committed to a different submission, or equivalence cannot be verified. */
@added(QuantumWorkspaceAPIVersion.v2026_11_01_preview)
@error
model JobSubmissionConflictResult {
  /** The existing committed job cannot be replaced. */
  @statusCode
  statusCode: 409;

  ...Azure.Core.Foundations.ErrorResponse;
}

/** A reference to a customer-readable job artifact. */
@added(QuantumWorkspaceAPIVersion.v2026_11_01_preview)
model JobArtifact {
  /**
   * The hierarchical artifact-relative path, such as diagnostics/logs/run.txt.
   * Use this value as the path parameter when retrieving the artifact.
   */
  id: string;
}

/** A page of customer-readable artifact references. */
@added(QuantumWorkspaceAPIVersion.v2026_11_01_preview)
model ArtifactListResult {
  /** The artifact references on this page. */
  @pageItems
  value: JobArtifact[];

  /** The opaque link to the next page, omitted on the final page. */
  @nextLink
  nextLink?: url;
}

/** Raw file bytes and representation headers, streamed through the service. */
@added(QuantumWorkspaceAPIVersion.v2026_11_01_preview)
model JobFileResult {
  /** The file was read successfully. */
  @statusCode
  statusCode: 200;

  /** The raw file payload with its actual media type. */
  @bodyRoot
  file: TypeSpec.Http.File;

  /** The length of the returned file contents in bytes. */
  @header("Content-Length")
  contentLength: int64;

  /** The quoted entity tag of the returned file revision. */
  @header("ETag")
  eTag: string;

  /** The HTTP date when the file was last modified. */
  @header("Last-Modified")
  lastModified: string;

  /** The content encoding, when the stored file is encoded. */
  @header("Content-Encoding")
  contentEncoding?: string;

  /** Prevents caching of job data. */
  @header("Cache-Control")
  cacheControl: "no-store";
}
