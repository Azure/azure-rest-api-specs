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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Private.armResourceInternal(ClusterProperties)
@TypeSpec.Http.Private.includeInapplicableMetadataInPayload(false)
@parentResource(SCEnvironmentRecord)
model SCClusterRecord extends Foundations.ProxyResource {
  ...ResourceNameParameter<
    Resource = SCClusterRecord,
    KeyName = "clusterId",
    SegmentName = "clusters",
    NamePattern = ""
  >;

  /**
   * Type of cluster
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;

  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @doc("The resource-specific properties for this resource.")
  properties?: ClusterProperties;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface SCClusterRecordsOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /**
         * Organization resource name
         */
        @path
        @segment("organizations")
        organizationName: string,

        /**
         * Confluent environment id
         */
        @path
        @segment("environments")
        environmentId: string,
      },
      {
        /**
         * Confluent kafka or schema registry cluster id
         */
        @path
        @segment("clusters")
        clusterId: string,
      },
      ResourceProviderDefaultErrorResponse
    > {}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface SCClusterRecords {
  /**
   * Get cluster by Id
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  getClusterById is ArmResourceRead<
    SCClusterRecord,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Create confluent clusters
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is SCClusterRecordsOps.CreateOrUpdateSync<
    SCClusterRecord,
    OptionalRequestBody = true
  >;

  /**
   * Delete confluent cluster by id
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    SCClusterRecord,
    Error = ErrorResponse
  >;

  /**
   * Lists of all the clusters in a environment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
