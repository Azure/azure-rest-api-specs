import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * An Extension operation result resource.
 */
@parentResource(Database)
model ImportExportExtensionsOperationResult
  is Azure.ResourceManager.ProxyResource<ImportExportExtensionsOperationResultProperties> {
  ...ResourceNameParameter<
    Resource = ImportExportExtensionsOperationResult,
    KeyName = "extensionName",
    SegmentName = "extensions",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations(#{ omitTags: true })
interface ImportExportExtensionsOperationResults {
  /**
   * Gets a database extension. This will return resource not found as it is not supported.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("DatabaseExtensions")
  get is ArmResourceRead<
    ImportExportExtensionsOperationResult,
    Response = OkResponse
  >;

  /**
   * Perform a database extension operation, like database import, database export, or polybase import
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("DatabaseExtensions")
  createOrUpdate is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    ImportExportExtensionsOperationResult,
    Request = DatabaseExtensions,
    Response = ArmResourceUpdatedResponse<ImportExportExtensionsOperationResult> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ImportExportExtensionsOperationResult> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * List database extension. This will return an empty list as it is not supported.
   */
  @tag("DatabaseExtensions")
  listByDatabase is ArmResourceListByParent<
    ImportExportExtensionsOperationResult,
    Response = ImportExportExtensionsOperationListResult
  >;
}

@@doc(ImportExportExtensionsOperationResult.name, "");
@@doc(ImportExportExtensionsOperationResult.properties, "Resource properties.");
@@doc(ImportExportExtensionsOperationResults.createOrUpdate::parameters.resource,
  "The database import request parameters."
);
