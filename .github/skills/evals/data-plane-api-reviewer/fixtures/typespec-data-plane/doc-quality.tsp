// FIXTURE (positive): documentation that satisfies `documentation-required` and
// conveys nothing. Seeded violations: DP-DOC-01, DP-DOC-02, DP-DOC-03,
// DP-NAME-02.
// Not a real service. Not under specification/; not compiled by CI.

import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@service(#{ title: "Index Service" })
@versioned(Versions)
@server("https://{endpoint}", "Index service", { endpoint: string })
namespace IndexService;

enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2026_01_01: "2026-01-01",
}

@doc("An index.")
@resource("indexes")
model Index {
  // VIOLATION (DP-DOC-01): tautology. Says nothing about uniqueness scope,
  // mutability, or allowed characters.
  @doc("The name.")
  @key
  @visibility(Lifecycle.Read)
  name: string;

  // VIOLATION (DP-DOC-01) + (DP-NAME-02): no units, and the doc adds nothing.
  @doc("The timeout.")
  timeout: int32;

  // VIOLATION (DP-DOC-01): tautology.
  @doc("The status.")
  status: IndexStatus;

  // VIOLATION (DP-DOC-03): the filter grammar, the filterable fields, and the
  // error returned for a malformed filter are all undocumented.
  @doc("The filter.")
  filter?: string;

  // VIOLATION (DP-DOC-03): mutually exclusive with `filter`, and that
  // invariant appears nowhere.
  @doc("The query.")
  query?: string;

  // VIOLATION (DP-NAME-02): unit-less.
  @doc("Maximum size of the index.")
  maxSize: int64;
}

// VIOLATION (DP-DOC-02): union members are undocumented. Nothing says which
// states are terminal or what distinguishes Failed from Stopped.
@doc("The status of an index.")
union IndexStatus {
  string,
  Ready: "Ready",
  Building: "Building",
  Failed: "Failed",
  Stopped: "Stopped",
}

interface Indexes {
  @doc("Gets an index.")
  get is StandardResourceOperations.ResourceRead<Index>;

  @doc("Creates or updates an index.")
  createOrUpdate is StandardResourceOperations.ResourceCreateOrUpdate<Index>;

  @doc("Deletes an index.")
  delete is StandardResourceOperations.ResourceDelete<Index>;

  @doc("Lists indexes.")
  list is StandardResourceOperations.ResourceList<Index>;
}
