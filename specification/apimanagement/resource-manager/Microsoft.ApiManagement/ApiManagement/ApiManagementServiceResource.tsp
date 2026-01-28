import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApiManagement;
/**
 * A single API Management service resource in List or Get response.
 */
model ApiManagementServiceResource
  is Azure.ResourceManager.TrackedResource<
    ApiManagementServiceProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = ApiManagementServiceResource,
    KeyName = "serviceName",
    SegmentName = "service",
    NamePattern = "^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$"
  >;

  /**
   * SKU properties of the API Management service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku: ApiManagementServiceSkuProperties;

  /**
   * Managed service identity of the Api Management service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: ApiManagementServiceIdentity;

  /**
   * ETag of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: Azure.Core.eTag;

  ...Azure.ResourceManager.AvailabilityZonesProperty;
}

@@minLength(ApiManagementServiceResource.name, 1);
@@maxLength(ApiManagementServiceResource.name, 50);

alias QuotaCounterKeyParentParameters = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;

  /**
   *  The name of the API Management service.
   */
  @path
  @segment("service")
  @key
  @minLength(1)
  @maxLength(50)
  @pattern("^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$")
  serviceName: string;
};

alias QuotaCounterKeyParameters = {
  /**
   * Quota counter key identifier. This is the result of expression defined in `counter-key` attribute of the quota-by-key policy. For example, if you specify `counter-key="boo"` in the policy, then it’s accessible by `"boo"` counter key. But if it’s defined as `counter-key="@("b"+"a")"` then it will be accessible by `"ba"` key.
   */
  @path
  @key
  @segment("quotas")
  quotaCounterKey: string;
};

alias QuotaCounterKeyOps = Azure.ResourceManager.Legacy.RoutedOperations<
  QuotaCounterKeyParentParameters,
  QuotaCounterKeyParameters,
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ApiManagement/service/{serviceName}/quotas/{quotaCounterKey}",
  }
>;

alias QuotaPeriodKeyParentParameters = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;

  /**
   *  The name of the API Management service.
   */
  @path
  @segment("service")
  @key
  @minLength(1)
  @maxLength(50)
  @pattern("^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$")
  serviceName: string;

  /**
   * Quota counter key identifier. This is the result of expression defined in `counter-key` attribute of the quota-by-key policy. For example, if you specify `counter-key="boo"` in the policy, then it’s accessible by `"boo"` counter key. But if it’s defined as `counter-key="@("b"+"a")"` then it will be accessible by `"ba"` key.
   */
  @path
  @key
  @segment("quotas")
  quotaCounterKey: string;
};

alias QuotaPeriodKeyParameters = {
  /**
   * Quota period key identifier.
   */
  @path
  @key
  @segment("periods")
  quotaPeriodKey: string;
};

alias QuotaPeriodKeyOps = Azure.ResourceManager.Legacy.RoutedOperations<
  QuotaPeriodKeyParentParameters,
  QuotaPeriodKeyParameters,
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ApiManagement/service/{serviceName}/quotas/{quotaCounterKey}/periods",
  }
>;

