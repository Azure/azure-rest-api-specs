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
 * The properties of File services in storage account.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@singleton("default")
@parentResource(StorageAccount)
model FileServiceProperties
  is Azure.ResourceManager.ProxyResource<FileServicePropertiesProperties> {
  ...ResourceNameParameter<
    Resource = FileServiceProperties,
    KeyName = "FileServicesName",
    SegmentName = "fileServices",
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
interface FileServices {
  /**
   * Gets the properties of file services in storage accounts, including CORS (Cross-Origin Resource Sharing) rules.
   */
  getServiceProperties is ArmResourceRead<
    FileServiceProperties,
    Error = CloudError
  >;

  /**
   * Sets the properties of file services in storage accounts, including CORS (Cross-Origin Resource Sharing) rules.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  setServiceProperties is ArmResourceCreateOrReplaceSync<
    FileServiceProperties,
    Response = ArmResourceUpdatedResponse<FileServiceProperties>,
    Error = CloudError
  >;

  /**
   * List all file services in storage accounts
   */
  list is Azure.ResourceManager.Legacy.ArmListSinglePageByParent<
    FileServiceProperties,
    Response = ArmResponse<FileServiceItems>,
    Error = CloudError
  >;

  /**
   * Lists all shares.
   */
  @get
  @list
  @action("shares")
  fileSharesList is ArmResourceActionSync<
    FileServiceProperties,
    void,
    ArmResponse<FileShareItems>,
    Parameters = {
      /**
       * Optional. Specified maximum number of shares that can be included in the list.
       */
      @query("$maxpagesize")
      $maxpagesize?: string;

      /**
       * Optional. When specified, only share names starting with the filter will be listed.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Optional, used to expand the properties within share's properties. Valid values are: deleted, snapshots. Should be passed as a string with delimiter ','
       */
      @query("$expand")
      $expand?: string;
    },
    Error = CloudError
  >;
}

@@doc(FileServiceProperties.name, "");
@@doc(FileServiceProperties.properties,
  "The properties of File services in storage account."
);
@@doc(FileServices.setServiceProperties::parameters.resource,
  "The properties of file services in storage accounts, including CORS (Cross-Origin Resource Sharing) rules."
);
