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
 * The properties of a storage account’s Table service.
 */
@singleton("default")
@parentResource(StorageAccount)
model TableServiceProperties
  is Azure.ResourceManager.ProxyResource<TableServicePropertiesProperties> {
  ...ResourceNameParameter<
    Resource = TableServiceProperties,
    KeyName = "tableService",
    SegmentName = "tableServices",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface TableServices {
  /**
   * Gets the properties of a storage account’s Table service, including properties for Storage Analytics and CORS (Cross-Origin Resource Sharing) rules.
   */
  getServiceProperties is ArmResourceRead<
    TableServiceProperties,
    Error = CloudError
  >;

  /**
   * Sets the properties of a storage account’s Table service, including properties for Storage Analytics and CORS (Cross-Origin Resource Sharing) rules.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  setServiceProperties is ArmResourceCreateOrReplaceSync<
    TableServiceProperties,
    Response = ArmResourceUpdatedResponse<TableServiceProperties>,
    Error = CloudError
  >;

  /**
   * List all table services for the storage account.
   */
  list is Azure.ResourceManager.Legacy.ArmListSinglePageByParent<
    TableServiceProperties,
    Response = ArmResponse<ListTableServices>,
    Error = CloudError
  >;
}

@@doc(TableServiceProperties.name, "");
@@doc(TableServiceProperties.properties,
  "The properties of a storage account’s Table service."
);
@@doc(TableServices.setServiceProperties::parameters.resource,
  "The properties of a storage account’s Table service, only properties for Storage Analytics and CORS (Cross-Origin Resource Sharing) rules can be specified."
);
