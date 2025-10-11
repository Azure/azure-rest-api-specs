import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ClusterResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DocumentDB;
/**
 * A managed Cassandra data center.
 */
@parentResource(ClusterResource)
model DataCenterResource
  is Azure.ResourceManager.ProxyResource<DataCenterResourceProperties> {
  ...ResourceNameParameter<
    Resource = DataCenterResource,
    KeyName = "dataCenterName",
    SegmentName = "dataCenters",
    NamePattern = "^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*$"
  >;
}

@armResourceOperations
interface DataCenterResources {
  /**
   * Get the properties of a managed Cassandra data center.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CassandraDataCenters_Get")
  get is ArmResourceRead<DataCenterResource>;

  /**
   * Create or update a managed Cassandra data center. When updating, overwrite all properties. To update only some properties, use PATCH.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CassandraDataCenters_CreateUpdate")
  createUpdate is ArmResourceCreateOrReplaceAsync<
    DataCenterResource,
    LroHeaders = ArmLroLocationHeader<FinalResult = DataCenterResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update some of the properties of a managed Cassandra data center.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("CassandraDataCenters_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    DataCenterResource,
    PatchModel = DataCenterResource,
    Response = ArmResponse<DataCenterResource> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = DataCenterResource> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: DataCenterResource;
    })
  >;

  /**
   * Delete a managed Cassandra data center.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CassandraDataCenters_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<DataCenterResource>;

  /**
   * List all data centers in a particular managed Cassandra cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CassandraDataCenters_List")
  list is ArmResourceListByParent<
    DataCenterResource,
    Response = ArmResponse<ListDataCenters>
  >;
}

@@maxLength(DataCenterResource.name, 100);
@@minLength(DataCenterResource.name, 1);
@@doc(DataCenterResource.name,
  "Data center name in a managed Cassandra cluster."
);
@@doc(DataCenterResource.properties,
  "Properties of a managed Cassandra data center."
);
@@doc(DataCenterResources.createUpdate::parameters.resource,
  "Parameters specifying the managed Cassandra data center."
);
@@doc(DataCenterResources.update::parameters.properties,
  "Parameters to provide for specifying the managed Cassandra data center."
);
