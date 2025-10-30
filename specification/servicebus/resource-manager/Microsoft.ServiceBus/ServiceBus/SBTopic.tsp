import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SBNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceBus;
/**
 * Description of topic resource.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(SBNamespace)
model SBTopic is Azure.ResourceManager.ProxyResource<SBTopicProperties> {
  ...ResourceNameParameter<
    Resource = SBTopic,
    KeyName = "topicName",
    SegmentName = "topics",
    NamePattern = ""
  >;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  location?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface SBTopics {
  /**
   * Returns a description for the specified topic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt639399.aspx")
  get is ArmResourceRead<SBTopic, Error = ErrorResponse>;

  /**
   * Creates a topic in the specified namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt639409.aspx")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    SBTopic,
    Response = ArmResourceUpdatedResponse<SBTopic>,
    Error = ErrorResponse
  >;

  /**
   * Deletes a topic from the specified namespace and resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt639404.aspx")
  delete is ArmResourceDeleteSync<SBTopic, Error = ErrorResponse>;

  /**
   * Gets all the topics in a namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt639388.aspx")
  listByNamespace is ArmResourceListByParent<
    SBTopic,
    Parameters = {
      /**
       * Skip is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skip parameter that specifies a starting point to use for subsequent calls.
       */
      @maxValue(1000)
      @query("$skip")
      $skip?: int32;

      /**
       * May be used to limit the number of results to the most recent N usageDetails.
       */
      @maxValue(1000)
      @minValue(1)
      @query("$top")
      $top?: int32;
    },
    Error = ErrorResponse
  >;
}

@@minLength(SBTopic.name, 1);
@@doc(SBTopic.name, "The topic name.");
@@doc(SBTopic.properties, "Properties of topic resource.");
@@doc(SBTopics.createOrUpdate::parameters.resource,
  "Parameters supplied to create a topic resource."
);
