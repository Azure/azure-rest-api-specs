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
   * Etag of the azure resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;

  /**
   * The data connector kind
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind: DataConnectorKind;
}

alias DataConnectorWorkspaceExternalResource = Extension.ExternalResource<
  "Microsoft.OperationalInsights",
  "workspaces",
  "{workspaceName}"
>;

@armResourceOperations
interface DataConnectors {
  /**
   * Gets a data connector.
   */
  get is ArmResourceRead<DataConnector>;

  /**
   * Creates or updates the data connector.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<DataConnector>;

  /**
   * Delete the data connector.
   */
  delete is ArmResourceDeleteSync<DataConnector>;

  /**
   * Gets all data connectors.
   */
  list is ArmResourceListByParent<
    DataConnector,
    Response = ArmResponse<DataConnectorList>
  >;
}

@@doc(DataConnector.name, "Connector ID");
@@doc(DataConnectors.createOrUpdate::parameters.resource, "The data connector");
