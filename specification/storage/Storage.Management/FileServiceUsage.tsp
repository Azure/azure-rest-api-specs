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
 * The usage of file service in storage account.
 */
@singleton("default")
@parentResource(FileService)
model FileServiceUsage
  is Azure.ResourceManager.ProxyResource<FileServiceUsageProperties> {
  ...ResourceNameParameter<
    Resource = FileServiceUsage,
    KeyName = "usage",
    SegmentName = "usages",
    NamePattern = ""
  >;
}

@singleton("default")
@parentResource(StorageAccount)
model FileService
  is Azure.ResourceManager.ProxyResource<FileServiceProperties> {
  ...ResourceNameParameter<
    Resource = FileServiceProperties,
    KeyName = "FileServicesName",
    SegmentName = "fileServices",
    NamePattern = ""
  >;
}

@armResourceOperations
interface FileServiceUsageOperationGroup {
  /**
   * Gets the usage of file service in storage account including account limits, file share limits and constants used in recommendations and bursting formula.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("FileServices_GetServiceUsage")
  getServiceUsage is ArmResourceRead<FileServiceUsage>;

  /**
   * Gets the usages of file service in storage account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("FileServices_ListServiceUsages")
  listServiceUsages is ArmResourceListByParent<
    FileServiceUsage,
    Parameters = {
      /**
       * Optional, specifies the maximum number of file service usages to be included in the list response.
       */
      @query("$maxpagesize")
      $maxpagesize?: int32;
    },
    Response = ArmResponse<FileServiceUsages>
  >;
}

@@doc(FileServiceUsage.name, "");
@@doc(FileServiceUsage.properties,
  "File service usage in storage account including account limits, file share limits and constants used in recommendations and bursting formula."
);
