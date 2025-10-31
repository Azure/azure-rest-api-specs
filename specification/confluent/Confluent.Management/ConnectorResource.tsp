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
 * Details of connector record
 */
@parentResource(SCClusterRecord)
model ConnectorResource
  is Azure.ResourceManager.ProxyResource<ConnectorResourceProperties, false> {
  ...ResourceNameParameter<
    Resource = ConnectorResource,
    KeyName = "connectorName",
    SegmentName = "connectors",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ConnectorResourcesOps
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
         * Confluent connector name
         */
        @path
        @segment("connectors")
        connectorName: string,
      },
      ResourceProviderDefaultErrorResponse
    > {}

@armResourceOperations
interface ConnectorResources {
  /**
   * Get confluent connector by Name
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  get is ArmResourceRead<
    ConnectorResource,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Create confluent connector by Name
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ConnectorResourcesOps.CreateOrUpdateSync<
    ConnectorResource,
    OptionalRequestBody = true
  >;

  /**
   * Delete confluent connector by name
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    ConnectorResource,
    Error = ErrorResponse
  >;

  /**
   * Lists all the connectors in a cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  list is ArmResourceListByParent<
    ConnectorResource,
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
    Response = ArmResponse<ListConnectorsSuccessResponse>,
    Error = ResourceProviderDefaultErrorResponse
  >;
}

@@doc(ConnectorResource.name, "Confluent connector name");
@@doc(ConnectorResource.properties, "The properties of the Connector");
@@doc(ConnectorResources.createOrUpdate::parameters.resource,
  "Confluent Connector resource model"
);
