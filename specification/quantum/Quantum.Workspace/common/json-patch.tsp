// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Rest.Resource;
using OpenAPI;

/** The operation to be performed. */
union JsonPatchOperation {
  string,

  /** Add value operation. */
  add: "add",

  /** Remove value operation. */
  remove: "remove",

  /** Replace value operation. */
  replace: "replace",

  /** Move value operation. */
  move: "move",

  /** Copy value operation. */
  copy: "copy",

  /** Test value operation. */
  test: "test",
}

/** A JSONPatch object as defined by RFC 6902. */
model JsonPatchObject {
  /** The operation to be performed. */
  @visibility("create")
  @encodedName("application/json", "op")
  operation: JsonPatchOperation;

  /** A JSON-Pointer. */
  @visibility("create")
  path: string;

  /** A value to be used in the operation on the path. */
  @visibility("create")
  value?: {};

  /** Optional field used in copy and move operations. */
  @visibility("create")
  from?: string;
}

/** A JSONPatch document as defined by RFC 6902. */
model JsonPatchDocument is JsonPatchObject[];
