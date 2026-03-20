import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VirtualResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityInsights;
/**
 * Data connector
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DataConnector
  is Azure.ResourceManager.Legacy.DiscriminatedProxyResource<DataConnectorKind> {
  ...ResourceNameParameter<
    Resource = DataConnector,
    KeyName = "dataConnectorId",
    SegmentName = "dataConnectors",
    NamePattern = ""
  >;

  /**
   * Etag of the azure resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;
}

@armResourceOperations(#{ omitTags: true })
interface DataConnectors {
  /**
   * Gets a data connector.
   */
  @tag("Data Connectors")
  get is Extension.Read<OperationalInsights, DataConnector, Error = CloudError>;

  /**
   * Creates or updates the data connector.
   */
  @tag("Data Connectors")
  createOrUpdate is Extension.CreateOrReplaceSync<
    OperationalInsights,
    DataConnector,
    Error = CloudError
  >;

  /**
   * Delete the data connector.
   */
  @tag("Data Connectors")
  delete is Extension.DeleteSync<
    OperationalInsights,
    DataConnector,
    Error = CloudError
  >;

  /**
   * Gets all data connectors.
   */
  @tag("Data Connectors")
  list is Extension.ListByTarget<
    OperationalInsights,
    DataConnector,
    Response = ArmResponse<DataConnectorList>,
    Error = CloudError
  >;

  /**
   * Connects a data connector.
   */
  @tag("Data Connectors Connect")
  connect is Extension.ActionSync<
    OperationalInsights,
    DataConnector,
    DataConnectorConnectBody,
    OkResponse,
    Error = CloudError
  >;

  /**
   * Disconnect a data connector.
   */
  @tag("Data Connectors Disconnect")
  disconnect is Extension.ActionSync<
    OperationalInsights,
    DataConnector,
    void,
    OkResponse,
    Error = CloudError
  >;
}

@@doc(DataConnector.name, "Connector ID");
@@doc(DataConnectors.createOrUpdate::parameters.resource, "The data connector");
