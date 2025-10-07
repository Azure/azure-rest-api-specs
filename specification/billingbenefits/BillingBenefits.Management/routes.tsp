// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/versioning";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.BillingBenefits;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface SavingsPlanOperationGroup {
  /**
   * List savings plans.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @autoRoute
  @get
  @list
  @action("savingsPlans")
  listAll is ArmProviderActionSync<
    Response = SavingsPlanModelListResult,
    Parameters = {
      /**
       * May be used to filter by reservation properties. The filter supports 'eq', 'or', and 'and'. It does not currently support 'ne', 'gt', 'le', 'ge', or 'not'. Reservation properties include sku/name, properties/{appliedScopeType, archived, displayName, displayProvisioningState, effectiveDateTime, expiryDate, provisioningState, quantity, renew, reservedResourceType, term, userFriendlyAppliedScopeType, userFriendlyRenewState}
       */
      @query("$filter")
      $filter?: string;

      /**
       * May be used to sort order by reservation properties.
       */
      @query("$orderby")
      $orderby?: string;

      /**
       * To indicate whether to refresh the roll up counts of the savings plans group by provisioning states
       */
      @query("refreshSummary")
      refreshSummary?: string;

      /**
       * The number of savings plans to skip from the list before returning results
       */
      @query("$skiptoken")
      $skiptoken?: float32;

      /**
       * The selected provisioning state
       */
      @query("selectedState")
      selectedState?: string;

      /**
       * To number of savings plans to return
       */
      @query("take")
      take?: float32;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface DiscountsOperationGroup {
  /**
   * List discounts that are applicable for a given scope. Currently supported scopes: billing accounts
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @route("/{scope}/providers/Microsoft.BillingBenefits/applicableDiscounts")
  @get
  @list
  scopeList(
    ...ApiVersionParameter,

    /**
     * The scope at which the benefits are listed.
     */
    @path
    scope: string,
  ): ArmResponse<DiscountList> | ErrorResponse;
}

