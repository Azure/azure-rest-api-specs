// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./operations.tsp";
import "../common/models-job-storage.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Quantum.Workspace.Services;

/** Job-scoped access to customer-readable files. Workspace and job authorization still apply. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job-scoped binary transfer and artifact reference listing use custom ResourceOperation signatures rather than JSON job CRUD."
@added(QuantumWorkspaceAPIVersion.v2026_11_01_preview)
interface JobStorage {
  /**
   * Lists customer-readable artifacts for the job, including input, outputs, and other supporting files.
   * Each reference's id is the job-relative path used to retrieve that artifact.
   * Follow the opaque absolute nextLink, including its
   * api-version, unchanged; it is omitted on the last page. Listing and direct reads share
   * the same visibility policy.
   */
  @get
  @list
  @segment("artifacts")
  listArtifacts is Azure.Core.Foundations.ResourceOperation<
    JobDetails,
    {
      /** An optional artifact path prefix, such as diagnostics/. */
      @query
      prefix?: string;
    },
    ArtifactListResult,
    DefaultServiceTraits
  >;

  /**
   * Streams a customer-readable artifact. The path is hierarchical and relative to the artifact
   * root, never a URL. Decode exactly once; reject absolute paths, backslashes, empty segments,
   * and dot or dot-dot segments. Apply the same visibility policy as artifact listing.
   */
  @get
  getArtifact is Azure.Core.Foundations.ResourceOperation<
    JobDetails,
    {
      /** The hierarchical artifact-relative file path, such as diagnostics/logs/run.txt. */
      @segment("artifacts")
      @path(#{ allowReserved: true })
      path: string;
    },
    JobFileResult,
    DefaultServiceTraits
  >;
}
