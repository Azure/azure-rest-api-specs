import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.Elastic;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ElasticVersionsOperationGroup {
  /**
   * Retrieve a list of all available Elastic versions for a specified region, helping you choose the best version for your deployment.
   */
  @summary("Retrieve a list of all available Elastic versions for a specified region, helping you choose the best version for your deployment.")
  @autoRoute
  @get
  @list
  @action("elasticVersions")
  list is ArmProviderActionSync<
    Response = ElasticVersionsListResponse,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * Region where elastic deployment will take place.
       */
      @query("region")
      region: string;
    },
    Error = ResourceProviderDefaultErrorResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface OrganizationsOperationGroup {
  /**
   * Fetch the User API Key from the internal database, if it was generated and stored during the creation of the Elasticsearch Organization.
   */
  @summary("Fetch the User API Key from the internal database, if it was generated and stored during the creation of the Elasticsearch Organization.")
  @autoRoute
  @action("getOrganizationApiKey")
  getApiKey is ArmProviderActionSync<
    Request = UserEmailId,
    Response = UserApiKeyResponse,
    Scope = SubscriptionActionScope,
    Parameters = {},
    Error = ResourceProviderDefaultErrorResponse,
    OptionalRequestBody = true
  >;
  /**
  >;
  /**
   * Retrieve mapping details between the Elastic Organization and Azure Subscription for the logged-in user.
   */
  @summary("Retrieve mapping details between the Elastic Organization and Azure Subscription for the logged-in user.")
  @autoRoute
  @action("getElasticOrganizationToAzureSubscriptionMapping")
  getElasticToAzureSubscriptionMapping is ArmProviderActionSync<
    Response = ElasticOrganizationToAzureSubscriptionMappingResponse,
    Scope = SubscriptionActionScope,
    Parameters = {},
    Error = ResourceProviderDefaultErrorResponse
  >;
}
