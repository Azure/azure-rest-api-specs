import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Insights;
/**
 * Definition of ARM tracked top level resource.
 */
model DataCollectionEndpointResource
  is Azure.ResourceManager.TrackedResource<DataCollectionEndpointResourceProperties> {
  ...ResourceNameParameter<
    Resource = DataCollectionEndpointResource,
    KeyName = "dataCollectionEndpointName",
    SegmentName = "dataCollectionEndpoints",
    NamePattern = ""
  >;

  /**
   * The kind of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind?: KnownDataCollectionEndpointResourceKind;

  /**
   * The SKU of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: DataCollectionEndpointResourceSku;

  /**
   * Managed service identity of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: DataCollectionEndpointResourceIdentity;

  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations(#{ omitTags: true })
interface DataCollectionEndpointResources {
  /**
   * Returns the specified data collection endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DataCollectionEndpoints_Get")
  @tag("DataCollectionEndpoints")
  get is ArmResourceRead<
    DataCollectionEndpointResource,
    Error = ErrorResponseCommonV2
  >;

  /**
   * Creates or updates a data collection endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DataCollectionEndpoints_Create")
  @tag("DataCollectionEndpoints")
  create is Azure.ResourceManager.Legacy.CreateOrUpdateSync<
    DataCollectionEndpointResource,
    OptionalRequestBody = true,
    Error = ErrorResponseCommonV2
  >;

  /**
   * Updates part of a data collection endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DataCollectionEndpoints_Update")
  @patch(#{ implicitOptionality: false })
  @tag("DataCollectionEndpoints")
  update is Azure.ResourceManager.Legacy.CustomPatchSync<
    DataCollectionEndpointResource,
    PatchModel = ResourceForUpdate,
    OptionalRequestBody = true,
    Error = ErrorResponseCommonV2
  >;

  /**
   * Deletes a data collection endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DataCollectionEndpoints_Delete")
  @tag("DataCollectionEndpoints")
  delete is ArmResourceDeleteSync<
    DataCollectionEndpointResource,
    Error = ErrorResponseCommonV2
  >;

  /**
   * Lists all data collection endpoints in the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DataCollectionEndpoints_ListByResourceGroup")
  @tag("DataCollectionEndpoints")
  listByResourceGroup is ArmResourceListByParent<
    DataCollectionEndpointResource,
    Error = ErrorResponseCommonV2
  >;

  /**
   * Lists all data collection endpoints in the specified subscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DataCollectionEndpoints_ListBySubscription")
  @tag("DataCollectionEndpoints")
  listBySubscription is ArmListBySubscription<
    DataCollectionEndpointResource,
    Error = ErrorResponseCommonV2
  >;

  /**
   * Lists associations for the specified data collection endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DataCollectionRuleAssociations_ListByDataCollectionEndpoint")
  @list
  @get
  @action("associations")
  @tag("DataCollectionRuleAssociations")
  listByDataCollectionEndpoint is ArmResourceActionSync<
    DataCollectionEndpointResource,
    void,
    ArmResponse<ResourceListResult<DataCollectionRuleAssociationProxyOnlyResource>>,
    Error = ErrorResponseCommonV2
  >;
}

@@doc(DataCollectionEndpointResource.name,
  "The name of the data collection endpoint. The name is case insensitive."
);
@@doc(DataCollectionEndpointResource.properties, "");
@@doc(DataCollectionEndpointResources.create::parameters.resource,
  "The payload"
);
@@doc(DataCollectionEndpointResources.update::parameters.properties,
  "The payload"
);
