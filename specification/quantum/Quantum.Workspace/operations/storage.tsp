// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./operations.tsp";
import "../common/models-storage.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

using Quantum.Workspace;

alias BlobDetailsParam = {
  /** The details (name and container) of the blob. */
  @bodyRoot
  blobDetails: BlobDetails;
};

namespace Quantum.Workspace.Services {
  @autoRoute
  interface Storage {
    /** Gets a URL with SAS token for a container/blob in the storage account associated with the workspace. The SAS URL can be used to upload job input and/or download job output. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "There is no standard operation that fits this scenario"
    @segment("storage/sasUri")
    getSasUri is PostOperation<BlobDetailsParam, SasUriResponse>;
  }
}
