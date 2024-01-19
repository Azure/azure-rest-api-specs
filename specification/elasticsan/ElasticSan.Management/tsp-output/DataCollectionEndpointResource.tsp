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
@doc("Definition of ARM tracked top level resource.")
model DataCollectionEndpointResource
  is TrackedResource<DataCollectionEndpointResourceProperties> {
  @doc("The name of the data collection endpoint. The name is case insensitive.")
  @path
  @key("dataCollectionEndpointName")
  @segment("dataCollectionEndpoints")
  name: string;

  @doc("Resource entity tag (ETag).")
  @visibility("read")
  etag?: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface DataCollectionEndpointResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns the specified data collection endpoint.")
  @operationId("DataCollectionEndpoints_Get")
  get is ArmResourceRead<DataCollectionEndpointResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates a data collection endpoint.")
  @operationId("DataCollectionEndpoints_Create")
  create is ArmResourceCreateOrReplaceSync<DataCollectionEndpointResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates part of a data collection endpoint.")
  @operationId("DataCollectionEndpoints_Update")
  update is ArmCustomPatchSync<
    DataCollectionEndpointResource,
    ResourceForUpdate
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a data collection endpoint.")
  @operationId("DataCollectionEndpoints_Delete")
  delete is ArmResourceDeleteSync<DataCollectionEndpointResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists all data collection endpoints in the specified resource group.")
  @operationId("DataCollectionEndpoints_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<DataCollectionEndpointResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists all data collection endpoints in the specified subscription")
  @operationId("DataCollectionEndpoints_ListBySubscription")
  listBySubscription is ArmListBySubscription<DataCollectionEndpointResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DataCollectionRuleAssociations_ListByDataCollectionEndpoint")
  @summary("Lists associations for the specified data collection endpoint.")
  @doc("Lists associations for the specified data collection endpoint.")
  // FIXME: DataCollectionRuleAssociations_ListByDataCollectionEndpoint could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/dataCollectionEndpoints/{dataCollectionEndpointName}/associations")
  @get
  listByDataCollectionEndpoint is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the data collection endpoint. The name is case insensitive.")
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
