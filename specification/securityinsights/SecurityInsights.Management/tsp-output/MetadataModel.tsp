import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.SecurityInsights;
@doc("Metadata resource definition.")
model MetadataModel is ProxyResource<MetadataProperties> {
  @doc("The Metadata name.")
  @path
  @key("metadataName")
  @segment("metadata")
  name: string;
}

@armResourceOperations
interface MetadataModels {
  @doc("Get a Metadata.")
  get is ArmResourceRead<MetadataModel>;
  @doc("Create a Metadata.")
  create is ArmResourceCreateOrReplaceSync<MetadataModel>;
  @doc("Update an existing Metadata.")
  update is ArmResourcePatchSync<MetadataModel, MetadataProperties>;
  @doc("Delete a Metadata.")
  delete is ArmResourceDeleteSync<MetadataModel>;
  @doc("List of all metadata")
  list is ArmResourceListByParent<
    MetadataModel,
    {
      ...BaseParameters<MetadataModel>;

      @doc("Filters the results, based on a Boolean condition. Optional.")
      @query("$filter")
      $filter?: string;

      @doc("Sorts the results. Optional.")
      @query("$orderby")
      $orderby?: string;

      @doc("Returns only the first n results. Optional.")
      @query("$top")
      $top?: int32;

      @doc("Used to skip n elements in the OData query (offset). Returns a nextLink to the next page of results if there are any left.")
      @query("$skip")
      $skip?: int32;
    }
  >;
}
