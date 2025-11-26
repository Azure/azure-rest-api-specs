import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceBus;
/**
 * Description of a namespace resource.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SBNamespace
  is Azure.ResourceManager.TrackedResource<SBNamespaceProperties> {
  ...ResourceNameParameter<
    Resource = SBNamespace,
    KeyName = "namespaceName",
    SegmentName = "namespaces",
    NamePattern = ""
  >;

  /**
   * Properties of SKU
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: SBSku;

  /**
   * Properties of BYOK Identity description
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: Identity;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface SBNamespaces {
  /**
   * Gets a description for the specified namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt639379.aspx")
  get is ArmResourceRead<SBNamespace, Error = ErrorResponse>;

  /**
   * Creates or updates a service namespace. Once created, this namespace's resource manifest is immutable. This operation is idempotent.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt639408.aspx")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    SBNamespace,
    Response = ArmResourceUpdatedResponse<SBNamespace> | ArmResourceCreatedResponse<
      SBNamespace,
      LroHeaders = ArmLroLocationHeader<FinalResult = SBNamespace>
    > | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = SBNamespace>>,
    Error = ErrorResponse
  >;

  /**
   * Updates a service namespace. Once created, this namespace's resource manifest is immutable. This operation is idempotent.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    SBNamespace,
    PatchModel = SBNamespaceUpdateParameters,
    Response = ArmResponse<SBNamespace> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = SBNamespace> &
      Azure.Core.Foundations.RetryAfterHeader>,
    Error = ErrorResponse
  >;

  /**
   * Deletes an existing namespace. This operation also removes all associated resources under the namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt639389.aspx")
  delete is ArmResourceDeleteWithoutOkAsync<
    SBNamespace,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader> | ArmDeletedNoContentResponse,
    Error = ErrorResponse
  >;

  /**
   * Gets the available namespaces within a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt639412.aspx")
  listByResourceGroup is ArmResourceListByParent<
    SBNamespace,
    Error = ErrorResponse
  >;

  /**
   * Gets all the available namespaces within the subscription, irrespective of the resource groups.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt639412.aspx")
  list is ArmListBySubscription<SBNamespace, Error = ErrorResponse>;

  /**
   * GeoDR Failover
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  failover is ArmResourceActionAsyncBase<
    SBNamespace,
    FailOver,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = FailOver> &
      Azure.Core.Foundations.RetryAfterHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<SBNamespace>,
    Error = ErrorResponse
  >;

  /**
   * Gets lists of resources that supports Privatelinks.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @action("privateLinkResources")
  @externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt639379.aspx")
  privateLinkResourcesGet is ArmResourceActionSync<
    SBNamespace,
    void,
    ArmResponse<PrivateLinkResourcesListResult>,
    Error = ErrorResponse
  >;

  /**
   * Check the give namespace name availability.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("disasterRecoveryConfigs/CheckNameAvailability")
  checkNameAvailability is ArmResourceActionSync<
    SBNamespace,
    CheckNameAvailability,
    ArmResponse<CheckNameAvailabilityResult>,
    Error = ErrorResponse
  >;
}

@@maxLength(SBNamespace.name, 50);
@@minLength(SBNamespace.name, 6);
@@doc(SBNamespace.name, "The namespace name");
@@doc(SBNamespace.properties, "Properties of the namespace.");
@@doc(SBNamespaces.createOrUpdate::parameters.resource,
  "Parameters supplied to create a namespace resource."
);
@@doc(SBNamespaces.update::parameters.properties,
  "Parameters supplied to update a namespace resource."
);
@@doc(SBNamespaces.failover::parameters.body,
  "Parameters for updating a namespace resource."
);
@@doc(SBNamespaces.checkNameAvailability::parameters.body,
  "Parameters to check availability of the given namespace name"
);
