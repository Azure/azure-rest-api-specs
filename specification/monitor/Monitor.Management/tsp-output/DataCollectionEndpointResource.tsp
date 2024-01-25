import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Insights;
/**
 * Definition of ARM tracked top level resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  DataCollectionEndpointResourceProperties
)
model DataCollectionEndpointResource extends TrackedResourceBase {
  /**
   * The name of the data collection endpoint. The name is case insensitive.
   */
  @path
  @key("dataCollectionEndpointName")
  @segment("dataCollectionEndpoints")
  @visibility("read")
  name: string;

  /**
   * The kind of the resource.
   */
  kind?: KnownDataCollectionEndpointResourceKind;

  /**
   * Resource entity tag (ETag).
   */
  @visibility("read")
  etag?: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: DataCollectionEndpointResourceProperties;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface DataCollectionEndpointResources {
  /**
   * Returns the specified data collection endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DataCollectionEndpoints_Get")
  get is ArmResourceRead<DataCollectionEndpointResource>;

  /**
   * Creates or updates a data collection endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DataCollectionEndpoints_Create")
  create is ArmResourceCreateOrReplaceSync<DataCollectionEndpointResource>;

  /**
   * Updates part of a data collection endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("DataCollectionEndpoints_Update")
  update is ArmCustomPatchSync<
    DataCollectionEndpointResource,
    ResourceForUpdate
  >;

  /**
   * Deletes a data collection endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DataCollectionEndpoints_Delete")
  delete is ArmResourceDeleteSync<DataCollectionEndpointResource>;

  /**
   * Lists all data collection endpoints in the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DataCollectionEndpoints_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<DataCollectionEndpointResource>;

  /**
   * Lists all data collection endpoints in the specified subscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DataCollectionEndpoints_ListBySubscription")
  listBySubscription is ArmListBySubscription<DataCollectionEndpointResource>;

  /**
   * Lists associations for the specified data collection endpoint.
   */
  // FIXME: DataCollectionRuleAssociations_ListByDataCollectionEndpoint could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DataCollectionRuleAssociations_ListByDataCollectionEndpoint")
  @summary("Lists associations for the specified data collection endpoint.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/dataCollectionEndpoints/{dataCollectionEndpointName}/associations")
  @get
  listByDataCollectionEndpoint is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the data collection endpoint. The name is case insensitive.
       */
      @path
      dataCollectionEndpointName: string;
    },
    ResourceListResult<DataCollectionRuleAssociationProxyOnlyResource>
  >;
}

@@projectedName(DataCollectionEndpointResources.create::parameters.resource,
  "json",
  "body"
);
@@extension(DataCollectionEndpointResources.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(DataCollectionEndpointResources.create::parameters.resource,
  "The payload"
);
@@projectedName(DataCollectionEndpointResources.update::parameters.properties,
  "json",
  "body"
);
@@extension(DataCollectionEndpointResources.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(DataCollectionEndpointResources.update::parameters.properties,
  "The payload"
);
