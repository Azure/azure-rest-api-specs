import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./OrganizationResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Confluent;
/**
 * Details about environment name, metadata and environment id of an environment
 */
@parentResource(OrganizationResource)
model SCEnvironmentRecord
  is Azure.ResourceManager.ProxyResource<EnvironmentProperties> {
  ...ResourceNameParameter<
    Resource = SCEnvironmentRecord,
    KeyName = "environmentId",
    SegmentName = "environments",
    NamePattern = ""
  >;

  /**
   * Type of environment
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind?: string;
}

@armResourceOperations
interface SCEnvironmentRecords {
  /**
   * Get Environment details by environment Id
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Organization_GetEnvironmentById")
  getEnvironmentById is ArmResourceRead<
    SCEnvironmentRecord,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Create confluent environment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Environment_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    SCEnvironmentRecord,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Delete confluent environment by id
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Environment_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<SCEnvironmentRecord>;

  /**
   * Lists of all the environments in a organization
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Organization_ListEnvironments")
  listEnvironments is ArmResourceListByParent<
    SCEnvironmentRecord,
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
    Response = ArmResponse<GetEnvironmentsResponse>,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Get schema registry clusters
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("schemaRegistryClusters")
  @operationId("Organization_ListSchemaRegistryClusters")
  listSchemaRegistryClusters is ArmResourceActionSync<
    SCEnvironmentRecord,
    void,
    ArmResponse<ListSchemaRegistryClustersResponse>,
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
    Error = ResourceProviderDefaultErrorResponse
  >;
}

interface SCEnvironmentRecordClusterOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,

        /**
         * Organization resource name
         */
        @path @segment("organizations") organizationName: string,

        /**
         * Confluent environment id
         */
        @path @segment("environments") environmentId: string,
      },
      {
        /**
         * Confluent connector name
         */
        @path @segment("schemaRegistryClusters") clusterId: string,
      },
      ResourceProviderDefaultErrorResponse
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator"
interface SCEnvironmentRecordCluster {
  /**
   * Get schema registry cluster by Id
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @operationId("Organization_GetSchemaRegistryClusterById")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Confluent/organizations/{organizationName}/environments/{environmentId}/schemaRegistryClusters/{clusterId}")
  getSchemaRegistryClusterById is SCEnvironmentRecordClusterOps.ActionSync<
    SCEnvironmentRecord,
    void,
    ArmResponse<SchemaRegistryClusterRecord>
  >;
}

@@doc(SCEnvironmentRecord.name, "Confluent environment id");
@@doc(SCEnvironmentRecord.properties, "Environment properties");
@@doc(SCEnvironmentRecords.createOrUpdate::parameters.resource,
  "Confluent Environment resource model"
);
