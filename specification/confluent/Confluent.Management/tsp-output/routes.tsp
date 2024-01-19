import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Confluent;

interface MarketplaceAgreementsOperations {
  @summary("List Confluent marketplace agreements in the subscription.")
  @doc("List Confluent marketplace agreements in the subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Confluent/agreements")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("Microsoft Azure subscription id")
      @path
      subscriptionId: string;
    },
    ConfluentAgreementResourceListResponse
  >;

  @summary("Create Confluent Marketplace agreement in the subscription.")
  @doc("Create Confluent Marketplace agreement in the subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Confluent/agreements/default")
  @put
  create is Azure.Core.Foundations.Operation<
    {
      @doc("Microsoft Azure subscription id")
      @path
      subscriptionId: string;

      @doc("Confluent Marketplace Agreement resource")
      @body
      body?: ConfluentAgreementResource;
    },
    ConfluentAgreementResource
  >;
}

interface ValidationsOperations {
  @summary("Organization Validate proxy resource")
  @doc("Organization Validate proxy resource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Confluent/validations/{organizationName}/orgvalidate")
  @post
  validateOrganization is Azure.Core.Foundations.Operation<
    {
      @doc("Microsoft Azure subscription id")
      @path
      subscriptionId: string;

      @doc("Resource group name")
      @path
      resourceGroupName: string;

      @doc("Organization resource name")
      @path
      organizationName: string;

      @doc("Organization resource model")
      @body
      body: OrganizationResource;
    },
    OrganizationResource
  >;
}
