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
@extensionResource
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
  get is ArmResourceRead<
    ExtensionTopic,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters,
    Parameters = {
      /**
       * The identifier of the resource to which extension topic is queried. The scope can be a subscription, or a resource group, or a top level resource belonging to a resource provider namespace. For example, use '/subscriptions/{subscriptionId}/' for a subscription, '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}' for a resource group, and '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}' for Azure resource.
       */
      @path
      scope: string;
    }
  >;
}

@@doc(ExtensionTopic.name, "");
@@doc(ExtensionTopic.properties, "Properties of the extension topic.");
