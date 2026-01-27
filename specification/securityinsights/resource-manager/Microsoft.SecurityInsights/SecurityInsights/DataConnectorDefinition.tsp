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
 * An Azure resource, which encapsulate the entire info requires to display a data connector page in Azure portal,
 * and the info required to define data connections.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@discriminator("kind")
model DataConnectorDefinition
  is Azure.ResourceManager.Legacy.DiscriminatedExtensionResource<DataConnectorDefinitionKind> {
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
}

@armResourceOperations
interface DataConnectorDefinitions {
  /**
   * Gets a data connector definition.
   */
  get is Extension.Read<
    OperationalInsights,
    DataConnectorDefinition,
    Error = CloudError
  >;

  /**
   * Creates or updates the data connector definition.
   */
  createOrUpdate is Extension.CreateOrReplaceSync<
    OperationalInsights,
    DataConnectorDefinition,
    Error = CloudError
  >;

  /**
   * Delete the data connector definition.
   */
  delete is Extension.DeleteSync<
    OperationalInsights,
    DataConnectorDefinition,
    Error = CloudError
  >;

  /**
   * Gets all data connector definitions.
   */
  list is Extension.ListByTarget<
    OperationalInsights,
    DataConnectorDefinition,
    Response = ArmResponse<DataConnectorDefinitionArmCollectionWrapper>,
    Error = CloudError
  >;
}

@@doc(DataConnectorDefinition.name, "The data connector definition name.");
@@doc(DataConnectorDefinitions.createOrUpdate::parameters.resource,
  "The data connector definition"
);
