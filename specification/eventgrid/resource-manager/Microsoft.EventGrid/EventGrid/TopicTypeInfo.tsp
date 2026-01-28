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
 * Properties of a topic type info.
 */
@tenantResource
model TopicTypeInfo
  is Azure.ResourceManager.ProxyResource<TopicTypeProperties> {
  ...ResourceNameParameter<
    Resource = TopicTypeInfo,
    KeyName = "topicTypeName",
    SegmentName = "topicTypes",
    NamePattern = ""
  >;
}

@armResourceOperations
interface TopicTypeInfos {
  /**
   * Get information about a topic type.
   */
  @summary("Get a topic type.")
  get is ArmResourceRead<
    TopicTypeInfo,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * List all registered topic types.
   */
  @summary("List topic types.")
  list is ArmResourceListByParent<
    TopicTypeInfo,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Response = ArmResponse<TopicTypesListResult>
  >;

  /**
   * List event types for a topic type.
   */
  @summary("List event types.")
  @list
  @get
  @action("eventTypes")
  listEventTypes is ArmResourceActionSync<
    TopicTypeInfo,
    void,
    ArmResponse<EventTypesListResult>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;
}

@@doc(TopicTypeInfo.name, "Name of the topic type.");
@@doc(TopicTypeInfo.properties, "Properties of the topic type info");
