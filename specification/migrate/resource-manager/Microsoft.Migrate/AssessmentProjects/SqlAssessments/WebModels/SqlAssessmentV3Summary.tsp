import "../Common/CommonModels.tsp";
import "../Normalized Contract/StandardizedContracts/SummaryProperties.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("SQL Assessment REST resource.")
@parentResource(SqlAssessmentV3)
model SqlAssessmentV3Summary is ProxyResource<SummaryProperties> {
  @doc("Gets the Name of the SQL Summary.")
  @key("summaryName")
  @segment("summaries")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}
