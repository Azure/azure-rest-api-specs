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
 * Data connector.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
model DataConnector
  is Azure.ResourceManager.Legacy.DiscriminatedExtensionResource<DataConnectorKind> {
  ...ResourceNameParameter<
    Resource = DataConnector,
    KeyName = "dataConnectorId",
    SegmentName = "dataConnectors",
    NamePattern = ""
  >;

  /**
   * Etag of the azure resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
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
    Response = ArmResponse<DataConnectorList>,
    Error = CloudError
  >;
}

@@doc(DataConnector.name, "Connector ID");
@@doc(DataConnectors.createOrUpdate::parameters.resource, "The data connector");
