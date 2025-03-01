// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./operations.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@versioned(QuantumWorkspaceAPIVersion)
namespace Quantum.Workspace;

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
  errorData?: WorkspaceItemError;
}

/** Operation to list a resource with filters and pages. */
model PaginatedItemsParameters {
  /**
   * Filter the result list using the given expression
   */
  @added(QuantumWorkspaceAPIVersion.v2024_10_01_preview)
  @query("filter")
  filter?: string;

  /**
   * The number of result items to skip.
   */
  @added(QuantumWorkspaceAPIVersion.v2024_10_01_preview)
  @query("skip")
  skip?: int32;

  /**
   * The number of items taken.
   */
  @added(QuantumWorkspaceAPIVersion.v2024_10_01_preview)
  @query("top")
  top?: int32;

  /**
   * The order of returned items.
   */
  @added(QuantumWorkspaceAPIVersion.v2024_10_01_preview)
  @query("orderby")
  orderby?: string;
}

@versioned(QuantumWorkspaceAPIVersion)
namespace Quantum.Workspace.Operations {
  interface ItemsOperations {
    /** List top-level items. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" """
      We had to use a custom operation to support versioned parameters for pagination.
      """
    list is CustomListOperation<
      Resource = ItemDetails,
      Parameters = PaginatedItemsParameters
    >;
  }
}