/**
 * Validate savings plan purchase.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@autoRoute
@action("validate")
@removed(Versions.v2025_05_01_preview)
@sharedRoute
@renamedFrom(Versions.v2025_05_01_preview, "validate")
@OpenAPI.extension(
  "x-ms-examples",
  #{
    SavingsPlanValidatePurchase: #{
      $ref: "./examples/SavingsPlanValidatePurchase.json",
    },
  }
)
op validatePurchase is ArmProviderActionSync<
  Request = SavingsPlanPurchaseValidateRequest,
  Response = SavingsPlanValidateResponse
>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@added(Versions.v2025_05_01_preview)
interface BenefitOperationGroup {
  /**
   * Validate any benefit.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @autoRoute
  @OpenAPI.extension(
    "x-ms-examples",
    #{
      SavingsPlanValidatePurchase: #{
        $ref: "./examples/SavingsPlanValidatePurchase.json",
      },
      MaccValidateCreate: #{ $ref: "./examples/MaccValidateCreate.json" },
      MaccValidateCreateContributor: #{
        $ref: "./examples/MaccValidateCreateContributor.json",
      },
      MaccValidateCreateMultiEntity: #{
        $ref: "./examples/MaccValidateCreateMultiEntity.json",
      },
      MaccValidateCreateBackfilledMacc: #{
        $ref: "./examples/MaccValidateCreateBackfilledMacc.json",
      },
      MaccValidateCreateNewMaccWithMilestone: #{
        $ref: "./examples/MaccValidateCreateNewMaccWithMilestone.json",
      },
      MaccValidateCreateMilestonesOnExistingMacc: #{
        $ref: "./examples/MaccValidateCreateMilestonesOnExistingMacc.json",
      },
      MaccValidateUpdate: #{ $ref: "./examples/MaccValidateUpdate.json" },
      MaccValidateUpdateCommitment: #{
        $ref: "./examples/MaccValidateUpdateCommitment.json",
      },
      MaccValidateUpdateEndAt: #{
        $ref: "./examples/MaccValidateUpdateEndAt.json",
      },
      MaccValidateUpdateContributorRule: #{
        $ref: "./examples/MaccValidateUpdateContributorRule.json",
      },
      MaccValidateUpdateDisplayName: #{
        $ref: "./examples/MaccValidateUpdateDisplayName.json",
      },
      MaccValidateUpdateCommitmentEndAtContributorRule: #{
        $ref: "./examples/MaccValidateUpdateCommitmentEndAtContributorRule.json",
      },
      MaccValidateUpdateMilestoneCommitment: #{
        $ref: "./examples/MaccValidateUpdateMilestoneCommitment.json",
      },
      MaccValidateUpdateMilestoneEndDate: #{
        $ref: "./examples/MaccValidateUpdateMilestoneEndDate.json",
      },
      MaccValidateUpdateMaccAndMilestoneCommitment: #{
        $ref: "./examples/MaccValidateUpdateMaccAndMilestoneCommitment.json",
      },
      MaccValidateUpdateMaccAndMilestoneEndDate: #{
        $ref: "./examples/MaccValidateUpdateMaccAndMilestoneEndDate.json",
      },
      MaccValidateUpdateSuppressShortfall: #{
        $ref: "./examples/MaccValidateUpdateSuppressShortfall.json",
      },
      MaccValidateUpdateUnsuppressShortfall: #{
        $ref: "./examples/MaccValidateUpdateUnsuppressShortfall.json",
      },
      MaccValidateUpdateSuppressShortfallOnMilestone: #{
        $ref: "./examples/MaccValidateUpdateSuppressShortfallOnMilestone.json",
      },
      MaccValidateUpdateUnsuppressShortfallOnMilestone: #{
        $ref: "./examples/MaccValidateUpdateUnsuppressShortfallOnMilestone.json",
      },
      MaccValidateUpdateRemoveMilestones: #{
        $ref: "./examples/MaccValidateUpdateRemoveMilestones.json",
      },
      MaccValidateUpdateContributor: #{
        $ref: "./examples/MaccValidateUpdateContributor.json",
      },
      MaccValidateCancel: #{ $ref: "./examples/MaccValidateCancel.json" },
      MaccValidateCancelWithMilestones: #{
        $ref: "./examples/MaccValidateCancelWithMilestones.json",
      },
      MaccValidateWriteOffWithMilestones: #{
        $ref: "./examples/MaccValidateWriteOffWithMilestones.json",
      },
    }
  )
  @action("validate")
  @added(Versions.v2025_05_01_preview)
  @sharedRoute
  validate is ArmProviderActionSync<
    Request = BenefitValidateRequest,
    Response = BenefitValidateResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ContributorsOperationGroup {
  /**
   * List contributors under applicable MACCs for a given billing account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @route("/{scope}/providers/Microsoft.BillingBenefits/applicableMaccs/{systemId}/providers/Microsoft.BillingBenefits/applicableContributors")
  @get
  @list
  @OpenAPI.extension(
    "x-ms-examples",
    #{
      ContributorsListFromApplicableMacc: #{
        $ref: "./examples/ContributorsListFromApplicableMacc.json",
      },
    }
  )
  @OpenAPI.extension("x-ms-pageable", #{ nextLinkName: "nextLink" })
  @added(Versions.v2025_05_01_preview)
  listFromApplicableMacc(
    ...ApiVersionParameter,

    /**
     * The scope at which the benefits are listed.
     */
    @path
    scope: string,

    /**
     * The system identifier of the applicable MACC.
     */
    @path
    systemId: string,
  ): ArmResponse<ApplicableContributorList> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface SellerResourceOperationGroup {
  /**
   * List maccs by billing account
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @autoRoute
  @action("listSellerResources")
  @OpenAPI.extension(
    "x-ms-examples",
    #{
      SellerViewContributors: #{
        $ref: "./examples/MaccSellerViewContributors.json",
      },
      SellerViewContributorsWithMilestones: #{
        $ref: "./examples/MaccSellerViewContributorsWithMilestones.json",
      },
      SellerViewContributorsWithMilestonesAndShortfall: #{
        $ref: "./examples/MaccSellerViewContributorsWithMilestonesAndShortfall.json",
      },
      SellerViewNoContributors: #{
        $ref: "./examples/MaccSellerViewNoContributors.json",
      },
      SellerViewWithMilestonesNoContributors: #{
        $ref: "./examples/MaccSellerViewWithMilestonesNoContributors.json",
      },
    }
  )
  @added(Versions.v2025_05_01_preview)
  list is ArmProviderActionSync<
    Request = SellerResourceListRequest,
    Response = {
      @added(Versions.v2025_05_01_preview)
      @bodyRoot
      _: Macc[];
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface MaccsOperationGroup {
  /**
   * List applicable maccs for the provided scope. Currently supported scopes: BillingAccountResourceId
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @route("/{scope}/providers/Microsoft.BillingBenefits/applicableMaccs")
  @get
  @list
  @OpenAPI.extension(
    "x-ms-examples",
    #{ ApplicableMaccsList: #{ $ref: "./examples/ApplicableMaccsList.json" } }
  )
  @OpenAPI.extension("x-ms-pageable", #{ nextLinkName: "nextLink" })
  @added(Versions.v2025_05_01_preview)
  list(
    ...ApiVersionParameter,

    /**
     * The scope at which the benefits are listed.
     */
    @path
    scope: string,
  ): ArmResponse<ApplicableMaccList> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface CreditsOperationGroup {
  /**
   * List applicable credits for the provided scope. Currently supported scopes: BillingAccountResourceId
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @route("/{scope}/providers/Microsoft.BillingBenefits/applicableCredits")
  @get
  @list
  @OpenAPI.extension(
    "x-ms-examples",
    #{
      CreditSourcesListByCredit: #{
        $ref: "./examples/CreditListApplicableCredits.json",
      },
    }
  )
  @OpenAPI.extension("x-ms-pageable", #{ nextLinkName: "nextLink" })
  @added(Versions.v2025_05_01_preview)
  listApplicable(
    ...ApiVersionParameter,

    /**
     * The scope at which the benefits are listed.
     */
    @path
    scope: string,
  ): ArmResponse<CreditsList> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ConditionalCreditsOperationGroup {
  /**
   * List conditional credits that are applicable for a given scope. Currently supported scopes: billing accounts
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @route("/{scope}/providers/Microsoft.BillingBenefits/applicableConditionalCredits")
  @get
  @list
  @OpenAPI.extension(
    "x-ms-examples",
    #{
      ConditionalCreditScopeList: #{
        $ref: "./examples/ApplicableConditionalCreditList.json",
      },
    }
  )
  @OpenAPI.extension("x-ms-pageable", #{ nextLinkName: "nextLink" })
  @added(Versions.v2025_05_01_preview)
  scopeList(
    ...ApiVersionParameter,

    /**
     * The scope at which the benefits are listed.
     */
    @path
    scope: string,
  ): ArmResponse<ConditionalCreditList> | ErrorResponse;
}
