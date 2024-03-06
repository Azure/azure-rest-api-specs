// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "@typespec/rest";

using OpenAPI;
using TypeSpec.Http;

@doc("Error information.")
model ErrorData {
  @doc("An identifier for the error. Codes are invariant and are intended to be consumed programmatically.")
  @visibility("read")
  code: string;

  @doc("A message describing the error, intended to be suitable for displaying in a user interface.")
  @visibility("read")
  message: string;
}
