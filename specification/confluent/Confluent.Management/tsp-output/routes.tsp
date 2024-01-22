import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Confluent;

interface MarketplaceAgreementsOperations {
  /**
   * List Confluent marketplace agreements in the subscription.
   */
  @summary("List Confluent marketplace agreements in the subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Confluent/agreements")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * Microsoft Azure subscription id
       */
      @path
      subscriptionId: string;
    },
    ConfluentAgreementResourceListResponse
  >;

  /**
   * Create Confluent Marketplace agreement in the subscription.
   */
  @summary("Create Confluent Marketplace agreement in the subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Confluent/agreements/default")
  @put
  create is Azure.Core.Foundations.Operation<
    {
      /**
       * Microsoft Azure subscription id
       */
      @path
      subscriptionId: string;

      /**
       * Confluent Marketplace Agreement resource
       */
      @body
      body?: ConfluentAgreementResource;
    },
    ConfluentAgreementResource
  >;
}

interface ValidationsOperations {
  /**
   * Organization Validate proxy resource
   */
  @summary("Organization Validate proxy resource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Confluent/validations/{organizationName}/orgvalidate")
  @post
  validateOrganization is Azure.Core.Foundations.Operation<
    {
      /**
       * Microsoft Azure subscription id
       */
      @path
      subscriptionId: string;

      /**
       * Resource group name
       */
      @path
      resourceGroupName: string;

      /**
       * Organization resource name
       */
      @path
      organizationName: string;

      /**
       * Organization resource model
       */
      @body
      body: OrganizationResource;
    },
    OrganizationResource
  >;
}
