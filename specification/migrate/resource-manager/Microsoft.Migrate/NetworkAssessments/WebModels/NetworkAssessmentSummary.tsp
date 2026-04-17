import "../Common/StandardizedContracts/SummaryProperties.tsp";
import "./NetworkAssessment.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("Network Assessment Summary REST resource.")
@parentResource(NetworkAssessment)
model NetworkAssessmentSummary is ProxyResource<SummaryProperties> {
  @doc("Gets the Name of the Network Assessment Summary.")
  @key("summaryName")
  @segment("summaries")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}
