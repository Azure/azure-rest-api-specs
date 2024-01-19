import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BatchAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Batch;
@doc("Contains the information for a detector.")
@parentResource(BatchAccount)
model DetectorResponse is ProxyResource<DetectorResponseProperties> {
  @doc("The name of the detector.")
  @path
  @key("detectorId")
  @segment("detectors")
  name: string;
}

@armResourceOperations
interface DetectorResponses {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets information about the given detector for a given Batch account.")
  @operationId("BatchAccount_GetDetector")
  getDetector is ArmResourceRead<DetectorResponse>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets information about the detectors available for a given Batch account.")
  @operationId("BatchAccount_ListDetectors")
  listDetectors is ArmResourceListByParent<DetectorResponse>;
}
