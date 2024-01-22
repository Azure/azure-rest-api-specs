import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.CognitiveServices;

interface DeletedAccountsOperations {
  /**
   * Returns a Cognitive Services account specified by the parameters.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.CognitiveServices/locations/{location}/resourceGroups/{resourceGroupName}/deletedAccounts/{accountName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Resource location.
       */
      @path
      location: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of Cognitive Services account.
       */
      @maxLength(64)
      @minLength(2)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
      @path
      accountName: string;

      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;
    },
    Account
  >;

  /**
   * Deletes a Cognitive Services account from the resource group.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.CognitiveServices/locations/{location}/resourceGroups/{resourceGroupName}/deletedAccounts/{accountName}")
  @delete
  purge is Azure.Core.Foundations.Operation<
    {
      /**
       * Resource location.
       */
      @path
      location: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of Cognitive Services account.
       */
      @maxLength(64)
      @minLength(2)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
      @path
      accountName: string;

      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Returns all the resources of a particular type belonging to a subscription.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.CognitiveServices/deletedAccounts")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;
    },
    ResourceListResult<Account>
  >;
}

interface ResourceSkusOperations {
  /**
   * Gets the list of Microsoft.CognitiveServices SKUs available for your Subscription.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.CognitiveServices/skus")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;
    },
    ResourceSkuListResult
  >;
}

interface UsagesOperations {
  /**
   * Get usages for the requested subscription
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.CognitiveServices/locations/{location}/usages")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * Resource location.
       */
      @path
      location: string;

      /**
       * An OData filter expression that describes a subset of usages to return. The supported parameter is name.value (name of the metric, can have an or of multiple names).
       */
      @query("$filter")
      $filter?: string;
    },
    UsageListResult
  >;
}

/**
 * Check available SKUs.
 */
@route("/subscriptions/{subscriptionId}/providers/Microsoft.CognitiveServices/locations/{location}/checkSkuAvailability")
@post
op checkSkuAvailability is Azure.Core.Foundations.Operation<
  {
    /**
     * The ID of the target subscription.
     */
    @minLength(1)
    @path
    subscriptionId: string;

    /**
     * Resource location.
     */
    @path
    location: string;

    /**
     * Check SKU Availability POST body.
     */
    @body
    parameters: CheckSkuAvailabilityParameter;
  },
  SkuAvailabilityListResult
>;

/**
 * Check whether a domain is available.
 */
@route("/subscriptions/{subscriptionId}/providers/Microsoft.CognitiveServices/checkDomainAvailability")
@post
op checkDomainAvailability is Azure.Core.Foundations.Operation<
  {
    /**
     * The ID of the target subscription.
     */
    @minLength(1)
    @path
    subscriptionId: string;

    /**
     * Check Domain Availability parameter.
     */
    @body
    parameters: CheckDomainAvailabilityParameter;
  },
  DomainAvailability
>;

interface CommitmentTiersOperations {
  /**
   * List Commitment Tiers.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.CognitiveServices/locations/{location}/commitmentTiers")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * Resource location.
       */
      @path
      location: string;
    },
    CommitmentTierListResult
  >;
}

interface ModelsOperations {
  /**
   * List Models.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.CognitiveServices/locations/{location}/models")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * Resource location.
       */
      @path
      location: string;
    },
    ModelListResult
  >;
}

interface CommitmentPlansOperations {
  /**
   * Create Cognitive Services commitment plan.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/commitmentPlans/{commitmentPlanName}")
  @put
  createOrUpdatePlan is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the commitmentPlan associated with the Cognitive Services Account
       */
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
      @path
      commitmentPlanName: string;

      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The parameters to provide for the created commitment plan.
       */
      @body
      commitmentPlan: CommitmentPlan;
    },
    CommitmentPlan
  >;

  /**
   * Create Cognitive Services commitment plan.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/commitmentPlans/{commitmentPlanName}")
  @patch
  updatePlan is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the commitmentPlan associated with the Cognitive Services Account
       */
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
      @path
      commitmentPlanName: string;

      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The parameters to provide for the created commitment plan.
       */
      @body
      commitmentPlan: PatchResourceTagsAndSku;
    },
    CommitmentPlan | void
  >;

  /**
   * Deletes a Cognitive Services commitment plan from the resource group.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/commitmentPlans/{commitmentPlanName}")
  @delete
  deletePlan is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the commitmentPlan associated with the Cognitive Services Account
       */
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
      @path
      commitmentPlanName: string;

      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Returns a Cognitive Services commitment plan specified by the parameters.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/commitmentPlans/{commitmentPlanName}")
  @get
  getPlan is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the commitmentPlan associated with the Cognitive Services Account
       */
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
      @path
      commitmentPlanName: string;

      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;
    },
    CommitmentPlan
  >;

  /**
   * Returns all the resources of a particular type belonging to a resource group
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/commitmentPlans")
  @get
  listPlansByResourceGroup is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;
    },
    ResourceListResult<CommitmentPlan>
  >;

  /**
   * Returns all the resources of a particular type belonging to a subscription.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.CognitiveServices/commitmentPlans")
  @get
  listPlansBySubscription is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;
    },
    ResourceListResult<CommitmentPlan>
  >;
}
