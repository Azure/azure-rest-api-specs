import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./supportedmodel.models.tsp";

using Azure.ResourceManager;

using TypeSpec.Rest;

namespace Microsoft.App;

/** Collection of supported AI models */
@parentResource(SubscriptionLocationResource)
model SupportedModel is ProxyResource<SupportedModelProperties> {
  ...ResourceNameParameter<
    Resource = SupportedModel,
    KeyName = "supportedModelName",
    SegmentName = "supportedModels"
  >;
}

@armResourceOperations
interface SupportedModels {
  listByLocation is ArmResourceListByParent<SupportedModel>;
}
