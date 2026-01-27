import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VirtualResource.tsp";

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

@armResourceOperations
interface MetadataModels {
  /**
   * Get a Metadata.
   */
  get is Extension.Read<OperationalInsights, MetadataModel, Error = CloudError>;

  /**
   * Create a Metadata.
   */
  create is Extension.CreateOrReplaceSync<
    OperationalInsights,
    MetadataModel,
    Error = CloudError
  >;

  /**
   * Update an existing Metadata.
   */
  @patch(#{ implicitOptionality: false })
  update is Extension.CustomPatchSync<
    OperationalInsights,
    MetadataModel,
    PatchModel = MetadataPatch,
    Error = CloudError
  >;

  /**
   * Delete a Metadata.
   */
  delete is Extension.DeleteSync<
    OperationalInsights,
    MetadataModel,
    Error = CloudError
  >;

  /**
   * List of all metadata
   */
  list is Extension.ListByTarget<
    OperationalInsights,
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
    Response = ArmResponse<MetadataList>,
    Error = CloudError
  >;
}

@@doc(MetadataModel.name, "The Metadata name.");
@@doc(MetadataModel.properties, "Metadata properties");
@@doc(MetadataModels.create::parameters.resource, "Metadata resource.");
@@doc(MetadataModels.update::parameters.properties,
  "Partial metadata request."
);
