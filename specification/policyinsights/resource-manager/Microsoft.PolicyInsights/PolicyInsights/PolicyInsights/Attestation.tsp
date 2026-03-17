import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace PolicyInsightsApi;
/**
 * An attestation resource.
 */
@subscriptionResource
model Attestation
  is Azure.ResourceManager.ProxyResource<AttestationProperties, false> {
  ...ResourceNameParameter<
    Resource = Attestation,
    KeyName = "attestationName",
    SegmentName = "attestations",
    NamePattern = ""
  >;
}

alias AttestationSubscriptionOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.PolicyInsights";
  },
  {},
  {
    /** The name of the attestation. */
    @path
    @segment("attestations")
    @key
    attestationName: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface Attestations {
  /**
   * Gets an existing attestation at subscription scope.
   */
  getAtSubscription is AttestationSubscriptionOps.Read<
    Attestation,
    ErrorType = ErrorResponse
  >;

  /**
   * Creates or updates an attestation at subscription scope.
   */
  createOrUpdateAtSubscription is AttestationSubscriptionOps.CreateOrUpdateAsync<
    Attestation,
    LroHeaders = ArmLroLocationHeader<FinalResult = Attestation> &
      Azure.Core.Foundations.RetryAfterHeader,
    ErrorType = ErrorResponse
  >;

  /**
   * Deletes an existing attestation at subscription scope.
   */
  deleteAtSubscription is AttestationSubscriptionOps.DeleteSync<
    Attestation,
    ErrorType = ErrorResponse
  >;

  /**
   * Gets all attestations for the subscription.
   */
  listForSubscription is AttestationSubscriptionOps.List<
    Attestation,
    Response = ArmResponse<AttestationListResult>,
    Parameters = {
      /**
       * Maximum number of records to return.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$top")
      @minValue(0)
      Top?: int32;

      /**
       * OData filter expression.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$filter")
      Filter?: string;
    },
    ErrorType = ErrorResponse
  >;
}
alias AttestationResourceGroupOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;
  },
  {
    /** The name of the attestation. */
    @path
    @segment("attestations")
    @key
    attestationName: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface AttestationResourceGroupOperations {
  /**
   * Gets an existing attestation at resource group scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Attestations_GetAtResourceGroup")
  getAtResourceGroup is AttestationResourceGroupOps.Read<
    Attestation,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Creates or updates an attestation at resource group scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Attestations_CreateOrUpdateAtResourceGroup")
  createOrUpdateAtResourceGroup is AttestationResourceGroupOps.CreateOrUpdateAsync<
    Attestation,
    LroHeaders = ArmLroLocationHeader<FinalResult = Attestation> &
      Azure.Core.Foundations.RetryAfterHeader,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Deletes an existing attestation at resource group scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Attestations_DeleteAtResourceGroup")
  deleteAtResourceGroup is AttestationResourceGroupOps.DeleteSync<
    Attestation,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Gets all attestations for the resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Attestations_ListForResourceGroup")
  listForResourceGroup is AttestationResourceGroupOps.List<
    Attestation,
    Response = ArmResponse<AttestationListResult>,
    Parameters = {
      /**
       * Maximum number of records to return.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$top")
      @minValue(0)
      Top?: int32;

      /**
       * OData filter expression.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$filter")
      Filter?: string;
    },
    OverrideErrorType = ErrorResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface AttestationOperationGroup {
  /**
   * Gets an existing attestation at resource scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Attestations_GetAtResource")
  @route("/{+resourceId}/providers/Microsoft.PolicyInsights/attestations/{attestationName}")
  @get
  getAtResource(
    ...ApiVersionParameter,

    /**
     * Resource ID.
     */
    @path
    resourceId: string,

    /**
     * The name of the attestation.
     */
    @path
    attestationName: string,
  ): ArmResponse<Attestation> | ErrorResponse;

  /**
   * Creates or updates an attestation at resource scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Attestations_CreateOrUpdateAtResource")
  @route("/{+resourceId}/providers/Microsoft.PolicyInsights/attestations/{attestationName}")
  @put
  createOrUpdateAtResource(
    ...ApiVersionParameter,

    /**
     * Resource ID.
     */
    @path
    resourceId: string,

    /**
     * The name of the attestation.
     */
    @path
    attestationName: string,

    /**
     * The attestation parameters.
     */
    @bodyRoot
    resource: Attestation,
  ): ArmResponse<Attestation> | ArmResourceCreatedResponse<
    Attestation,
    ArmLroLocationHeader<FinalResult = Attestation> &
      Azure.Core.Foundations.RetryAfterHeader
  > | ErrorResponse;

  /**
   * Deletes an existing attestation at individual resource scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Attestations_DeleteAtResource")
  @route("/{+resourceId}/providers/Microsoft.PolicyInsights/attestations/{attestationName}")
  @delete
  deleteAtResource(
    ...ApiVersionParameter,

    /**
     * Resource ID.
     */
    @path
    resourceId: string,

    /**
     * The name of the attestation.
     */
    @path
    attestationName: string,
  ): {
    @statusCode statusCode: 200;
  } | ArmDeletedNoContentResponse | ErrorResponse;

  /**
   * Gets all attestations for a resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Attestations_ListForResource")
  @route("/{+resourceId}/providers/Microsoft.PolicyInsights/attestations")
  @list
  @get
  listForResource(
    ...ApiVersionParameter,

    /**
     * Resource ID.
     */
    @path
    resourceId: string,

    /**
     * Maximum number of records to return.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$top")
    @minValue(0)
    Top?: int32,

    /**
     * OData filter expression.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$filter")
    Filter?: string,
  ): ArmResponse<AttestationListResult> | ErrorResponse;
}

@@doc(Attestation.name, "The name of the attestation.");
@@doc(Attestation.properties, "Properties for the attestation.");
@@doc(Attestations.createOrUpdateAtSubscription::parameters.resource,
  "The attestation parameters."
);
@@doc(AttestationResourceGroupOperations.createOrUpdateAtResourceGroup::parameters.resource,
  "The attestation parameters."
);
@@doc(AttestationOperationGroup.createOrUpdateAtResource::parameters.resource,
  "The attestation parameters."
);
