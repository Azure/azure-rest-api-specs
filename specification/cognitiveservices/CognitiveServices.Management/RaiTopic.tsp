import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CognitiveServices;
/**
 * Cognitive Services Rai Topic.
 */
@parentResource(Account)
model RaiTopic is Azure.ResourceManager.ProxyResource<RaiTopicProperties> {
  ...ResourceNameParameter<
    Resource = RaiTopic,
    KeyName = "raiTopicName",
    SegmentName = "raitopics",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
  >;

  /**
   * Resource Etag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

@armResourceOperations
interface RaiTopics {
  /**
   * Gets the specified custom topic associated with the Azure OpenAI account.
   */
  get is ArmResourceRead<RaiTopic>;

  /**
   * Create the rai topic associated with the Azure OpenAI account.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<RaiTopic>;

  /**
   * Deletes the specified custom topic associated with the Azure OpenAI account.
   */
  delete is ArmResourceDeleteWithoutOkAsync<RaiTopic>;

  /**
   * Gets the custom topics associated with the Azure OpenAI account.
   */
  list is ArmResourceListByParent<
    RaiTopic,
    Response = ArmResponse<RaiTopicResult>
  >;
}

@@doc(RaiTopic.name,
  "The name of the Rai Topic associated with the Cognitive Services Account"
);
@@encodedName(RaiTopic.etag, "application/json", "etag");
@@doc(RaiTopic.properties, "Properties of Cognitive Services Rai Topic.");
@@doc(RaiTopics.createOrUpdate::parameters.resource,
  "Properties describing the rai topic."
);
