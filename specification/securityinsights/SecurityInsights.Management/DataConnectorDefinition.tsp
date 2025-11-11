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
// FIXME: DataConnectorDefinition has no properties property
/**
 * An Azure resource, which encapsulate the entire info requires to display a data connector page in Azure portal,
 * and the info required to define data connections.
 */
model DataConnectorDefinition is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = DataConnectorDefinition,
    KeyName = "dataConnectorDefinitionName",
    SegmentName = "dataConnectorDefinitions",
    NamePattern = "^[a-z0-9A-Z-_]*$"
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
  kind: DataConnectorDefinitionKind;
}

alias DataConnectorDefinitionWorkspaceExternalResource = Extension.ExternalResource<
  "Microsoft.OperationalInsights",
  "workspaces",
  "{workspaceName}"
>;

@armResourceOperations
interface DataConnectorDefinitions {
  /**
   * Gets a data connector definition.
   */
  get is ArmResourceRead<DataConnectorDefinition>;

  /**
   * Creates or updates the data connector definition.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<DataConnectorDefinition>;

  /**
   * Delete the data connector definition.
   */
  delete is ArmResourceDeleteSync<DataConnectorDefinition>;

  /**
   * Gets all data connector definitions.
   */
  list is ArmResourceListByParent<
    DataConnectorDefinition,
    Response = ArmResponse<DataConnectorDefinitionArmCollectionWrapper>
  >;
}

@@doc(DataConnectorDefinition.name, "The data connector definition name.");
@@doc(DataConnectorDefinitions.createOrUpdate::parameters.resource,
  "The data connector definition"
);
