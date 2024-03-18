// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./operations.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;

using TypeSpec.Http;

@doc("The details (name and container) of the blob to store or download data.")
model BlobDetails {
  @visibility("read", "create")
  @doc("The container name.")
  containerName: string;

  @visibility("read", "create")
  @doc("The blob name.")
  blobName?: string;
}

@doc("SAS URI operation response.")
model SasUriResponse {
  @visibility("read")
  @doc("A URL with a SAS token to upload a blob for execution in the given workspace.")
  sasUri: string;
}

alias BlobDetailsParam = {
  @doc("The details (name and container) of the blob.")
  @body
  blobDetails: BlobDetails;
};

@useDependency(DefaultAzureCoreVersion)
namespace Quantum.Workspace.Operations {
  using Quantum.Workspace.BaseOperations;
  @autoRoute
  interface StorageOperations {
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "There is no standard operation that fits this scenario"
    @doc("Gets a URL with SAS token for a container/blob in the storage account associated with the workspace. The SAS URL can be used to upload job input and/or download job output.")
    @segment("storage/sasUri")
    getSasUri is PostOperation<BlobDetailsParam, SasUriResponse>;
  }
}
