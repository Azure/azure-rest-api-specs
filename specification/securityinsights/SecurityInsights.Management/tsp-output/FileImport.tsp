import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.SecurityInsights;
@doc("Represents a file import in Azure Security Insights.")
model FileImport is ProxyResource<FileImportProperties> {
  @doc("File import ID")
  @path
  @key("fileImportId")
  @segment("fileImports")
  name: string;
}

@armResourceOperations
interface FileImports {
  @doc("Gets a file import.")
  get is ArmResourceRead<FileImport>;
  @doc("Creates the file import.")
  create is ArmResourceCreateOrReplaceSync<FileImport>;
  @doc("Delete the file import.")
  delete is ArmResourceDeleteWithoutOkAsync<FileImport>;
  @doc("Gets all file imports.")
  list is ArmResourceListByParent<
    FileImport,
    {
      ...BaseParameters<FileImport>;

      @doc("Filters the results, based on a Boolean condition. Optional.")
      @query("$filter")
      $filter?: string;

      @doc("Sorts the results. Optional.")
      @query("$orderby")
      $orderby?: string;

      @doc("Returns only the first n results. Optional.")
      @query("$top")
      $top?: int32;

      @doc("Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls. Optional.")
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
}
