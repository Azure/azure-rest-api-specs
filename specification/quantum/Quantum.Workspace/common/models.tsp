import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@typespec/versioning";

import "./versions.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using OpenAPI;

alias DefaultAzureCoreVersion = Azure.Core.Versions.v1_0_Preview_2;

@versioned(QuantumWorkspaceAPIVersion)
namespace Quantum.Workspace {
  /**
   * Provides the custom query parameters for list operations
   */
  model CustomQueryParameters {
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
     * The number of jobs taken.
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
}
