// FIXTURE (positive): visibility and secret exposure. Seeded violations:
// DP-VIS-01, DP-VIS-02, DP-VIS-03, DP-VIS-05, DP-VIS-06.
// The credential values below are obviously fake placeholders.
// Not a real service. Not under specification/; not compiled by CI.

import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@service(#{ title: "Connector Registry" })
@versioned(Versions)
@server("https://{endpoint}", "Connector Registry service", { endpoint: string })
namespace ConnectorRegistry;

enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2026_01_01: "2026-01-01",
}

@doc("A registered connector.")
@resource("connectors")
model Connector {
  @doc("The unique name of the connector.")
  @key
  @visibility(Lifecycle.Read)
  name: string;

  @doc("Endpoint the connector targets.")
  targetEndpoint: url;

  // VIOLATION (DP-VIS-02): a credential with default (readable) visibility and
  // no @secret. Returned by both `get` and `list`.
  // VIOLATION (DP-VIS-03): reachable from the list response.
  @doc("API key used to authenticate to the target endpoint.")
  apiKey: string;

  // VIOLATION (DP-VIS-02) + (DP-VIS-03): same problem, different shape.
  @doc("Connection string used to reach the target data store.")
  connectionString: string;

  // VIOLATION (DP-VIS-01): write-only, but not a secret. A caller cannot read
  // back what they configured, so GET-then-PUT round-tripping silently drops
  // it.
  @doc("Display name shown for this connector in the portal.")
  @visibility(Lifecycle.Create, Lifecycle.Update)
  friendlyName: string;

  // VIOLATION (DP-VIS-05): server-assigned but writable. Callers will try to
  // set it.
  @doc("When the connector was registered.")
  createdAt: utcDateTime;

  // VIOLATION (DP-VIS-05): server-assigned but writable.
  @doc("Entity tag for optimistic concurrency.")
  etag: string;

  // VIOLATION (DP-VIS-06): both optional and nullable, with no stated
  // difference between absent and explicitly null.
  @doc("Optional description of the connector.")
  description?: string | null;
}

interface Connectors {
  @doc("Gets a connector.")
  get is StandardResourceOperations.ResourceRead<Connector>;

  @doc("Creates or updates a connector.")
  createOrUpdate is StandardResourceOperations.ResourceCreateOrUpdate<Connector>;

  @doc("Lists connectors.")
  list is StandardResourceOperations.ResourceList<Connector>;
}
