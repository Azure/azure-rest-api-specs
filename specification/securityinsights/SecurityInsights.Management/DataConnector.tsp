import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityInsights;
// FIXME: DataConnector has no properties property
/**
 * Data connector.
 */
model DataConnector is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = DataConnector,
    KeyName = "dataConnectorId",
    SegmentName = "dataConnectors",
    NamePattern = ""
  >;

  /**
   * The data connector kind
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind: DataConnectorKind;
}

@armResourceOperations
interface DataConnectors {
  /**
   * Gets a data connector.
   */
  get is Extension.Read<OperationalInsights, DataConnector, Error = CloudError>;

  /**
   * Creates or updates the data connector.
   */
  createOrUpdate is Extension.CreateOrReplaceSync<
    OperationalInsights,
    DataConnector,
    Error = CloudError
  >;

  /**
   * Delete the data connector.
   */
  delete is Extension.DeleteSync<
    OperationalInsights,
    DataConnector,
    Error = CloudError
  >;

  /**
   * Gets all data connectors.
   */
  list is Extension.ListByTarget<
    OperationalInsights,
    DataConnector,
    Error = CloudError
  >;
}

@@doc(DataConnector.name, "Connector ID");
@@doc(DataConnectors.createOrUpdate::parameters.resource, "The data connector");
