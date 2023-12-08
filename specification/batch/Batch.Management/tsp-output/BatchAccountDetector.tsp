import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./BatchAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Batch;
@doc("Contains the information for a detector.")
@parentResource(BatchAccount)
model BatchAccountDetector is ProxyResource<DetectorResponseProperties> {
  @doc("The name of the detector.")
  @path
  @key("detectorId")
  @segment("detectors")
  name: string;
}

@armResourceOperations
interface BatchAccountDetectors {
  @doc("Gets information about the given detector for a given Batch account.")
  getDetector is ArmResourceRead<BatchAccountDetector>;
  @doc("Gets information about the detectors available for a given Batch account.")
  listDetectors is ArmResourceListByParent<BatchAccountDetector>;
}
