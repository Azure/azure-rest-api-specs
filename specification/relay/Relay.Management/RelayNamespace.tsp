import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Relay;
/**
 * Description of a namespace resource.
 */
model RelayNamespace
  is Azure.ResourceManager.TrackedResource<RelayNamespaceProperties> {
  ...RelayNamespaceNameParameter;

  /**
   * SKU of the namespace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: Sku;
}

@@maxLength(RelayNamespaceNameParameter.name, 50);
@@minLength(RelayNamespaceNameParameter.name, 6);
@@doc(RelayNamespaceNameParameter.name, "The namespace name");
model RelayNamespaceNameParameter
  is ResourceNameParameter<
    Resource = RelayNamespace,
    KeyName = "namespaceName",
    SegmentName = "namespaces",
    NamePattern = ""
  >;

@armResourceOperations
interface RelayNamespaces {
  /**
   * Returns the description for the specified namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  get is ArmResourceRead<RelayNamespace>;

  /**
   * Create Azure Relay namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    RelayNamespace,
    LroHeaders = ArmLroLocationHeader<FinalResult = RelayNamespace> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Creates or updates a namespace. Once created, this namespace's resource manifest is immutable. This operation is idempotent.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    RelayNamespace,
    PatchModel = RelayUpdateParameters,
    Response = ArmResponse<RelayNamespace> | ArmResourceCreatedSyncResponse<RelayNamespace>
  >;

  /**
   * Deletes an existing namespace. This operation also removes all associated resources under the namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    RelayNamespace,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all the available namespaces within the ResourceGroup.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  listByResourceGroup is ArmResourceListByParent<RelayNamespace>;

  /**
   * Lists all the available namespaces within the subscription regardless of the resourceGroups.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  list is ArmListBySubscription<RelayNamespace>;
}

@@doc(RelayNamespace.properties, "Description of Relay namespace");
@@doc(RelayNamespaces.createOrUpdate::parameters.resource,
  "Parameters supplied to create a namespace resource."
);
@@doc(RelayNamespaces.update::parameters.properties,
  "Parameters for updating a namespace resource."
);
