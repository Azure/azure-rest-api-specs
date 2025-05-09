// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ElasticVersionsOperationGroup {
  /**
   * Get a list of available versions for a region.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Get a list of available versions for a region.")
  @operationId("ElasticVersions_List")
  @autoRoute
  @get
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
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface OrganizationsOperationGroup {
  /**
   * Fetch User API Key from internal database, if it was generated and stored while creating the Elasticsearch Organization.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Fetch User API Key from internal database, if it was generated and stored while creating the Elasticsearch Organization.")
  @operationId("Organizations_GetApiKey")
  @autoRoute
  @action("getOrganizationApiKey")
  getApiKey is ArmProviderActionSync<
    Request = UserEmailId,
    Response = UserApiKeyResponse,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
  /**
   * Get Elastic Organization To Azure Subscription Mapping details for the logged-in user.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Get Elastic Organization To Azure Subscription Mapping details for the logged-in user.")
  @operationId("Organizations_GetElasticToAzureSubscriptionMapping")
  @autoRoute
  @action("getElasticOrganizationToAzureSubscriptionMapping")
  getElasticToAzureSubscriptionMapping is ArmProviderActionSync<
    Response = ElasticOrganizationToAzureSubscriptionMappingResponse,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}
