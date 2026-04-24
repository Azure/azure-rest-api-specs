import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.EventGrid;
/**
 * Event grid Extension Topic. This is used for getting Event Grid related metrics for Azure resources.
 */
@singleton("default")
model ExtensionTopic
  is Azure.ResourceManager.ExtensionResource<ExtensionTopicProperties> {
  ...ResourceNameParameter<
    Resource = ExtensionTopic,
    KeyName = "extensionTopic",
    SegmentName = "extensionTopics",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ExtensionTopics {
  /**
   * Get the properties of an extension topic.
   */
  @summary("Get properties of an extension topic.")
  get is Extension.Read<Extension.ScopeParameter, ExtensionTopic>;
}

@@doc(ExtensionTopic.name, "");
@@doc(ExtensionTopic.properties, "Properties of the extension topic.");
