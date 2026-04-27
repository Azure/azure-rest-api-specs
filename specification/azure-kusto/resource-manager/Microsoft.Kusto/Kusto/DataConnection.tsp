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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(Database)
@discriminator("kind")
@Azure.ResourceManager.Legacy.customAzureResource(#{ isAzureResource: true })
@Http.Private.includeInapplicableMetadataInPayload(false)
model DataConnection extends Azure.ResourceManager.Foundations.ProxyResource {
  @visibility(Lifecycle.Read)
  @path
  @key("dataConnectionName")
  @segment("dataConnections")
  @pattern("^.*$")
  name: string;

  /**
   * Resource location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;

  /**
   * Kind of the endpoint for the data connection
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DataConnection,
    Response = ArmResourceUpdatedResponse<DataConnection> | (CreatedResponse & {
      @body body: DataConnection;
    }) | (ArmAcceptedLroResponse<
      "Create or update accepted.",
      LroHeaders = ArmLroLocationHeader<FinalResult = DataConnection> &
        ArmAsyncOperationHeader<FinalResult = DataConnection>
    > & {
      @bodyRoot
      _: DataConnection;
    })
  >;

  /**
   * Updates a data connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    DataConnection,
    PatchModel = DataConnection,
    Response = ArmResponse<DataConnection> | ArmResourceCreatedResponse<
      DataConnection,
      LroHeaders = ArmLroLocationHeader<FinalResult = DataConnection> &
        ArmAsyncOperationHeader<FinalResult = DataConnection> &
        Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse<
      "Update accepted.",
      LroHeaders = ArmLroLocationHeader<FinalResult = DataConnection> &
        ArmAsyncOperationHeader<FinalResult = DataConnection> &
        Azure.Core.Foundations.RetryAfterHeader
    > & {
      @bodyRoot
      _: DataConnection;
    })
  >;

  /**
   * Deletes the data connection with the given name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    DataConnection,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader &
      ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
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
