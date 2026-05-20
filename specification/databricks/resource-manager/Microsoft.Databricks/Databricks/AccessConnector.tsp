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

@armResourceOperations(#{ omitTags: true })
interface AccessConnectors {
  /**
   * Gets an Azure Databricks Access Connector.
   */
  @tag("AccessConnector")
  get is ArmResourceRead<AccessConnector, Error = ErrorResponse>;

  /**
   * Creates or updates Azure Databricks Access Connector.
   */
  @tag("AccessConnector")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AccessConnector,
    LroHeaders = ArmLroLocationHeader<FinalResult = AccessConnector> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = ErrorResponse
  >;

  /**
   * Updates an Azure Databricks Access Connector.
   */
  @tag("AccessConnector")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    AccessConnector,
    PatchModel = AccessConnectorUpdate,
    Error = ErrorResponse
  >;

  /**
   * Deletes the Azure Databricks Access Connector.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @tag("AccessConnector")
  delete is ArmResourceDeleteWithoutOkAsync<
    AccessConnector,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = ErrorResponse
  >;

  /**
   * Gets all the Azure Databricks Access Connectors within a resource group.
   */
  @tag("AccessConnector")
  listByResourceGroup is ArmResourceListByParent<
    AccessConnector,
    Error = ErrorResponse
  >;

  /**
   * Gets all the Azure Databricks Access Connectors within a subscription.
   */
  @tag("AccessConnector")
  listBySubscription is ArmListBySubscription<
    AccessConnector,
    Error = ErrorResponse
  >;
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
