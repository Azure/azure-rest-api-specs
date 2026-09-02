// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./operations.tsp";
import "../common/models.tsp";
import "../common/models-items.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

using Quantum.Workspace;

alias PagedItemDetails = Azure.Core.Page<ItemDetails>;

namespace Quantum.Workspace.Services {
  interface TopLevelItems {
    /** List top-level items. */
    @sharedRoute
    @added(QuantumWorkspaceAPIVersion.v2024_03_01_preview)
    @removed(QuantumWorkspaceAPIVersion.v2024_10_01_preview)
    list is ListOperation<ItemDetails>;

    /** List top-level items. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" """
      We had to use a custom ResourceList to avoid an autoroute bug for workspace/jobs and sesssions/{sessionId}/jobs.
      See https://github.com/Azure/typespec-azure/issues/494
      """
    @sharedRoute
    @added(QuantumWorkspaceAPIVersion.v2024_10_01_preview)
    listv2 is CustomListOperation<
      Resource = ItemDetails,
      Response = PagedItemDetails,
      Parameters = {
        ...CustomFilterQueryParameter;
        ...CustomSkipQueryParameter;
        ...CustomTopQueryParameter;
        ...CustomOrderByQueryParameter;
      }
    >;
  }
}
