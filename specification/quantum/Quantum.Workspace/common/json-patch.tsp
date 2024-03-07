// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Rest.Resource;
using OpenAPI;

@doc("The operation to be performed.")
enum JsonPatchOperation {
  @doc("Add value operation.")
  add,

  @doc("Remove value operation.")
  remove,

  @doc("Replace value operation.")
  replace,

  @doc("Move value operation.")
  move,

  @doc("Copy value operation.")
  copy,

  @doc("Test value operation.")
  test,
}

@doc("A JSONPatch object as defined by RFC 6902.")
model JsonPatchObject {
  @visibility("create")
  @doc("The operation to be performed.")
  @projectedName("json", "op")
  operation: JsonPatchOperation;

  @visibility("create")
  @doc("A JSON-Pointer.")
  path: string;

  @visibility("create")
  @doc("A value to be used in the operation on the path.")
  value?: {};

  @visibility("create")
  @doc("Optional field used in copy and move operations.")
  from?: string;
}

@doc("A JSONPatch document as defined by RFC 6902.")
model JsonPatchDocument is JsonPatchObject[];
