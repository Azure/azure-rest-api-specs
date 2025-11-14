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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: Sku;

  /**
   * Properties of BYOK Identity description
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: Identity;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface EHNamespaces {
  /**
   * Gets the description of the specified namespace.
   */
  get is ArmResourceRead<EHNamespace, Error = ErrorResponse>;

  /**
   * Creates or updates a namespace. Once created, this namespace's resource manifest is immutable. This operation is idempotent.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    EHNamespace,
    Response = ArmResourceUpdatedResponse<EHNamespace> | ArmResourceCreatedResponse<
      EHNamespace,
      ArmAsyncOperationHeader<FinalResult = EHNamespace>
    > | ArmAcceptedLroResponse,
    Error = ErrorResponse
  >;

  /**
   * Creates or updates a namespace. Once created, this namespace's resource manifest is immutable. This operation is idempotent.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    EHNamespace,
    PatchModel = EHNamespace,
    Response = ArmResponse<EHNamespace> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = EHNamespace> &
      Azure.Core.Foundations.RetryAfterHeader>,
    Error = ErrorResponse
  >;

  /**
   * Deletes an existing namespace. This operation also removes all associated resources under the namespace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    EHNamespace,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse,
    Error = ErrorResponse
  >;

  /**
   * Lists the available Namespaces within a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    EHNamespace,
    Error = ErrorResponse
  >;

  /**
   * Lists all the available Namespaces within a subscription, irrespective of the resource groups.
   */
  list is ArmListBySubscription<EHNamespace, Error = ErrorResponse>;

  /**
   * GeoDR Failover
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  failover is ArmResourceActionAsyncBase<
    EHNamespace,
    FailOver,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = FailOver> &
      Azure.Core.Foundations.RetryAfterHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<EHNamespace>,
    Error = ErrorResponse
  >;

  /**
   * Gets lists of resources that supports Privatelinks.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @action("privateLinkResources")
  @OpenAPI.externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt639379.aspx")
  privateLinkResourcesGet is ArmResourceActionSync<
    EHNamespace,
    void,
    ArmResponse<PrivateLinkResourcesListResult>,
    Error = ErrorResponse
  >;

  /**
   * Check the give Namespace name availability.
   */
  @action("disasterRecoveryConfigs/checkNameAvailability")
  checkNameAvailability is ArmResourceActionSync<
    EHNamespace,
    CheckNameAvailabilityParameter,
    ArmResponse<CheckNameAvailabilityResult>,
    Error = ErrorResponse
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
