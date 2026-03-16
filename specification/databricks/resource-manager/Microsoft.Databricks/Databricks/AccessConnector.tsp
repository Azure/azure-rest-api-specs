import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Databricks;
/**
 * Information about Azure Databricks Access Connector.
 */
model AccessConnector
  is Azure.ResourceManager.TrackedResource<AccessConnectorProperties> {
  ...ResourceNameParameter<
    Resource = AccessConnector,
    KeyName = "connectorName",
    SegmentName = "accessConnectors",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@armResourceOperations
interface AccessConnectors {
  /**
   * Gets an Azure Databricks Access Connector.
   */
  get is ArmResourceRead<AccessConnector>;

  /**
   * Creates or updates Azure Databricks Access Connector.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AccessConnector,
    LroHeaders = ArmLroLocationHeader<FinalResult = AccessConnector> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates an Azure Databricks Access Connector.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    AccessConnector,
    PatchModel = AccessConnectorUpdate
  >;

  /**
   * Deletes the Azure Databricks Access Connector.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    AccessConnector,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all the Azure Databricks Access Connectors within a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<AccessConnector>;

  /**
   * Gets all the Azure Databricks Access Connectors within a subscription.
   */
  listBySubscription is ArmListBySubscription<AccessConnector>;
}

@@maxLength(AccessConnector.name, 64);
@@minLength(AccessConnector.name, 3);
@@doc(AccessConnector.name,
  "The name of the Azure Databricks Access Connector."
);
@@doc(AccessConnector.properties,
  "Azure Databricks Access Connector properties"
);
@@doc(AccessConnectors.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update an Azure Databricks Access Connector."
);
@@doc(AccessConnectors.update::parameters.properties,
  "The update to the Azure Databricks Access Connector."
);
