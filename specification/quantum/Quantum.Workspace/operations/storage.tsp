// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./operations.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;

using TypeSpec.Http;

/** The details (name and container) of the blob to store or download data. */
model BlobDetails {
  /** The container name. */
  @visibility("read", "create")
  containerName: string;

  /** The blob name. */
  @visibility("read", "create")
  blobName?: string;
}

/** SAS URI operation response. */
model SasUriResponse {
  /** A URL with a SAS token to upload a blob for execution in the given workspace. */
  @visibility("read")
  sasUri: string;
}

alias BlobDetailsParam = {
  /** The details (name and container) of the blob. */
  @body
  blobDetails: BlobDetails;
};

@useDependency(DefaultAzureCoreVersion)
namespace Quantum.Workspace.Operations {
  using Quantum.Workspace.BaseOperations;
  @autoRoute
  interface StorageOperations {
    /** Gets a URL with SAS token for a container/blob in the storage account associated with the workspace. The SAS URL can be used to upload job input and/or download job output. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "There is no standard operation that fits this scenario"
    @segment("storage/sasUri")
    getSasUri is PostOperation<BlobDetailsParam, SasUriResponse>;
  }
}
