// FIXTURE (positive): correctly cased, completely opaque. Every name here
// passes `casing-style`. Seeded violations: DP-NAME-01, DP-NAME-02,
// DP-NAME-03, DP-NAME-04.
// Not a real service. Not under specification/; not compiled by CI.

import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@service(#{ title: "Telemetry Sink" })
@versioned(Versions)
@server("https://{endpoint}", "Telemetry Sink service", { endpoint: string })
namespace TelemetrySink;

enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2026_01_01: "2026-01-01",
}

@doc("A telemetry sink instance.")
@resource("sinks")
model Sink {
  @doc("The unique name of the sink.")
  @key
  @visibility(Lifecycle.Read)
  name: string;

  // VIOLATION (DP-NAME-01): non-obvious abbreviation.
  @doc("Serialized sink configuration.")
  cfg: string;

  // VIOLATION (DP-NAME-01): numeric suffix standing in for meaning.
  @doc("Primary payload buffer contents.")
  data1: string;

  // VIOLATION (DP-NAME-01): numeric suffix standing in for meaning.
  @doc("Secondary payload buffer contents.")
  data2: string;

  // VIOLATION (DP-NAME-01): says nothing about what it flags.
  @doc("Whether the sink is flagged.")
  flag: boolean;

  // VIOLATION (DP-NAME-03): encodes a processing mode as a boolean. Adding a
  // third mode later is a breaking change.
  @doc("Whether the sink runs in advanced processing mode.")
  useAdvanced: boolean;

  // VIOLATION (DP-NAME-02): no unit.
  @doc("How long a record is retained before deletion.")
  retention: int32;

  // VIOLATION (DP-NAME-04): three names for creation time across three models
  // in one service.
  @doc("When the sink was created.")
  @visibility(Lifecycle.Read)
  creationTime: utcDateTime;

  // VIOLATION (DP-NAME-04): repeats the resource type in the property name.
  @doc("The region hosting the sink.")
  sinkSinkRegion: string;
}

@doc("A routing rule attached to a sink.")
model SinkRule {
  @doc("The unique name of the rule.")
  name: string;

  // VIOLATION (DP-NAME-04): `created` here, `creationTime` on Sink,
  // `createdOn` on SinkExport.
  @doc("When the rule was created.")
  @visibility(Lifecycle.Read)
  created: utcDateTime;
}

@doc("An export job for a sink.")
model SinkExport {
  @doc("The unique name of the export.")
  name: string;

  // VIOLATION (DP-NAME-04): third spelling of the same concept.
  @doc("When the export was created.")
  @visibility(Lifecycle.Read)
  createdOn: utcDateTime;
}

interface Sinks {
  @doc("Gets a sink.")
  get is StandardResourceOperations.ResourceRead<Sink>;

  @doc("Creates or updates a sink.")
  createOrUpdate is StandardResourceOperations.ResourceCreateOrUpdate<Sink>;

  @doc("Lists sinks.")
  list is StandardResourceOperations.ResourceList<Sink>;
}
