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

namespace KustoPools;
/**
 * Class representing a data connection.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Brownfield conversion: the published API defines DataConnection as a polymorphic base with no properties bag, which the standard ProxyResource<T> template cannot express."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "customAzureResource marks this hand-shaped polymorphic base as an Azure resource so it keeps the published OpenAPI shape."
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Applies the same payload metadata handling that ProxyResource<T> applies, so the read-only name key stays out of request bodies and routes."
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Inheritance from the common ProxyResource is required so the published allOf reference to common-types ProxyResource is preserved."
@discriminator("kind")
@Azure.ResourceManager.Legacy.customAzureResource(#{ isAzureResource: true })
@Http.Private.includeInapplicableMetadataInPayload(false)
model DataConnection extends Azure.ResourceManager.Foundations.ProxyResource {
  @visibility(Lifecycle.Read)
  @path
  @key("dataConnectionName")
  @segment("dataConnections")
  name: string;

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

alias DataConnectionOps = Azure.ResourceManager.Legacy.LegacyOperations<
  DatabaseParentParameters,
  {
    /** The name of the data connection. */
    @segment("dataConnections")
    @key
    @path
    dataConnectionName: string;
  }
>;

@armResourceOperations
interface DataConnections {
  /**
   * Returns a data connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("KustoPoolDataConnections_Get")
  get is DataConnectionOps.Read<DataConnection>;

  /**
   * Creates or updates a data connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("KustoPoolDataConnections_CreateOrUpdate")
  createOrUpdate is DataConnectionOps.CreateOrUpdateAsync<
    DataConnection,
    LroHeaders = ArmLroLocationHeader<FinalResult = DataConnection> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates a data connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("KustoPoolDataConnections_Update")
  @patch(#{ implicitOptionality: false })
  update is DataConnectionOps.CustomPatchAsync<
    DataConnection,
    PatchModel = DataConnection,
    Response =
      | ArmResponse<DataConnection>
      | (ArmAcceptedLroResponse<
          "Resource operation accepted.",
          ArmLroLocationHeader<FinalResult = DataConnection> &
            Azure.Core.Foundations.RetryAfterHeader
        > & {
          @bodyRoot
          _: DataConnection;
        })
  >;

  /**
   * Deletes the data connection with the given name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("KustoPoolDataConnections_Delete")
  delete is DataConnectionOps.DeleteWithoutOkAsync<
    DataConnection,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
  >;

  /**
   * Returns the list of data connections of the given Kusto pool database.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("KustoPoolDataConnections_ListByDatabase")
  listByDatabase is DataConnectionOps.List<
    DataConnection,
    Response = ArmResponse<DataConnectionListResult>
  >;
}

@@doc(DataConnection.name, "The name of the data connection.");
@@doc(
  DataConnections.createOrUpdate::parameters.resource,
  "The data connection parameters supplied to the CreateOrUpdate operation."
);
@@doc(
  DataConnections.update::parameters.properties,
  "The data connection parameters supplied to the Update operation."
);
