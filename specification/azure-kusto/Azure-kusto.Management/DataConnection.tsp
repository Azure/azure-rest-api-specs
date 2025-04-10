import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Kusto;
// FIXME: DataConnection has no properties property
/**
 * Class representing an data connection.
 */
@parentResource(Database)
model DataConnection is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = DataConnection,
    KeyName = "dataConnectionName",
    SegmentName = "dataConnections",
    NamePattern = "^.*$"
  >;

  /**
   * Resource location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  location?: string;

  /**
   * Kind of the endpoint for the data connection
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind: DataConnectionKind;
}

@armResourceOperations
interface DataConnections {
  /**
   * Returns a data connection.
   */
  get is ArmResourceRead<DataConnection>;

  /**
   * Creates or updates a data connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DataConnection,
    Response = ArmResourceUpdatedResponse<DataConnection> | ArmResourceCreatedResponse<
      DataConnection,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: DataConnection;
    })
  >;

  /**
   * Updates a data connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    DataConnection,
    PatchModel = DataConnection,
    Response = ArmResponse<DataConnection> | ArmResourceCreatedResponse<DataConnection> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: DataConnection;
    })
  >;

  /**
   * Deletes the data connection with the given name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    DataConnection,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Returns the list of data connections of the given Kusto database.
   */
  listByDatabase is ArmResourceListByParent<
    DataConnection,
    Response = ArmResponse<DataConnectionListResult>
  >;
}

@@doc(DataConnection.name, "The name of the data connection.");
@@doc(DataConnections.createOrUpdate::parameters.resource,
  "The data connection parameters supplied to the CreateOrUpdate operation."
);
@@doc(DataConnections.update::parameters.properties,
  "The data connection parameters supplied to the Update operation."
);
