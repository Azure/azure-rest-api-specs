import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Namespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.EventGrid;
/**
 * Namespace topic details.
 */
@parentResource(Namespace)
model NamespaceTopic
  is Azure.ResourceManager.ProxyResource<NamespaceTopicProperties> {
  ...ResourceNameParameter<
    Resource = NamespaceTopic,
    KeyName = "topicName",
    SegmentName = "topics",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

@armResourceOperations
interface NamespaceTopics {
  /**
   * Get properties of a namespace topic.
   */
  @summary("Get a namespace topic.")
  get is ArmResourceRead<NamespaceTopic>;

  /**
   * Asynchronously creates a new namespace topic with the specified parameters.
   */
  @summary("Create a namespace topic.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<NamespaceTopic>;

  /**
   * Asynchronously updates a namespace topic with the specified parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Update a namespace topic.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    NamespaceTopic,
    PatchModel = NamespaceTopicUpdateParameters,
    Response = ArmResponse<NamespaceTopic> | (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = NamespaceTopic> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: NamespaceTopic;
    })
  >;

  /**
   * Delete existing namespace topic.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete a namespace topic.")
  delete is ArmResourceDeleteWithoutOkAsync<
    NamespaceTopic,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all the namespace topics under a namespace.
   */
  @summary("List namespace topics under a namespace.")
  listByNamespace is ArmResourceListByParent<
    NamespaceTopic,
    Parameters = {
      /**
       * The query used to filter the search results using OData syntax. Filtering is permitted on the 'name' property only and with limited number of OData operations. These operations are: the 'contains' function as well as the following logical operations: not, and, or, eq (for equal), and ne (for not equal). No arithmetic operations are supported. The following is a valid filter example: $filter=contains(namE, 'PATTERN') and name ne 'PATTERN-1'. The following is not a valid filter example: $filter=location eq 'westus'.
       */
      @query("$filter")
      $filter?: string;

      /**
       * The number of results to return per page for the list operation. Valid range for top parameter is 1 to 100. If not specified, the default number of results to be returned is 20 items per page.
       */
      @query("$top")
      $top?: int32;
    },
    Response = ArmResponse<NamespaceTopicsListResult>
  >;

  /**
   * List the two keys used to publish to a namespace topic.
   */
  @summary("List keys for a namespace topic.")
  @action("listKeys")
  listSharedAccessKeys is ArmResourceActionSync<
    NamespaceTopic,
    void,
    TopicSharedAccessKeys
  >;

  /**
   * Regenerate a shared access key for a namespace topic.
   */
  @summary("Regenerate key for a namespace topic.")
  regenerateKey is ArmResourceActionAsync<
    NamespaceTopic,
    TopicRegenerateKeyRequest,
    TopicSharedAccessKeys
  >;
}

@@maxLength(NamespaceTopic.name, 50);
@@minLength(NamespaceTopic.name, 3);
@@doc(NamespaceTopic.name, "Name of the namespace topic.");
@@doc(NamespaceTopic.properties, "Properties of the namespace topic.");
@@doc(NamespaceTopics.createOrUpdate::parameters.resource,
  "Namespace topic information."
);
@@doc(NamespaceTopics.update::parameters.properties,
  "Namespace topic update information."
);
@@doc(NamespaceTopics.regenerateKey::parameters.body,
  "Request body to regenerate key."
);
