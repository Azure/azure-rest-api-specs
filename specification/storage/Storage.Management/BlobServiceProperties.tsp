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
 * The properties of a storage account’s Blob service.
 */
@singleton("default")
@parentResource(StorageAccount)
model BlobServiceProperties
  is Azure.ResourceManager.ProxyResource<BlobServicePropertiesProperties> {
  ...ResourceNameParameter<
    Resource = BlobServiceProperties,
    KeyName = "blobService",
    SegmentName = "blobServices",
    NamePattern = ""
  >;

  /**
   * Sku name and tier.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  sku?: Sku;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface BlobServices {
  /**
   * Gets the properties of a storage account’s Blob service, including properties for Storage Analytics and CORS (Cross-Origin Resource Sharing) rules.
   */
  getServiceProperties is ArmResourceRead<
    BlobServiceProperties,
    Error = ErrorResponse
  >;

  /**
   * Sets the properties of a storage account’s Blob service, including properties for Storage Analytics and CORS (Cross-Origin Resource Sharing) rules.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  setServiceProperties is ArmResourceCreateOrReplaceSync<
    BlobServiceProperties,
    Response = ArmResourceUpdatedResponse<BlobServiceProperties>,
    Error = ErrorResponse
  >;

  /**
   * List blob services of storage account. It returns a collection of one object named default.
   */
  list is ArmResourceListByParent<
    BlobServiceProperties,
    Response = ArmResponse<BlobServiceItems>,
    Error = ErrorResponse
  >;

  /**
   * Lists all containers and does not support a prefix like data plane. Also SRP today does not return continuation token.
   */
  @get
  @list
  @action("containers")
  blobContainersList is ArmResourceActionSync<
    BlobServiceProperties,
    void,
    ArmResponse<ListContainerItems>,
    Parameters = {
      /**
       * Optional. Specified maximum number of containers that can be included in the list.
       */
      @query("$maxpagesize")
      $maxpagesize?: string;

      /**
       * Optional. When specified, only container names starting with the filter will be listed.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Optional, used to include the properties for soft deleted blob containers.
       */
      @query("$include")
      $include?: ListContainersInclude;
    },
    Error = ErrorResponse
  >;
}

@@doc(BlobServiceProperties.name, "");
@@doc(BlobServiceProperties.properties,
  "The properties of a storage account’s Blob service."
);
@@doc(BlobServices.setServiceProperties::parameters.resource,
  "The properties of a storage account’s Blob service, including properties for Storage Analytics and CORS (Cross-Origin Resource Sharing) rules."
);
