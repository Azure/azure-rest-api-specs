import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Azure.Core;

namespace Microsoft.DeviceRegistry;

// ──────────────────────────────────────────────
// Namespace operations models
// ──────────────────────────────────────────────

/**
 * Request body for generating a namespace report.
 *
 * The combination of `reportType` and `scope.type` is validated server-side
 * (e.g. `GroupBestUpdatesCompliance` requires `scope.type == "Group"`).
 */
model GenerateReportRequest {
  /** The type of report to generate. */
  reportType: ReportType;

  /** The scope the report is generated against. */
  scope: ReportScope;
}

// ──────────────────────────────────────────────
// Namespaces interface
// ──────────────────────────────────────────────

/** Operations on namespaces. */
@tag("Namespaces")
interface Namespaces {
  /** Generate a report for a namespace. */
  @pollingOperation(Operations.get)
  generateReport is ResourceOperations.LongRunningResourceAction<
    Namespace,
    GenerateReportRequest
  >;
}