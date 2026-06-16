import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataCollection;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: KnownDataCollectionEndpointResourceKind;

  /**
   * The SKU of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: DataCollectionEndpointResourceSku;

  /**
   * Managed service identity of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: DataCollectionEndpointResourceIdentity;

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations(#{ omitTags: true })
interface DataCollectionEndpointResources {
  /**
   * Returns the specified data collection endpoint.
   */
  @tag("DataCollectionEndpoints")
  @summary("Returns the specified data collection endpoint.")
  get is ArmResourceRead<
    DataCollectionEndpointResource,
    Error = ErrorResponseCommonV2
  >;

  /**
   * Creates or updates a data collection endpoint.
   */
  @tag("DataCollectionEndpoints")
  @summary("Creates or updates a data collection endpoint.")
  create is Azure.ResourceManager.Legacy.CreateOrUpdateSync<
    DataCollectionEndpointResource,
    OptionalRequestBody = true,
    Error = ErrorResponseCommonV2
  >;

  /**
   * Updates part of a data collection endpoint.
   */
  @patch(#{ implicitOptionality: false })
  @tag("DataCollectionEndpoints")
  @summary("Updates part of a data collection endpoint.")
  update is Azure.ResourceManager.Legacy.CustomPatchSync<
    DataCollectionEndpointResource,
    PatchModel = ResourceForUpdate,
    OptionalRequestBody = true,
    Error = ErrorResponseCommonV2
  >;

  /**
   * Deletes a data collection endpoint.
   */
  @tag("DataCollectionEndpoints")
  @summary("Deletes a data collection endpoint.")
  delete is ArmResourceDeleteSync<
    DataCollectionEndpointResource,
    Error = ErrorResponseCommonV2
  >;

  /**
   * Lists all data collection endpoints in the specified resource group.
   */
  @tag("DataCollectionEndpoints")
  @summary("Lists all data collection endpoints in the specified resource group.")
  listByResourceGroup is ArmResourceListByParent<
    DataCollectionEndpointResource,
    Error = ErrorResponseCommonV2
  >;

  /**
   * Lists all data collection endpoints in the specified subscription
   */
  @tag("DataCollectionEndpoints")
  @summary("Lists all data collection endpoints in the specified subscription")
  listBySubscription is ArmListBySubscription<
    DataCollectionEndpointResource,
    Error = ErrorResponseCommonV2
  >;

  /**
   * Lists associations for the specified data collection endpoint.
   */
  @list
  @get
  @action("associations")
  @tag("DataCollectionRuleAssociations")
  @summary("Lists associations for the specified data collection endpoint.")
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
