// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./operations.tsp";
import "../common/models.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;

/** A key-value pair. */
model KeyValue<Value = string> {
  /** Key. */
  key: string;

  /** Value. */
  value: Value;
}

/** The type of the workspace item. */
union ItemType {
  string,

  /** A program, problem, or application submitted for processing. */
  Job: "Job",

  /** A logical grouping of jobs. */
  Session: "Session",
}

/** Id of the workspace item. */
@pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
@maxLength(36)
scalar WorkspaceItemId extends string;

/** A workspace item. */
@discriminator("itemType")
@resource("topLevelItems")
@parentResource(QuantumWorkspace)
model ItemDetails {
  /** Id of the item. */
  @key
  @visibility("read")
  id: WorkspaceItemId;

  /** The name of the item. It is not required for the name to be unique and it's only used for display purposes. */
  @visibility("read", "create", "update")
  name: string;

  /** The unique identifier for the provider. */
  @visibility("read", "create")
  providerId: string;

  /** The target identifier to run the job. */
  @visibility("read", "create")
  target: string;

  /** Type of the Quantum Workspace item */
  @visibility("read", "create")
  itemType: ItemType;

  /** The creation time of the item. */
  @visibility("read")
  creationTime?: utcDateTime;

  /** The time when the item began execution. */
  @visibility("read")
  beginExecutionTime?: utcDateTime;

  /** The time when the item finished execution. */
  @visibility("read")
  endExecutionTime?: utcDateTime;

  /** Cost estimate. */
  @visibility("read")
  costEstimate?: CostEstimate;

  /** Error information. */
  @visibility("read")
  errorData?: Errors.WorkspaceItemError;
}

alias PagedItemDetails = Azure.Core.Page<ItemDetails>;

namespace Quantum.Workspace.Operations {
  using Quantum.Workspace.BaseOperations;

  interface ItemsOperations {
    /** List top-level items. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" """
      We had to use a custom ResourceList to avoid an autoroute bug for workspace/jobs and sesssions/{sessionId}/jobs.
      See https://github.com/Azure/typespec-azure/issues/494
      """
    list is CustomListOperation<
      Resource = ItemDetails,
      Response = PagedItemDetails,
      Parameters = {
        ...CustomQueryParameters;
      }
    >;
  }
}
