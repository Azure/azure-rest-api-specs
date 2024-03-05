// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "@typespec/rest";
import "@typespec/http";
import "./operations.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Rest.Resource;
using OpenAPI;

@doc("The details (name and container) of the blob to store or download data.")
model BlobDetails {
  @visibility("read", "create")
  @doc("The container name.")
  containerName: string;

  @visibility("read", "create")
  @doc("The blob name.")
  blobName: string;
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

interface StorageOperations {
  @doc("Gets a URL with SAS token for a container/blob in the storage account associated with the workspace. The SAS URL can be used to upload job input and/or download job output.")
  @post
  @segment("storage/sasUri")
  sasUri is CommonOperation<BlobDetailsParam, SasUriResponse>;
}
