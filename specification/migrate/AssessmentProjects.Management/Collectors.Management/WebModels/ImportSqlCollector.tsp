import "../../Common/ArmModels/AzureResourceProperties.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("Import SQL Collector REST resource.")
@parentResource(AssessmentProject)
model ImportSqlCollector is ProxyResource<ImportSqlCollectorProperties> {
  @doc("Import SQL Collector arm name.")
  @key("importSqlCollectorsName")
  @segment("importSqlCollectors")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}

@doc("Import SQL Collector properties class.")
model ImportSqlCollectorProperties is AzureResourceProperties {
  @doc("The sql db extended details.")
  discoverySiteId?: string;

  @doc("When was import SQL collector first created.")
  @visibility(Lifecycle.Read)
  createdTimestamp?: utcDateTime;

  @doc("When was import SQL collector last updated.")
  @visibility(Lifecycle.Read)
  updatedTimestamp?: utcDateTime;
}
