import "../../Common/ArmModels/AzureResourceProperties.tsp";
import "../Enums/Enums.tsp";
import "../../Common/ArmModels/MigrateProject.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

@added(ApiVersions.v2025_03_30_preview)
@doc("Migration Wave resource.")
@parentResource(MigrateProject)
model Wave is ProxyResource<WaveProperties> {
  @doc("Migration Wave Resource")
  @key("waveName")
  @segment("waves")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;

  ...EntityTagProperty;
}

@doc("Migration Wave Properties class.")
model WaveProperties is AzureResourceProperties {
  @doc("Description of the wave.")
  description?: string;

  @doc("Display Name of the wave.")
  displayName: string;

  @doc("ARG query and other details to create workloads within a wave")
  arg: Arg;

  @doc("The status of the wave.")
  @visibility(Lifecycle.Read)
  status?: string;

  @doc("Planned start date of the wave.")
  plannedStartDate: utcDateTime;

  @doc("Planned completion date of the wave.")
  plannedCompletionDate?: utcDateTime;

  @doc("Actual start date of the wave.")
  @visibility(Lifecycle.Read)
  actualStartDate?: utcDateTime;

  @doc("The current stage of the wave.")
  @visibility(Lifecycle.Read)
  stage?: string;
}

@doc("ARG query and other details to create workloads within a wave.")
model Arg {
  @doc("The query to create workloads within the wave.")
  query: string;
}