@armResourceOperations(#{ allowStaticRoutes: true })
interface ApiManagementServiceResources {
  /**
   * Gets an API Management service resource description.
   */
  get is ArmResourceRead<ApiManagementServiceResource>;

  /**
   * Creates or updates an API Management service. This is long running operation and could take several minutes to complete.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ApiManagementServiceResource,
    LroHeaders = ArmLroLocationHeader<FinalResult = ApiManagementServiceResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates an existing API Management service.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ApiManagementServiceResource,
    PatchModel = ApiManagementServiceUpdateParameters
  >;

  /**
   * Deletes an existing API Management service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    ApiManagementServiceResource,
    Response = ArmDeletedResponse | (ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ApiManagementServiceResource> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: ApiManagementServiceResource;
    }) | ArmDeletedNoContentResponse
  >;

  /**
   * List all API Management services within a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    ApiManagementServiceResource,
    Response = ArmResponse<ApiManagementServiceListResult>
  >;

  /**
   * Lists all API Management services within an Azure subscription.
   */
  list is ArmListBySubscription<
    ApiManagementServiceResource,
    Response = ArmResponse<ApiManagementServiceListResult>
  >;

  /**
   * Status of all policies of API Management services.
   */
  @get
  @action("allPolicies")
  @list
  listByService is ArmResourceActionSync<
    ApiManagementServiceResource,
    void,
    ArmResponse<AllPoliciesCollection>
  >;

  /**
   * Lists a collection of apis associated with tags.
   */
  @get
  @action("apisByTags")
  @list
  listByTags is ArmResourceActionSync<
    ApiManagementServiceResource,
    void,
    ArmResponse<TagResourceCollection>,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| displayName | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| apiRevision | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| path | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| description | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| serviceUrl | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| isCurrent | filter | eq |     |</br>
       */
      @query("$filter")
      $filter?: string;

      /**
       * Number of records to return.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * Number of records to skip.
       */
      @minValue(0)
      @query("$skip")
      $skip?: int32;

      /**
       * Include not tagged APIs.
       */
      @query("includeNotTaggedApis")
      includeNotTaggedApis?: boolean;
    }
  >;

  /**
   * Performs a connectivity check between the API Management service and a given destination, and returns metrics for the connection, as well as errors encountered while trying to establish it.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("connectivityCheck")
  @operationId("PerformConnectivityCheckAsync")
  performConnectivityCheckAsync is ArmResourceActionAsync<
    ApiManagementServiceResource,
    ConnectivityCheckRequest,
    Response = ConnectivityCheckResponse
  >;

  /**
   * Gets all available SKU for a given API Management service
   */
  @get
  @action("skus")
  @list
  listAvailableServiceSkus is ArmResourceActionSync<
    ApiManagementServiceResource,
    void,
    ArmResponse<ResourceSkuResults>
  >;

  /**
   * Restores a backup of an API Management service created using the ApiManagementService_Backup operation on the current service. This is a long running operation and could take several minutes to complete.
   */
  restore is ArmResourceActionAsync<
    ApiManagementServiceResource,
    ApiManagementServiceBackupRestoreParameters,
    Response = ApiManagementServiceResource
  >;

  /**
   * Creates a backup of the API Management service to the given Azure Storage Account. This is long running operation and could take several minutes to complete.
   */
  backup is ArmResourceActionAsync<
    ApiManagementServiceResource,
    ApiManagementServiceBackupRestoreParameters,
    Response = ApiManagementServiceResource
  >;

  /**
   * Upgrades an API Management service to the Stv2 platform. For details refer to https://aka.ms/apim-migrate-stv2. This change is not reversible. This is long running operation and could take several minutes to complete.
   */
  migrateToStv2 is ArmResourceActionAsync<
    ApiManagementServiceResource,
    MigrateToStv2Contract,
    Response = ApiManagementServiceResource,
    OptionalRequestBody = true
  >;

  /**
   * Gets the Single-Sign-On token for the API Management Service which is valid for 5 Minutes.
   */
  @action("getssotoken")
  getSsoToken is ArmResourceActionSync<
    ApiManagementServiceResource,
    void,
    ArmResponse<ApiManagementServiceGetSsoTokenResult>
  >;

  /**
   * Updates the Microsoft.ApiManagement resource running in the Virtual network to pick the updated DNS changes.
   */
  @action("applynetworkconfigurationupdates")
  applyNetworkConfigurationUpdates is ArmResourceActionAsync<
    ApiManagementServiceResource,
    ApiManagementServiceApplyNetworkConfigurationParameters,
    Response = ApiManagementServiceResource,
    OptionalRequestBody = true
  >;

  /**
   * Force Refresh the SSL certificate attached to the Custom Hostnames configured using secret from KeyVault on the Api Management service.
   */
  refreshHostnames is ArmResourceActionAsync<
    ApiManagementServiceResource,
    void,
    ApiManagementServiceResource
  >;

  /**
   * Gets the Connectivity Status to the external resources on which the Api Management service depends from inside the Cloud Service. This also returns the DNS Servers as visible to the CloudService.
   */
  @get
  @action("networkstatus")
  networkStatusListByService is ArmResourceActionSync<
    ApiManagementServiceResource,
    void,
    ArmResponse<NetworkStatusContractByLocation[]>
  >;

  /**
   * Gets the Connectivity Status to the external resources on which the Api Management service depends from inside the Cloud Service. This also returns the DNS Servers as visible to the CloudService.
   */
  @get
  @action("networkstatus")
  listByLocation is ArmResourceActionSync<
    ApiManagementServiceResource,
    void,
    ArmResponse<NetworkStatusContract>,
    Parameters = {
      /**
       * Location in which the API Management service is deployed. This is one of the Azure Regions like West US, East US, South Central US.
       */
      @minLength(1)
      @path
      @segment("locations")
      locationName: string;
    }
  >;

  /**
   * Gets the network endpoints of all outbound dependencies of a ApiManagement service.
   */
  @get
  @action("outboundNetworkDependenciesEndpoints")
  outboundNetworkDependenciesEndpointsListByService is ArmResourceActionSync<
    ApiManagementServiceResource,
    void,
    ArmResponse<OutboundEnvironmentEndpointList>
  >;

  /**
   * Lists all policy descriptions.
   */
  @get
  @action("policyDescriptions")
  policyDescriptionListByService is ArmResourceActionSync<
    ApiManagementServiceResource,
    void,
    ArmResponse<PolicyDescriptionCollection>,
    Parameters = {
      /**
       * Policy scope.
       */
      @query("scope")
      scope?: PolicyScopeContract;
    }
  >;

  /**
   * Validate all policies of API Management services.
   */
  @action("validatePolicies")
  byService is ArmResourceActionAsync<
    ApiManagementServiceResource,
    void,
    Response = OperationResultContract
  >;

  /**
   * Lists a collection of portalsettings defined within a service instance..
   */
  #deprecated "deprecated"
  @get
  @action("portalsettings")
  portalSettingsListByService is ArmResourceActionSync<
    ApiManagementServiceResource,
    void,
    ArmResponse<PortalSettingsCollection>
  >;

  /**
   * Lists a collection of products associated with tags.
   */
  @get
  @action("productsByTags")
  @list
  productListByTags is ArmResourceActionSync<
    ApiManagementServiceResource,
    void,
    ArmResponse<TagResourceCollection>,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| displayName | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| description | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| terms | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| state | filter | eq | substringof, contains, startswith, endswith |</br>
       */
      @query("$filter")
      $filter?: string;

      /**
       * Number of records to return.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * Number of records to skip.
       */
      @minValue(0)
      @query("$skip")
      $skip?: int32;

      /**
       * Include not tagged Products.
       */
      @query("includeNotTaggedProducts")
      includeNotTaggedProducts?: boolean;
    }
  >;

  /**
   * Lists a collection of current quota counter periods associated with the counter-key configured in the policy on the specified service instance. The api does not support paging yet.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @externalDocs(
    "https://docs.microsoft.com/en-us/azure/api-management/api-management-howto-product-with-rules#a-namepolicies-ato-configure-call-rate-limit-and-quota-policies",
    "Document describing how to configure the quota policies."
  )
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/service/{serviceName}/quotas/{quotaCounterKey}")
  quotaByCounterKeysListByService is QuotaCounterKeyOps.ActionSync<
    ApiManagementServiceResource,
    void,
    Response = ArmResponse<QuotaCounterCollection>
  >;

  /**
   * Updates all the quota counter values specified with the existing quota counter key to a value in the specified service instance. This should be used for reset of the quota counter values.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: true })
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/service/{serviceName}/quotas/{quotaCounterKey}")
  quotaByCounterKeysUpdate is QuotaCounterKeyOps.ActionSync<
    ApiManagementServiceResource,
    Request = QuotaCounterValueUpdateContract,
    Response = ArmResponse<QuotaCounterCollection>
  >;

  /**
   * Gets the value of the quota counter associated with the counter-key in the policy for the specific period in service instance.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/service/{serviceName}/quotas/{quotaCounterKey}/periods/{quotaPeriodKey}")
  @externalDocs(
    "https://docs.microsoft.com/en-us/azure/api-management/api-management-howto-product-with-rules#a-namepolicies-ato-configure-call-rate-limit-and-quota-policies",
    "Document describing how to configure the quota policies."
  )
  quotaByPeriodKeysGet is QuotaPeriodKeyOps.ActionSync<
    ApiManagementServiceResource,
    void,
    Response = ArmResponse<QuotaCounterContract>
  >;

  /**
   * Updates an existing quota counter value in the specified service instance.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: true })
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/service/{serviceName}/quotas/{quotaCounterKey}/periods/{quotaPeriodKey}")
  quotaByPeriodKeysUpdate is QuotaPeriodKeyOps.ActionSync<
    ApiManagementServiceResource,
    QuotaCounterValueUpdateContract,
    Response = ArmResponse<QuotaCounterContract>
  >;

  /**
   * Lists all azure regions in which the service exists.
   */
  @get
  @action("regions")
  @list
  regionListByService is ArmResourceActionSync<
    ApiManagementServiceResource,
    void,
    ArmResponse<RegionListResult>
  >;

  /**
   * Lists report records by API.
   */
  @get
  @action("reports/byApi")
  @list
  listByApi is ArmResourceActionSync<
    ApiManagementServiceResource,
    void,
    ArmResponse<ReportCollection>,
    Parameters = {
      /**
       * The filter to apply on the operation.
       */
      @query("$filter")
      $filter: string;

      /**
       * Number of records to return.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * Number of records to skip.
       */
      @minValue(0)
      @query("$skip")
      $skip?: int32;

      /**
       * OData order by query option.
       */
      @query("$orderby")
      $orderby?: string;
    }
  >;

  /**
   * Lists report records by User.
   */
  @get
  @action("reports/byUser")
  @list
  listByUser is ArmResourceActionSync<
    ApiManagementServiceResource,
    void,
    ArmResponse<ReportCollection>,
    Parameters = {
      /**
       * |   Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| timestamp | filter | ge, le |     | </br>| displayName | select, orderBy |     |     | </br>| userId | select, filter | eq |     | </br>| apiRegion | filter | eq |     | </br>| productId | filter | eq |     | </br>| subscriptionId | filter | eq |     | </br>| apiId | filter | eq |     | </br>| operationId | filter | eq |     | </br>| callCountSuccess | select, orderBy |     |     | </br>| callCountBlocked | select, orderBy |     |     | </br>| callCountFailed | select, orderBy |     |     | </br>| callCountOther | select, orderBy |     |     | </br>| callCountTotal | select, orderBy |     |     | </br>| bandwidth | select, orderBy |     |     | </br>| cacheHitsCount | select |     |     | </br>| cacheMissCount | select |     |     | </br>| apiTimeAvg | select, orderBy |     |     | </br>| apiTimeMin | select |     |     | </br>| apiTimeMax | select |     |     | </br>| serviceTimeAvg | select |     |     | </br>| serviceTimeMin | select |     |     | </br>| serviceTimeMax | select |     |     | </br>
       */
      @query("$filter")
      $filter: string;

      /**
       * Number of records to return.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * Number of records to skip.
       */
      @minValue(0)
      @query("$skip")
      $skip?: int32;

      /**
       * OData order by query option.
       */
      @query("$orderby")
      $orderby?: string;
    }
  >;

  /**
   * Lists report records by API Operations.
   */
  @get
  @action("reports/byOperation")
  @list
  listByOperation is ArmResourceActionSync<
    ApiManagementServiceResource,
    void,
    ArmResponse<ReportCollection>,
    Parameters = {
      /**
       * |   Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| timestamp | filter | ge, le |     | </br>| displayName | select, orderBy |     |     | </br>| apiRegion | filter | eq |     | </br>| userId | filter | eq |     | </br>| productId | filter | eq |     | </br>| subscriptionId | filter | eq |     | </br>| apiId | filter | eq |     | </br>| operationId | select, filter | eq |     | </br>| callCountSuccess | select, orderBy |     |     | </br>| callCountBlocked | select, orderBy |     |     | </br>| callCountFailed | select, orderBy |     |     | </br>| callCountOther | select, orderBy |     |     | </br>| callCountTotal | select, orderBy |     |     | </br>| bandwidth | select, orderBy |     |     | </br>| cacheHitsCount | select |     |     | </br>| cacheMissCount | select |     |     | </br>| apiTimeAvg | select, orderBy |     |     | </br>| apiTimeMin | select |     |     | </br>| apiTimeMax | select |     |     | </br>| serviceTimeAvg | select |     |     | </br>| serviceTimeMin | select |     |     | </br>| serviceTimeMax | select |     |     | </br>
       */
      @query("$filter")
      $filter: string;

      /**
       * Number of records to return.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * Number of records to skip.
       */
      @minValue(0)
      @query("$skip")
      $skip?: int32;

      /**
       * OData order by query option.
       */
      @query("$orderby")
      $orderby?: string;
    }
  >;

  /**
   * Lists report records by Product.
   */
  @get
  @action("reports/byProduct")
  @list
  listByProduct is ArmResourceActionSync<
    ApiManagementServiceResource,
    void,
    ArmResponse<ReportCollection>,
    Parameters = {
      /**
       * |   Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| timestamp | filter | ge, le |     | </br>| displayName | select, orderBy |     |     | </br>| apiRegion | filter | eq |     | </br>| userId | filter | eq |     | </br>| productId | select, filter | eq |     | </br>| subscriptionId | filter | eq |     | </br>| callCountSuccess | select, orderBy |     |     | </br>| callCountBlocked | select, orderBy |     |     | </br>| callCountFailed | select, orderBy |     |     | </br>| callCountOther | select, orderBy |     |     | </br>| callCountTotal | select, orderBy |     |     | </br>| bandwidth | select, orderBy |     |     | </br>| cacheHitsCount | select |     |     | </br>| cacheMissCount | select |     |     | </br>| apiTimeAvg | select, orderBy |     |     | </br>| apiTimeMin | select |     |     | </br>| apiTimeMax | select |     |     | </br>| serviceTimeAvg | select |     |     | </br>| serviceTimeMin | select |     |     | </br>| serviceTimeMax | select |     |     | </br>
       */
      @query("$filter")
      $filter: string;

      /**
       * Number of records to return.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * Number of records to skip.
       */
      @minValue(0)
      @query("$skip")
      $skip?: int32;

      /**
       * OData order by query option.
       */
      @query("$orderby")
      $orderby?: string;
    }
  >;

  /**
   * Lists report records by geography.
   */
  @get
  @action("reports/byGeo")
  @list
  listByGeo is ArmResourceActionSync<
    ApiManagementServiceResource,
    void,
    ArmResponse<ReportCollection>,
    Parameters = {
      /**
       * |   Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| timestamp | filter | ge, le |     | </br>| country | select |     |     | </br>| region | select |     |     | </br>| zip | select |     |     | </br>| apiRegion | filter | eq |     | </br>| userId | filter | eq |     | </br>| productId | filter | eq |     | </br>| subscriptionId | filter | eq |     | </br>| apiId | filter | eq |     | </br>| operationId | filter | eq |     | </br>| callCountSuccess | select |     |     | </br>| callCountBlocked | select |     |     | </br>| callCountFailed | select |     |     | </br>| callCountOther | select |     |     | </br>| bandwidth | select, orderBy |     |     | </br>| cacheHitsCount | select |     |     | </br>| cacheMissCount | select |     |     | </br>| apiTimeAvg | select |     |     | </br>| apiTimeMin | select |     |     | </br>| apiTimeMax | select |     |     | </br>| serviceTimeAvg | select |     |     | </br>| serviceTimeMin | select |     |     | </br>| serviceTimeMax | select |     |     | </br>
       */
      @query("$filter")
      $filter: string;

      /**
       * Number of records to return.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * Number of records to skip.
       */
      @minValue(0)
      @query("$skip")
      $skip?: int32;
    }
  >;

  /**
   * Lists report records by subscription.
   */
  @get
  @action("reports/bySubscription")
  @list
  listBySubscription is ArmResourceActionSync<
    ApiManagementServiceResource,
    void,
    ArmResponse<ReportCollection>,
    Parameters = {
      /**
       * |   Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| timestamp | filter | ge, le |     | </br>| displayName | select, orderBy |     |     | </br>| apiRegion | filter | eq |     | </br>| userId | select, filter | eq |     | </br>| productId | select, filter | eq |     | </br>| subscriptionId | select, filter | eq |     | </br>| callCountSuccess | select, orderBy |     |     | </br>| callCountBlocked | select, orderBy |     |     | </br>| callCountFailed | select, orderBy |     |     | </br>| callCountOther | select, orderBy |     |     | </br>| callCountTotal | select, orderBy |     |     | </br>| bandwidth | select, orderBy |     |     | </br>| cacheHitsCount | select |     |     | </br>| cacheMissCount | select |     |     | </br>| apiTimeAvg | select, orderBy |     |     | </br>| apiTimeMin | select |     |     | </br>| apiTimeMax | select |     |     | </br>| serviceTimeAvg | select |     |     | </br>| serviceTimeMin | select |     |     | </br>| serviceTimeMax | select |     |     | </br>
       */
      @query("$filter")
      $filter: string;

      /**
       * Number of records to return.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * Number of records to skip.
       */
      @minValue(0)
      @query("$skip")
      $skip?: int32;

      /**
       * OData order by query option.
       */
      @query("$orderby")
      $orderby?: string;
    }
  >;

  /**
   * Lists report records by Time.
   */
  @get
  @action("reports/byTime")
  @list
  listByTime is ArmResourceActionSync<
    ApiManagementServiceResource,
    void,
    ArmResponse<ReportCollection>,
    Parameters = {
      /**
       * |   Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| timestamp | filter, select | ge, le |     | </br>| interval | select |     |     | </br>| apiRegion | filter | eq |     | </br>| userId | filter | eq |     | </br>| productId | filter | eq |     | </br>| subscriptionId | filter | eq |     | </br>| apiId | filter | eq |     | </br>| operationId | filter | eq |     | </br>| callCountSuccess | select |     |     | </br>| callCountBlocked | select |     |     | </br>| callCountFailed | select |     |     | </br>| callCountOther | select |     |     | </br>| bandwidth | select, orderBy |     |     | </br>| cacheHitsCount | select |     |     | </br>| cacheMissCount | select |     |     | </br>| apiTimeAvg | select |     |     | </br>| apiTimeMin | select |     |     | </br>| apiTimeMax | select |     |     | </br>| serviceTimeAvg | select |     |     | </br>| serviceTimeMin | select |     |     | </br>| serviceTimeMax | select |     |     | </br>
       */
      @query("$filter")
      $filter: string;

      /**
       * Number of records to return.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * Number of records to skip.
       */
      @minValue(0)
      @query("$skip")
      $skip?: int32;

      /**
       * OData order by query option.
       */
      @query("$orderby")
      $orderby?: string;

      /**
       * By time interval. Interval must be multiple of 15 minutes and may not be zero. The value should be in ISO  8601 format (http://en.wikipedia.org/wiki/ISO_8601#Durations).This code can be used to convert TimeSpan to a valid interval string: XmlConvert.ToString(new TimeSpan(hours, minutes, seconds)).
       */
      @query("interval")
      interval: duration;
    }
  >;

  /**
   * Lists report records by Request.
   */
  @get
  @action("reports/byRequest")
  @list
  listByRequest is ArmResourceActionSync<
    ApiManagementServiceResource,
    void,
    ArmResponse<RequestReportCollection>,
    Parameters = {
      /**
       * |   Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| timestamp | filter | ge, le |     | </br>| apiId | filter | eq |     | </br>| operationId | filter | eq |     | </br>| productId | filter | eq |     | </br>| userId | filter | eq |     | </br>| apiRegion | filter | eq |     | </br>| subscriptionId | filter | eq |     | </br>
       */
      @query("$filter")
      $filter: string;

      /**
       * Number of records to return.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * Number of records to skip.
       */
      @minValue(0)
      @query("$skip")
      $skip?: int32;
    }
  >;

  /**
   * Lists a collection of resources associated with tags.
   */
  @get
  @action("tagResources")
  @list
  tagResourceListByService is ArmResourceActionSync<
    ApiManagementServiceResource,
    void,
    ArmResponse<TagResourceCollection>,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| aid | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| displayName | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| apiName | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| apiRevision | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| path | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| description | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| serviceUrl | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| method | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| urlTemplate | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| terms | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| state | filter | eq |     |</br>| isCurrent | filter | eq |     |</br>
       */
      @query("$filter")
      $filter?: string;

      /**
       * Number of records to return.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * Number of records to skip.
       */
      @minValue(0)
      @query("$skip")
      $skip?: int32;
    }
  >;
}

