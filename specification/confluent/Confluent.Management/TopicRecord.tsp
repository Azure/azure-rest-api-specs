import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SCClusterRecord.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Confluent;
/**
 * Details of topic record
 */
@parentResource(SCClusterRecord)
model TopicRecord is Azure.ResourceManager.ProxyResource<TopicProperties> {
  ...ResourceNameParameter<
    Resource = TopicRecord,
    KeyName = "topicName",
    SegmentName = "topics",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface TopicRecordsOps
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

        /**
         * Confluent kafka or schema registry cluster id
         */
        @path
        @segment("clusters")
        clusterId: string,
      },
      {
        /**
         * Confluent kafka or schema registry topic name
         */
        @path
        @segment("topics")
        topicName: string,
      },
      ResourceProviderDefaultErrorResponse
    > {}

@armResourceOperations
interface TopicRecords {
  /**
   * Get confluent topic by Name
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  get is ArmResourceRead<
    TopicRecord,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Create confluent topics by Name
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create is TopicRecordsOps.CreateOrUpdateSync<
    TopicRecord,
    OptionalRequestBody = true
  >;

  /**
   * Delete confluent topic by name
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<TopicRecord>;

  /**
   * Lists of all the topics in a clusters
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  list is ArmResourceListByParent<
    TopicRecord,
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
    Response = ArmResponse<ListTopicsSuccessResponse>,
    Error = ResourceProviderDefaultErrorResponse
  >;
}

@@doc(TopicRecord.name, "Confluent kafka or schema registry topic name");
@@doc(TopicRecord.properties, "Topic Properties");
@@doc(TopicRecords.create::parameters.resource,
  "Confluent Topics resource model"
);
