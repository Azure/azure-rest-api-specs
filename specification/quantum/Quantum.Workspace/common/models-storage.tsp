// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./common.tsp";

import "./models.tsp";
import "./models-items.tsp";

namespace Quantum.Workspace;

/** The details (name and container) of the blob to store or download data. */
model BlobDetails {
  /** The container name. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  containerName: string;

  /** The blob name. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  blobName?: string;
}

/** SAS URI operation response. */
model SasUriResponse {
  /** A URL with a SAS token to upload a blob for execution in the given workspace. */
  @visibility(Lifecycle.Read)
  sasUri: string;
}
