import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./ProviderRegistration.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ProviderHub;

@singleton("default")
@parentResource(ProviderRegistration)
model OperationsPutContent
  is Azure.ResourceManager.ProxyResource<OperationsPutContentProperties> {
  ...ResourceNameParameter<
    Resource = OperationsPutContent,
    KeyName = "operation",
    SegmentName = "operations",
    NamePattern = ""
  >;
}

@armResourceOperations
interface OperationsPutContents {
  /**
   * Gets the operations supported by the given provider.
   */
  @returnTypeChangedFrom(
    Versions.v2025_10_01,
    ArmResponse<OperationsDefinition[]> | ErrorResponse
  )
  listByProviderRegistration is ArmResourceRead<OperationsPutContent>;

  /**
   * Creates or updates the operation supported by the given provider.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    OperationsPutContent,
    Response = ArmResourceUpdatedResponse<OperationsPutContent>
  >;

  /**
   * Deletes an operation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "The service only ever returns 204 for this operation, including when the operations content does not exist. Declaring a 200 would not match the implementation."
  @returnTypeChangedFrom(
    Versions.v2025_10_01,
    ArmDeletedResponse | ArmDeletedNoContentResponse | ErrorResponse
  )
  delete is ArmResourceDeleteSync<
    OperationsPutContent,
    Response = ArmDeletedNoContentResponse
  >;
}

@@doc(OperationsPutContent.name, "");
@@doc(OperationsPutContent.properties, "");
@@doc(
  OperationsPutContents.createOrUpdate::parameters.resource,
  "The operations content properties supplied to the CreateOrUpdate operation."
);
