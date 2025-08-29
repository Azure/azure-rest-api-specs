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
 * EventGrid System Topic.
 */
model SystemTopic
  is Azure.ResourceManager.TrackedResource<SystemTopicProperties> {
  ...ResourceNameParameter<
    Resource = SystemTopic,
    KeyName = "systemTopicName",
    SegmentName = "systemTopics",
    NamePattern = ""
  >;

  /**
   * Identity information for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: IdentityInfo;
}

@armResourceOperations
interface SystemTopics {
  /**
   * Get properties of a system topic.
   */
  get is ArmResourceRead<SystemTopic>;

  /**
   * Asynchronously creates a new system topic with the specified parameters.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    SystemTopic,
    LroHeaders = ArmLroLocationHeader<FinalResult = SystemTopic> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Asynchronously updates a system topic with the specified parameters.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    SystemTopic,
    PatchModel = SystemTopicUpdateParameters,
    Response = ArmResponse<SystemTopic> | ArmResourceCreatedResponse<SystemTopic>
  >;

  /**
   * Delete existing system topic.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    SystemTopic,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all the system topics under a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    SystemTopic,
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
    }
  >;

  /**
   * List all the system topics under an Azure subscription.
   */
  listBySubscription is ArmListBySubscription<
    SystemTopic,
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
    }
  >;
}

@@doc(SystemTopic.name, "Name of the system topic.");
@@doc(SystemTopic.properties, "Properties of the system topic.");
@@doc(SystemTopics.createOrUpdate::parameters.resource,
  "System Topic information."
);
@@doc(SystemTopics.update::parameters.properties,
  "SystemTopic update information."
);
