// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@typespec/versioning";

import "./versions.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Quantum.Workspace;

/**
 * Provides the custom 'filter' query parameter for list operations
 */
model CustomFilterQueryParameter {
  /**
   * Filter the result list using the given expression
   */
  @added(QuantumWorkspaceAPIVersion.v2024_10_01_preview)
  @query("filter")
  filter?: string;
}

/**
 * Provides the custom 'skip' query parameter for list operations.
 */
model CustomSkipQueryParameter {
  /**
   * The number of result items to skip.
   */
  @added(QuantumWorkspaceAPIVersion.v2024_10_01_preview)
  @query("skip")
  skip?: int32;
}

/**
 * Provides the custom 'top' query parameter for list operations.
 */
model CustomTopQueryParameter {
  /**
   * The number of jobs taken.
   */
  @added(QuantumWorkspaceAPIVersion.v2024_10_01_preview)
  @query("top")
  top?: int32;
}

/**
 * Provides the custom 'orderBy' query parameter for list operations.
 */
model CustomOrderByQueryParameter {
  /**
   * The order of returned items.
   */
  @added(QuantumWorkspaceAPIVersion.v2024_10_01_preview)
  @query("orderby")
  orderby?: string;
}
