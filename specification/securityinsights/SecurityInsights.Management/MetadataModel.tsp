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
 * Metadata resource definition.
 */
model MetadataModel is Azure.ResourceManager.ProxyResource<MetadataProperties> {
  ...ResourceNameParameter<
    Resource = MetadataModel,
    KeyName = "metadataName",
    SegmentName = "metadata",
    NamePattern = "^\\S+$"
  >;

  /**
   * Etag of the azure resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

alias MetadataWorkspaceExternalResource = Extension.ExternalResource<
  "Microsoft.OperationalInsights",
  "workspaces",
  "{workspaceName}"
>;

@armResourceOperations
interface MetadataModels {
  /**
   * Get a Metadata.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Metadata_Get")
  get is ArmResourceRead<MetadataModel>;

  /**
   * Create a Metadata.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Metadata_Create")
  create is ArmResourceCreateOrReplaceSync<MetadataModel>;

  /**
   * Update an existing Metadata.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Metadata_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<MetadataModel, PatchModel = MetadataPatch>;

  /**
   * Delete a Metadata.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Metadata_Delete")
  delete is ArmResourceDeleteSync<MetadataModel>;

  /**
   * List of all metadata
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Metadata_List")
  list is ArmResourceListByParent<
    MetadataModel,
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
       * Used to skip n elements in the OData query (offset). Returns a nextLink to the next page of results if there are any left.
       */
      @query("$skip")
      $skip?: int32;
    },
    Response = ArmResponse<MetadataList>
  >;
}

@@doc(MetadataModel.name, "The Metadata name.");
@@doc(MetadataModel.properties, "Metadata properties");
@@doc(MetadataModels.create::parameters.resource, "Metadata resource.");
@@doc(MetadataModels.update::parameters.properties,
  "Partial metadata request."
);
