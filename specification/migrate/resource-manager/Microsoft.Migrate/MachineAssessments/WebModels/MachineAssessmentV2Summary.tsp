import "../Normalized Contract/StandardizedContracts/CommonModels.tsp";
import "../Normalized Contract/StandardizedContracts/SummaryProperties.tsp";
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;
namespace Microsoft.Migrate;

@doc("Machine Assessment REST resource.")
@parentResource(MachineAssessmentV2)
model MachineAssessmentV2Summary is ProxyResource<SummaryProperties> {
  @doc("Gets the Name of the Machine Summary.")
  @key("summaryName")
  @segment("summaries")
  @path
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}
