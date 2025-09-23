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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Private.armResourceInternal(EnvironmentProperties)
@TypeSpec.Http.Private.includeInapplicableMetadataInPayload(false)
@parentResource(OrganizationResource)
model SCEnvironmentRecord extends Foundations.ProxyResource {
  ...ResourceNameParameter<
    Resource = SCEnvironmentRecord,
    KeyName = "environmentId",
    SegmentName = "environments",
    NamePattern = ""
  >;

  /**
   * Type of environment
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;

  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @doc("The resource-specific properties for this resource.")
  properties?: EnvironmentProperties;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface SCEnvironmentRecordsOps
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
      },
      {
        /**
         * Confluent environment id
         */
        @path
        @segment("environments")
        environmentId: string,
      },
      ResourceProviderDefaultErrorResponse
    > {}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface SCEnvironmentRecords {
  /**
   * Get Environment details by environment Id
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  getEnvironmentById is ArmResourceRead<
    SCEnvironmentRecord,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Create confluent environment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is SCEnvironmentRecordsOps.CreateOrUpdateSync<
    SCEnvironmentRecord,
    OptionalRequestBody = true
  >;

  /**
   * Delete confluent environment by id
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<SCEnvironmentRecord>;

  /**
   * Lists of all the environments in a organization
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @action("schemaRegistryClusters")
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface SCEnvironmentRecordClusterOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface SCEnvironmentRecordCluster {
  /**
   * Get schema registry cluster by Id
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  getSchemaRegistryClusterById is SCEnvironmentRecordClusterOps.Read<
    SCEnvironmentRecord,
    {},
    ArmResponse<SchemaRegistryClusterRecord>
  >;
}

@@doc(SCEnvironmentRecord.name, "Confluent environment id");
@@doc(SCEnvironmentRecord.properties, "Environment properties");
@@doc(SCEnvironmentRecords.createOrUpdate::parameters.resource,
  "Confluent Environment resource model"
);
