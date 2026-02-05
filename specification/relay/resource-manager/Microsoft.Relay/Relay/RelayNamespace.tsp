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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  get is ArmResourceRead<RelayNamespace>;

  /**
   * Create Azure Relay namespace.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    RelayNamespace,
    Response = ArmResourceUpdatedResponse<RelayNamespace> | ArmResourceCreatedResponse<
      RelayNamespace,
      ArmLroLocationHeader<FinalResult = RelayNamespace> &
        Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Creates or updates a namespace. Once created, this namespace's resource manifest is immutable. This operation is idempotent.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    RelayNamespace,
    PatchModel = RelayUpdateParameters,
    Response = ArmResponse<RelayNamespace> | ArmResourceCreatedSyncResponse<RelayNamespace>
  >;

  /**
   * Deletes an existing namespace. This operation also removes all associated resources under the namespace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    RelayNamespace,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all the available namespaces within the ResourceGroup.
   */
  listByResourceGroup is ArmResourceListByParent<RelayNamespace>;

  /**
   * Lists all the available namespaces within the subscription regardless of the resourceGroups.
   */
  list is ArmListBySubscription<RelayNamespace>;
}

@@doc(RelayNamespace.properties, "Description of Relay namespace");
@@doc(RelayNamespaces.createOrUpdate::parameters.resource,
  "Parameters supplied to create a namespace resource."
);
@@doc(RelayNamespaces.update::parameters.properties,
  "Parameters for updating a namespace resource."
);
