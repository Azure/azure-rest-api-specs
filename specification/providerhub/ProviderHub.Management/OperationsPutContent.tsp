import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ProviderRegistration.tsp";

using TypeSpec.Rest;
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
  listByProviderRegistration is ArmResourceRead<
    OperationsPutContent,
    Response = ArmResponse<OperationsDefinition[]>
  >;

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
  delete is ArmResourceDeleteSync<OperationsPutContent>;
}

@@doc(OperationsPutContent.name, "");
@@doc(OperationsPutContent.properties, "");
@@doc(OperationsPutContents.createOrUpdate::parameters.resource,
  "The operations content properties supplied to the CreateOrUpdate operation."
);
