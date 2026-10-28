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
@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.clientCredentials,
      tokenUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/token",
      scopes: ["https://telemetrysink.azure.com/.default"],
    }
  ]>
)
@server("https://{endpoint}", "Telemetry Sink service", { endpoint: string })
namespace TelemetrySink;

enum Versions {
  v2026_01_01: "2026-01-01",
}

@doc("A telemetry sink instance.")
@resource("sinks")
model Sink {
  @doc("The unique name of the sink.")
  @key
  @visibility(Lifecycle.Read)
  name: string;

  @doc("Serialized sink configuration.")
  cfg: string;

  @doc("Primary payload buffer contents.")
  data1: string;

  @doc("Secondary payload buffer contents.")
  data2: string;

  @doc("Whether the sink is flagged.")
  flag: boolean;

  @doc("Whether the sink runs in advanced processing mode.")
  useAdvanced: boolean;

  @doc("How long a record is retained before deletion.")
  retention: int32;

  @doc("When the sink was created.")
  @visibility(Lifecycle.Read)
  creationTime: utcDateTime;

  @doc("The region hosting the sink.")
  sinkSinkRegion: string;
}

@doc("A routing rule attached to a sink.")
model SinkRule {
  @doc("The unique name of the rule.")
  name: string;

  @doc("When the rule was created.")
  @visibility(Lifecycle.Read)
  created: utcDateTime;
}

@doc("An export job for a sink.")
model SinkExport {
  @doc("The unique name of the export.")
  name: string;

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
