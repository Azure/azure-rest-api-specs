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
@parentResource(FileServiceProperties)
@singleton("default")
model FileServiceUsage
  is Azure.ResourceManager.ProxyResource<FileServiceUsageProperties> {
  ...ResourceNameParameter<
    Resource = FileServiceUsage,
    KeyName = "fileServiceUsageName",
    SegmentName = "usages",
    NamePattern = ""
  >;
}

@armResourceOperations
interface FileServiceUsageOperationGroup {
  /**
   * Gets the usage of file service in storage account including account limits, file share limits and constants used in recommendations and bursting formula.
   */
  getServiceUsage is ArmResourceRead<FileServiceUsage, Error = CloudError>;

  /**
   * Gets the usages of file service in storage account.
   */
  listServiceUsages is ArmResourceListByParent<
    FileServiceUsage,
    Parameters = {
      /**
       * Optional, specifies the maximum number of file service usages to be included in the list response.
       */
      @query("$maxpagesize")
      $maxpagesize?: int32;
    },
    Response = ArmResponse<FileServiceUsages>,
    Error = CloudError
  >;
}

@@doc(FileServiceUsage.name, "");
@@doc(FileServiceUsage.properties,
  "File service usage in storage account including account limits, file share limits and constants used in recommendations and bursting formula."
);
