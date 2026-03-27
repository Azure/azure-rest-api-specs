import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./StorageAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Storage;
/**
 * The properties of a storage account’s Queue service.
 */
@singleton("default")
@parentResource(StorageAccount)
model QueueServiceProperties
  is Azure.ResourceManager.ProxyResource<QueueServicePropertiesProperties> {
  ...ResourceNameParameter<
    Resource = QueueServiceProperties,
    KeyName = "queueService",
    SegmentName = "queueServices",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface QueueServices {
  /**
   * Gets the properties of a storage account’s Queue service, including properties for Storage Analytics and CORS (Cross-Origin Resource Sharing) rules.
   */
  getServiceProperties is ArmResourceRead<
    QueueServiceProperties,
    Error = CloudError
  >;

  /**
   * Sets the properties of a storage account’s Queue service, including properties for Storage Analytics and CORS (Cross-Origin Resource Sharing) rules.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  setServiceProperties is ArmResourceCreateOrReplaceSync<
    QueueServiceProperties,
    Response = ArmResourceUpdatedResponse<QueueServiceProperties>,
    Error = CloudError
  >;

  /**
   * List all queue services for the storage account
   */
  list is Azure.ResourceManager.Legacy.ArmListSinglePageByParent<
    QueueServiceProperties,
    Response = ArmResponse<ListQueueServices>,
    Error = CloudError
  >;

  /**
   * Gets a list of all the queues under the specified storage account
   */
  @get
  @list
  @action("queues")
  queueList is ArmResourceActionSync<
    QueueServiceProperties,
    void,
    ArmResponse<ListQueueResource>,
    Parameters = {
      /**
       * Optional, a maximum number of queues that should be included in a list queue response
       */
      @query("$maxpagesize")
      $maxpagesize?: string;

      /**
       * Optional, When specified, only the queues with a name starting with the given filter will be listed.
       */
      @query("$filter")
      $filter?: string;
    },
    Error = CloudError
  >;
}

@@doc(QueueServiceProperties.name, "");
@@doc(QueueServiceProperties.properties,
  "The properties of a storage account’s Queue service."
);
@@doc(QueueServices.setServiceProperties::parameters.resource,
  "The properties of a storage account’s Queue service, only properties for Storage Analytics and CORS (Cross-Origin Resource Sharing) rules can be specified."
);
