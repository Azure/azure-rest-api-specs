import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.EventHub;
/**
 * Single Namespace item in List or Get Operation
 */
model EHNamespace
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<EHNamespaceProperties> {
  ...ResourceNameParameter<
    Resource = EHNamespace,
    KeyName = "namespaceName",
    SegmentName = "namespaces",
    NamePattern = "^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$"
  >;

  /**
   * Properties of sku resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: Sku;

  /**
   * Properties of BYOK Identity description
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: Identity;
}

@armResourceOperations
interface EHNamespaces {
  /**
   * Gets the description of the specified namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Namespaces_Get")
  get is ArmResourceRead<EHNamespace>;

  /**
   * Creates or updates a namespace. Once created, this namespace's resource manifest is immutable. This operation is idempotent.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("Namespaces_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    EHNamespace,
    Response = ArmResourceUpdatedResponse<EHNamespace> | ArmResourceCreatedResponse<EHNamespace> | ArmAcceptedLroResponse
  >;

  /**
   * Creates or updates a namespace. Once created, this namespace's resource manifest is immutable. This operation is idempotent.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Namespaces_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    EHNamespace,
    PatchModel = EHNamespace,
    Response = ArmResponse<EHNamespace> | ArmResourceCreatedSyncResponse<EHNamespace> | AcceptedResponse
  >;

  /**
   * Deletes an existing namespace. This operation also removes all associated resources under the namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("Namespaces_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    EHNamespace,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists the available Namespaces within a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Namespaces_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<EHNamespace>;

  /**
   * Lists all the available Namespaces within a subscription, irrespective of the resource groups.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Namespaces_List")
  list is ArmListBySubscription<EHNamespace>;

  /**
   * GeoDR Failover
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Namespaces_Failover")
  failover is ArmResourceActionAsync<
    EHNamespace,
    FailOver,
    ArmResponse<FailOver>,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = FailOver> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Gets lists of resources that supports Privatelinks.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateLinkResources_Get")
  @list
  @get
  @action("privateLinkResources")
  privateLinkResourcesGet is ArmResourceActionSync<
    EHNamespace,
    void,
    ArmResponse<ResourceListResult<PrivateLinkResource>>
  >;

  /**
   * Check the give Namespace name availability.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DisasterRecoveryConfigs_CheckNameAvailability")
  @action("disasterRecoveryConfigs/checkNameAvailability")
  checkNameAvailability is ArmResourceActionSync<
    EHNamespace,
    CheckNameAvailabilityParameter,
    ArmResponse<CheckNameAvailabilityResult>
  >;
}

@@maxLength(EHNamespace.name, 50);
@@minLength(EHNamespace.name, 6);
@@doc(EHNamespace.name, "The Namespace name");
@@doc(EHNamespace.properties,
  "Namespace properties supplied for create namespace operation."
);
@@doc(EHNamespaces.createOrUpdate::parameters.resource,
  "Parameters for creating a namespace resource."
);
@@doc(EHNamespaces.update::parameters.properties,
  "Parameters for updating a namespace resource."
);
@@doc(EHNamespaces.failover::parameters.body,
  "Parameters for updating a namespace resource."
);
@@doc(EHNamespaces.checkNameAvailability::parameters.body,
  "Parameters to check availability of the given Alias name"
);
