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
#suppress "@azure-tools/typespec-azure-core/casing-style" "The model name preserves the original casing from the OpenAPI specification for backward compatibility."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy behavior required for backward compatibility with the original OpenAPI specification."
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "This property is an existing envelope property from the original OpenAPI specification and cannot be changed without breaking compatibility."
  sku?: Sku;

  /**
   * Properties of BYOK Identity description
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "This property is an existing envelope property from the original OpenAPI specification and cannot be changed without breaking compatibility."
  identity?: Identity;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The model name preserves the original casing from the OpenAPI specification for backward compatibility."
@armResourceOperations
interface EHNamespaces {
  /**
   * Gets the description of the specified namespace.
   */
  get is ArmResourceRead<EHNamespace, Error = ErrorResponse>;

  /**
   * Creates or updates a namespace. Once created, this namespace's resource manifest is immutable. This operation is idempotent.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Existing PUT operation response codes match the original OpenAPI specification. Changing would be a breaking change for existing clients."
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
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "Existing long-running operation does not use the standard location header pattern as defined in the original OpenAPI specification."
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
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "Existing long-running operation does not use the standard location header pattern as defined in the original OpenAPI specification."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Existing DELETE operation response codes match the original OpenAPI specification. Changing would be a breaking change for existing clients."
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "OpenAPI decorator is required to preserve the original API behavior defined in the OpenAPI specification."
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
