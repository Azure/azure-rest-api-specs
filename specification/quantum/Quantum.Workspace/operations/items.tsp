// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "@typespec/rest";
import "@typespec/http";
import "../common/operations.tsp";
import "./cost-estimates.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Rest.Resource;
using OpenAPI;

@doc("A key-value pair.")
model KeyValue<TValue = string> {
  @doc("Key.")
  key: string;

  @doc("Value.")
  value: TValue;
}

@doc("The type of the workspace item.")
enum ItemType {
  @doc("A program, problem, or application submitted for processing.")
  Job,

  @doc("A logical grouping of jobs.")
  Session,
}

@doc("Id of the item.")
@pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
@maxLength(36)
scalar WorkspaceItemId extends string;

@discriminator("itemType")
@doc("A workspace item.")
model ItemDetails {
  @key
  @doc("Id of the item.")
  @visibility("read", "create")
  id: WorkspaceItemId;

  @visibility("read", "create", "update")
  @doc("The name of the item. It is not required for the name to be unique and it's only used for display purposes.")
  name: string;

  @visibility("read", "create")
  @doc("The unique identifier for the provider.")
  providerId: string;

  @visibility("read", "create")
  @doc("The target identifier to run the job.")
  target: string;

  @visibility("read", "create")
  @doc("Type of the Quantum Workspace item")
  itemType: ItemType;

  @visibility("read")
  @doc("The creation time of the item.")
  creationTime?: utcDateTime;

  @visibility("read")
  @doc("The time when the item began execution.")
  beginExecutionTime?: utcDateTime;

  @visibility("read")
  @doc("The time when the item finished execution.")
  endExecutionTime?: utcDateTime;

  @visibility("read")
  @doc("Cost estimate.")
  costEstimate?: CostEstimate;

  @visibility("read")
  @doc("Error information.")
  errorData?: ErrorData;
}

@doc("List of workspace jobs.")
model ItemDetailsList {
  ...CollectionWithNextLink<ItemDetails>;
}

interface TopLevelItemsOperations {
  // @doc("List top-level items.")
  // @get
  // @listsResource(ItemDetails)
  // @segment("topLevelItems")
  // list is ListOperation<ItemDetailsList>;
}
