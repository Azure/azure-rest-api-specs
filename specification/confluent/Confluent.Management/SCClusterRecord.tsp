import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SCEnvironmentRecord.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Confluent;
/**
 * Details of cluster record
 */
@parentResource(SCEnvironmentRecord)
model SCClusterRecord
  is Azure.ResourceManager.ProxyResource<ClusterProperties> {
  ...ResourceNameParameter<
    Resource = SCClusterRecord,
    KeyName = "clusterId",
    SegmentName = "clusters",
    NamePattern = ""
  >;

  /**
   * Type of cluster
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind?: string;
}

@armResourceOperations
interface SCClusterRecords {
  /**
   * Get cluster by Id
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Organization_GetClusterById")
  getClusterById is ArmResourceRead<
    SCClusterRecord,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Create confluent clusters
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Cluster_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    SCClusterRecord,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Delete confluent cluster by id
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Cluster_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    SCClusterRecord,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Lists of all the clusters in a environment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Organization_ListClusters")
  listClusters is ArmResourceListByParent<
    SCClusterRecord,
    Parameters = {
      /**
       * Pagination size
       */
      @query("pageSize")
      pageSize?: int32;

      /**
       * An opaque pagination token to fetch the next set of records
       */
      @query("pageToken")
      pageToken?: string;
    },
    Response = ArmResponse<ListClustersSuccessResponse>,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Creates API key for a schema registry Cluster ID or Kafka Cluster ID under a environment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Organization_CreateAPIKey")
  createAPIKey is ArmResourceActionSync<
    SCClusterRecord,
    CreateAPIKeyModel,
    ArmResponse<APIKeyRecord>,
    Error = ResourceProviderDefaultErrorResponse
  >;
}

@@doc(SCClusterRecord.name, "Confluent kafka or schema registry cluster id");
@@doc(SCClusterRecord.properties, "Cluster Properties");
@@doc(SCClusterRecords.createOrUpdate::parameters.resource,
  "Confluent Cluster resource model"
);
@@doc(SCClusterRecords.createAPIKey::parameters.body,
  "Request payload for get creating API Key for schema registry Cluster ID or Kafka Cluster ID under a environment"
);
