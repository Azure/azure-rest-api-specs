import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.AgriculturePlatform")
@service(#{ title: "Microsoft.AgriculturePlatform" })
@versioned(Microsoft.AgriculturePlatform.Versions)
namespace Microsoft.AgriculturePlatform;

@doc("Supported API versions for the Microsoft.AgriculturePlatform resource provider.")
enum Versions {
  @doc("The 2024-06-01-preview version.")
  @Versioning.useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_06_01_preview: "2024-06-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("Schema of the AgriService resource from Microsoft.AgriculturePlatform resource provider.")
model AgriServiceResource is TrackedResource<AgriServiceResourceProperties> {
  @doc("The name of the AgriService resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("agriServiceResourceName")
  @segment("agriServices")
  @visibility(Lifecycle.Read)
  @path
  name: string;

  ...ManagedServiceIdentityProperty;
  ...ResourceSkuProperty;
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
union ProvisioningState {
  string,

  /** Resource has been created. */
  Succeeded: "Succeeded",

  /** Resource creation failed. */
  Failed: "Failed",

  /** Resource creation was canceled. */
  Canceled: "Canceled",

  /** The resource is being provisioned */
  Provisioning: "Provisioning",

  /** The resource is updating */
  Updating: "Updating",

  /** The resource is being deleted */
  Deleting: "Deleting",

  /** The resource create request has been accepted */
  Accepted: "Accepted",
}

@doc("Details of the Agriculture AgriDataManager.")
model AgriServiceResourceProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("Config of the AgriService instance.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  config?: AgriServiceConfig;

  @visibility(Lifecycle.Read)
  @doc("Managed On Behalf Of Configuration.")
  managedOnBehalfOfConfiguration?: ManagedOnBehalfOfConfiguration;

  @doc("Data connector credentials of AgriService instance.")
  @OpenAPI.extension("x-ms-identifiers", #["key"])
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  dataConnectorCredentials?: DataConnectorCredentialMap[];

  @doc("AgriService installed solutions.")
  @OpenAPI.extension("x-ms-identifiers", #["key"])
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  installedSolutions?: InstalledSolutionMap[];
}

@doc("Mapping of data connector credentials.")
model DataConnectorCredentialMap {
  @doc("The key representing the credential.")
  key: string;

  @doc("The data connector credential value.")
  value: DataConnectorCredentials;
}

@doc("Mapping of installed solutions.")
model InstalledSolutionMap {
  @doc("The key representing the installed solution.")
  key: string;

  @doc("The installed solution value.")
  value: Solution;
}

@doc("Config of the AgriService resource instance.")
model AgriServiceConfig {
  @doc("Instance URI of the AgriService instance.")
  @visibility(Lifecycle.Read)
  @minLength(2)
  @maxLength(256)
  instanceUri?: string;

  @doc("Version of AgriService instance.")
  @visibility(Lifecycle.Read)
  @minLength(2)
  @maxLength(256)
  version?: string;

  @doc("App service resource Id.")
  @visibility(Lifecycle.Read)
  @minLength(2)
  appServiceResourceId?: string;

  @doc("Cosmos Db resource Id.")
  @visibility(Lifecycle.Read)
  @minLength(2)
  cosmosDbResourceId?: string;

  @doc("Storage account resource Id.")
  @visibility(Lifecycle.Read)
  @minLength(2)
  storageAccountResourceId?: string;

  @doc("Key vault resource Id.")
  @visibility(Lifecycle.Read)
  @minLength(2)
  keyVaultResourceId?: string;

  @doc("Redis cache resource Id.")
  @visibility(Lifecycle.Read)
  @minLength(2)
  redisCacheResourceId?: string;
}

@doc("The properties related to an AgriService data connector.")
model DataConnectorCredentials {
  @doc("Type of credential.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  kind?: AuthCredentialsKind;

  @doc("Client Id associated with the provider, if type of credentials is OAuthClientCredentials.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @minLength(2)
  clientId?: string;

  @doc("Uri of the key vault")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @minLength(2)
  keyVaultUri?: string;

  @doc("Name of the key vault key.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @minLength(2)
  keyName?: string;

  @doc("Version of the key vault key.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @minLength(2)
  keyVersion?: string;
}

@doc("Types of different kind of Data connector auth credentials supported.")
union AuthCredentialsKind {
  string,

  /** OAuth Client Credential type */
  OAuthClientCredentials: "OAuthClientCredentials",

  /** API Key Auth Credential type */
  ApiKeyAuthCredentials: "ApiKeyAuthCredentials",
}

@doc("Installed data manager for Agriculture solution detail.")
model Solution {
  @doc("Application name of the solution.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @minLength(2)
  applicationName?: string;

  @doc("Partner Id.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @minLength(2)
  partnerId?: string;

  @doc("Marketplace publisher Id.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @minLength(2)
  marketPlacePublisherId?: string;

  @doc("Saas subscription Id.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @minLength(2)
  saasSubscriptionId?: string;

  @doc("Saas subscription name.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @minLength(2)
  saasSubscriptionName?: string;

  @doc("Plan Id.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @minLength(2)
  planId?: string;
}

@doc("Configuration of the managed on behalf of resource.")
model ManagedOnBehalfOfConfiguration {
  @visibility(Lifecycle.Read)
  @doc("Associated MoboBrokerResources.")
  moboBrokerResources: MoboBrokerResource[];
}

@doc("MoboBroker resource.")
model MoboBrokerResource {
  /**
   * The fully qualified resource ID of the MoboBroker resource.
   * Example: `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}`
   */
  @visibility(Lifecycle.Read)
  id: string;
}

@armResourceOperations(AgriServiceResource)
interface AgriService {
  get is ArmResourceRead<AgriServiceResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AgriServiceResource>;
  update is ArmCustomPatchAsync<
    AgriServiceResource,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      AgriServiceResource,
      AgriServiceResourceProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<AgriServiceResource>;
  listByResourceGroup is ArmResourceListByParent<AgriServiceResource>;
  listBySubscription is ArmListBySubscription<AgriServiceResource>;

  @doc("Returns the list of available agri solutions.")
  listAvailableSolutions is ArmResourceListActionSync<
    AgriServiceResource,
    AvailableAgriSolutionListResult
  >;
}

// note this is a template for an empty body resource action, which will be added to the library at some point
#suppress "@azure-tools/typespec-azure-core/documentation-required" "This is a template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "This is a template"
@armResourceAction(TResource)
@post
op ArmResourceListActionSync<
  TResource extends Azure.ResourceManager.Foundations.Resource,
  TResponse extends {},
  TBaseParameters = Azure.ResourceManager.Foundations.BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,
): ArmResponse<TResponse> | ErrorResponse;

@doc("The list of available agri solutions.")
model AvailableAgriSolutionListResult {
  @doc("Agri solutions list.")
  @identifiers(#[])
  solutions: DataManagerForAgricultureSolution[];
}

@doc("Data Manager for Agriculture solution.")
model DataManagerForAgricultureSolution {
  @doc("Partner Id.")
  partnerId: string;

  @doc("Solution Id.")
  solutionId: string;

  @doc("Partner tenant Id.")
  partnerTenantId: string;

  @doc("Data access scopes.")
  dataAccessScopes: string[];

  @doc("Marketplace offer details.")
  marketPlaceOfferDetails: MarketPlaceOfferDetails;

  @doc("Saas application Id.")
  saasApplicationId: string;

  @doc("Entra application Id used to access azure data manager for agriculture instance.")
  accessAzureDataManagerForAgricultureApplicationId: string;

  @doc("Entra application name used to access azure data manager for agriculture instance.")
  accessAzureDataManagerForAgricultureApplicationName: string;

  @doc("Whether solution inference will validate input.")
  isValidateInput: boolean;
}

@doc("Marketplace offer details of Agri solution.")
model MarketPlaceOfferDetails {
  @doc("Saas offer Id.")
  saasOfferId: string;

  @doc("Publisher Id.")
  publisherId: string;
}
