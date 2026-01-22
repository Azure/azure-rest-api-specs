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
 * EventGrid Topic
 */
model Topic is Azure.ResourceManager.TrackedResource<TopicProperties> {
  ...ResourceNameParameter<
    Resource = Topic,
    KeyName = "topicName",
    SegmentName = "topics",
    NamePattern = ""
  >;

  /**
   * The Sku pricing tier for the topic.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: ResourceSku;

  /**
   * Identity information for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: IdentityInfo;

  /**
   * Kind of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: ResourceKind = ResourceKind.Azure;

  /**
   * Extended location of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface Topics {
  /**
   * Get properties of a topic.
   */
  @summary("Get a topic.")
  get is ArmResourceRead<Topic>;

  /**
   * Asynchronously creates a new topic with the specified parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Create a topic.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Topic,
    Response = ArmResourceCreatedResponse<
      Topic,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Asynchronously updates a topic with the specified parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Update a topic.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Topic,
    PatchModel = TopicUpdateParameters,
    Response = {
      @body body: void;
    } | ArmResourceCreatedResponse<Topic, LroHeaders = ArmLroLocationHeader>
  >;

  /**
   * Delete existing topic.
   */
  @summary("Delete a topic.")
  delete is ArmResourceDeleteWithoutOkAsync<Topic>;

  /**
   * List all the topics under a resource group.
   */
  @summary("List topics under a resource group.")
  listByResourceGroup is ArmResourceListByParent<
    Topic,
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
    Response = ArmResponse<TopicsListResult>
  >;

  /**
   * List all the topics under an Azure subscription.
   */
  @summary("List topics under an Azure subscription.")
  listBySubscription is ArmListBySubscription<
    Topic,
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
    Response = ArmResponse<TopicsListResult>
  >;

  /**
   * List the two keys used to publish to a topic.
   */
  @summary("List keys for a topic.")
  @action("listKeys")
  listSharedAccessKeys is ArmResourceActionSync<
    Topic,
    void,
    TopicSharedAccessKeys
  >;

  /**
   * Regenerate a shared access key for a topic.
   */
  @summary("Regenerate key for a topic.")
  regenerateKey is ArmResourceActionAsync<
    Topic,
    TopicRegenerateKeyRequest,
    TopicSharedAccessKeys
  >;
}

@@doc(Topic.name, "Name of the topic.");
@@doc(Topic.properties, "Properties of the topic.");
@@doc(Topics.createOrUpdate::parameters.resource, "Topic information.");
@@doc(Topics.update::parameters.properties, "Topic update information.");
@@doc(Topics.regenerateKey::parameters.body, "Request body to regenerate key.");
