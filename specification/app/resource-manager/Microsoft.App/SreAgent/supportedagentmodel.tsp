import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./supportedagentmodel.models.tsp";

using Azure.ResourceManager;

using TypeSpec.Rest;

namespace Microsoft.App;

/** Collection of supported AI models */
@parentResource(SubscriptionLocationResource)
model SupportedAgentModel is ProxyResource<SupportedAgentModelProperties> {
  ...ResourceNameParameter<
    Resource = SupportedAgentModel,
    KeyName = "supportedAgentModelName",
    SegmentName = "supportedAgentModels"
  >;
}

@armResourceOperations
interface SupportedAgentModels {
  listByLocation is ArmResourceListByParent<SupportedAgentModel>;
}
