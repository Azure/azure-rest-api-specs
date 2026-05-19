import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
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
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("$top")
      @minValue(0)
      Top?: int32;

      /**
       * OData filter expression.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  getAtResourceGroup is AttestationResourceGroupOps.Read<
    Attestation,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Creates or updates an attestation at resource group scope.
   */
  createOrUpdateAtResourceGroup is AttestationResourceGroupOps.CreateOrUpdateAsync<
    Attestation,
    LroHeaders = ArmLroLocationHeader<FinalResult = Attestation> &
      Azure.Core.Foundations.RetryAfterHeader,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Deletes an existing attestation at resource group scope.
   */
  deleteAtResourceGroup is AttestationResourceGroupOps.DeleteSync<
    Attestation,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Gets all attestations for the resource group.
   */
  listForResourceGroup is AttestationResourceGroupOps.List<
    Attestation,
    Response = ArmResponse<AttestationListResult>,
    Parameters = {
      /**
       * Maximum number of records to return.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("$top")
      @minValue(0)
      Top?: int32;

      /**
       * OData filter expression.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("$filter")
      Filter?: string;
    },
    OverrideErrorType = ErrorResponse
  >;
}

alias AttestationAtResourceOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;

    /** Resource ID. */
    @path(#{ allowReserved: true })
    @key
    resourceId: string;

    ...Azure.ResourceManager.Legacy.Provider;
  },
  {
    /** The name of the attestation. */
    @path
    @segment("attestations")
    @key
    attestationName: string;
  },
  ErrorType = ErrorResponse
>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface AttestationOperationGroup {
  /**
   * Gets an existing attestation at resource scope.
   */
  getAtResource is AttestationAtResourceOps.Read<
    Attestation,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Creates or updates an attestation at resource scope.
   */
  createOrUpdateAtResource is AttestationAtResourceOps.CreateOrUpdateAsync<
    Attestation,
    Response =
      | ArmResponse<Attestation>
      | ArmResourceCreatedResponse<
          Attestation,
          ArmLroLocationHeader<FinalResult = Attestation> &
            Azure.Core.Foundations.RetryAfterHeader
        >
  >;

  /**
   * Deletes an existing attestation at individual resource scope.
   */
  deleteAtResource is AttestationAtResourceOps.DeleteSync<
    Attestation,
    Response =
      | {
          @statusCode statusCode: 200;
        }
      | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all attestations for a resource.
   */
  listForResource is AttestationAtResourceOps.List<
    Attestation,
    Parameters = {
      /**
       * Maximum number of records to return.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("$top")
      @minValue(0)
      Top?: int32;

      /**
       * OData filter expression.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("$filter")
      Filter?: string;
    },
    Response = ArmResponse<AttestationListResult>
  >;
}

@@doc(Attestation.name, "The name of the attestation.");
@@doc(Attestation.properties, "Properties for the attestation.");
@@doc(
  Attestations.createOrUpdateAtSubscription::parameters.resource,
  "The attestation parameters."
);
@@doc(
  AttestationResourceGroupOperations.createOrUpdateAtResourceGroup::parameters.resource,
  "The attestation parameters."
);
@@doc(
  AttestationOperationGroup.createOrUpdateAtResource::parameters.resource,
  "The attestation parameters."
);
