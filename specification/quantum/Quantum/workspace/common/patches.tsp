// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "@typespec/rest";
import "@typespec/http";
import "./items.tsp";
import "./jobs.tsp";
import "./errors.tsp";
import "./params.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Rest.Resource;
using OpenAPI;

alias PatchRequest = JsonPatchDocument[];

@doc("The operation to be performed.")
enum JsonPatchOperation {
  add,
  remove,
  replace,
  move,
  copy,
  test,
}

@doc("A JSONPatch document as defined by RFC 6902")
model JsonPatchDocument {
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