@@maxLength(ApiManagementServiceResource.name, 50);
@@minLength(ApiManagementServiceResource.name, 1);
@@doc(ApiManagementServiceResource.name,
  "The name of the API Management service."
);
@@encodedName(ApiManagementServiceResource.etag, "application/json", "etag");
@@doc(ApiManagementServiceResource.properties,
  "Properties of the API Management service."
);
@@doc(ApiManagementServiceResources.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateOrUpdate API Management service operation."
);
@@doc(ApiManagementServiceResources.update::parameters.properties,
  "Parameters supplied to the CreateOrUpdate API Management service operation."
);
@@doc(ApiManagementServiceResources.performConnectivityCheckAsync::parameters.body,
  "Connectivity Check request parameters."
);
@@doc(ApiManagementServiceResources.restore::parameters.body,
  "Parameters supplied to the Restore API Management service from backup operation."
);
@@doc(ApiManagementServiceResources.backup::parameters.body,
  "Parameters supplied to the ApiManagementService_Backup operation."
);
@@doc(ApiManagementServiceResources.migrateToStv2::parameters.body,
  "Optional parameters supplied to migrate service."
);
@@doc(ApiManagementServiceResources.applyNetworkConfigurationUpdates::parameters.body,
  "Parameters supplied to the Apply Network Configuration operation. If the parameters are empty, all the regions in which the Api Management service is deployed will be updated sequentially without incurring downtime in the region."
);
@@doc(ApiManagementServiceResources.quotaByCounterKeysUpdate::parameters.body,
  "The value of the quota counter to be applied to all quota counter periods."
);
@@doc(ApiManagementServiceResources.quotaByPeriodKeysUpdate::parameters.body,
  "The value of the Quota counter to be applied on the specified period."
);
