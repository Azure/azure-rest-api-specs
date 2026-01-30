import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityInsights;
/**
 * Represents a file import in Azure Security Insights.
 */
model FileImport is Azure.ResourceManager.ProxyResource<FileImportProperties> {
  ...ResourceNameParameter<
    Resource = FileImport,
    KeyName = "fileImportId",
    SegmentName = "fileImports",
    NamePattern = ""
  >;
}

@armResourceOperations
interface FileImports {
  /**
   * Gets a file import.
   */
  get is Extension.Read<workspaceExternalResource, FileImport>;

  /**
   * Creates the file import.
   */
  create is Extension.CreateOrReplaceSync<
    workspaceExternalResource,
    FileImport
  >;

  /**
   * Delete the file import.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is Extension.DeleteWithoutOkAsync<
    workspaceExternalResource,
    FileImport,
    Response = (ArmDeleteAcceptedLroResponse & {
      @bodyRoot
      _: FileImport;
    }) | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all file imports.
   */
  list is Extension.ListByTarget<
    workspaceExternalResource,
    FileImport,
    Parameters = {
      /**
       * Filters the results, based on a Boolean condition. Optional.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Sorts the results. Optional.
       */
      @query("$orderby")
      $orderby?: string;

      /**
       * Returns only the first n results. Optional.
       */
      @query("$top")
      $top?: int32;

      /**
       * Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls. Optional.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = ArmResponse<FileImportList>
  >;
}

@@doc(FileImport.name, "File import ID");
@@doc(FileImport.properties, "File import properties");
@@doc(FileImports.create::parameters.resource, "The file import");
