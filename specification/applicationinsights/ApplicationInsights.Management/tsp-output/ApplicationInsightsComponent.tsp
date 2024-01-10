import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Insights;
@doc("An Application Insights component definition.")
model ApplicationInsightsComponent
  is TrackedResource<ApplicationInsightsComponentProperties> {
  @doc("The name of the Application Insights component resource.")
  @key("resourceName")
  @segment("components")
  name: string;

  @doc("Resource etag")
  etag?: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
@projectedName("client", "Components")
interface ApplicationInsightsComponents_Components {
  @doc("Returns an Application Insights component.")
  get is ArmResourceRead<ApplicationInsightsComponent>;

  @doc("Creates (or updates) an Application Insights component. Note: You cannot specify a different value for InstrumentationKey nor AppId in the Put operation.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ApplicationInsightsComponent>;

  @doc("Updates an existing component's tags. To update other fields use the CreateOrUpdate method.")
  updateTags is ArmCustomPatchSync<ApplicationInsightsComponent, TagsResource>;

  @doc("Deletes an Application Insights component.")
  delete is ArmResourceDeleteSync<ApplicationInsightsComponent>;

  @doc("Gets a list of Application Insights components within a resource group.")
  listByResourceGroup is ArmResourceListByParent<ApplicationInsightsComponent>;

  @doc("Gets a list of all Application Insights components within a subscription.")
  list is ArmListBySubscription<ApplicationInsightsComponent>;

  @doc("""
Purges data in an Application Insights component by a set of user-defined filters.

In order to manage system resources, purge requests are throttled at 50 requests per hour. You should batch the execution of purge requests by sending a single command whose predicate includes all user identities that require purging. Use the in operator to specify multiple identities. You should run the query prior to using for a purge request to verify that the results are expected.
Note: this operation is intended for Classic resources, for  workspace-based Application Insights resource please run purge operation (directly on the workspace)(https://docs.microsoft.com/en-us/rest/api/loganalytics/workspace-purge/purge) , scoped to specific resource id.
""")
  purge is ArmResourceActionNoContentSync<
    ApplicationInsightsComponent,
    ComponentPurgeBody
  >;

  @doc("Get status for an ongoing purge operation.")
  // FIXME: Components_GetPurgeStatus could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/operations/{purgeId}")
  @get
  GetPurgeStatus is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the Application Insights component resource.")
      @path
      resourceName: string;

      @doc("In a purge status request, this is the Id of the operation the status of which is returned.")
      @path
      purgeId: string;
    },
    ComponentPurgeStatusResponse
  >;
}

@armResourceOperations
@projectedName("client", "APIKeys")
interface ApplicationInsightsComponents_APIKeys {
  @doc("Create an API Key of an Application Insights component.")
  create is ArmResourceActionSync<
    ApplicationInsightsComponent,
    APIKeyRequest,
    ApplicationInsightsComponentAPIKey
  >;

  @doc("Gets a list of API keys of an Application Insights component.")
  // FIXME: APIKeys_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/ApiKeys")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the Application Insights component resource.")
      @path
      resourceName: string;
    },
    ApplicationInsightsComponentAPIKeyListResult
  >;

  @doc("Get the API Key for this key id.")
  // FIXME: APIKeys_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/APIKeys/{keyId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the Application Insights component resource.")
      @path
      resourceName: string;

      @doc("The API Key ID. This is unique within a Application Insights component.")
      @path
      keyId: string;
    },
    ApplicationInsightsComponentAPIKey
  >;
}

@armResourceOperations
@projectedName("client", "ExportConfigurations")
interface ApplicationInsightsComponents_ExportConfigurations {
  @doc("Create a Continuous Export configuration of an Application Insights component.")
  create is ArmResourceActionSync<
    ApplicationInsightsComponent,
    ApplicationInsightsComponentExportRequest,
    ApplicationInsightsComponentExportConfigurationListResult
  >;

  @doc("Gets a list of Continuous Export configuration of an Application Insights component.")
  // FIXME: ExportConfigurations_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/exportconfiguration")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the Application Insights component resource.")
      @path
      resourceName: string;
    },
    void
  >;

  @doc("Get the Continuous Export configuration for this export id.")
  // FIXME: ExportConfigurations_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/exportconfiguration/{exportId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the Application Insights component resource.")
      @path
      resourceName: string;

      @doc("The Continuous Export configuration ID. This is unique within a Application Insights component.")
      @path
      exportId: string;
    },
    ApplicationInsightsComponentExportConfiguration
  >;
}

@armResourceOperations
@projectedName("client", "WorkItemConfigurations")
interface ApplicationInsightsComponents_WorkItemConfigurations {
  @doc("Create a work item configuration for an Application Insights component.")
  create is ArmResourceActionSync<
    ApplicationInsightsComponent,
    WorkItemCreateConfiguration,
    WorkItemConfiguration
  >;

  @doc("Gets the list work item configurations that exist for the application")
  // FIXME: WorkItemConfigurations_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/WorkItemConfigs")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the Application Insights component resource.")
      @path
      resourceName: string;
    },
    WorkItemConfigurationsListResult
  >;

  @doc("Gets default work item configurations that exist for the application")
  // FIXME: WorkItemConfigurations_GetDefault could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/DefaultWorkItemConfig")
  @get
  GetDefault is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the Application Insights component resource.")
      @path
      resourceName: string;
    },
    WorkItemConfiguration
  >;

  @doc("Gets specified work item configuration for an Application Insights component.")
  // FIXME: WorkItemConfigurations_GetItem could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/WorkItemConfigs/{workItemConfigId}")
  @get
  GetItem is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the Application Insights component resource.")
      @path
      resourceName: string;

      @doc("The unique work item configuration Id. This can be either friendly name of connector as defined in connector configuration")
      @path
      workItemConfigId: string;
    },
    WorkItemConfiguration
  >;
}

@armResourceOperations
@projectedName("client", "Annotations")
interface ApplicationInsightsComponents_Annotations {
  @doc("Gets the list of annotations for a component for given time range")
  // FIXME: Annotations_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/Annotations")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the Application Insights component resource.")
      @path
      resourceName: string;

      @doc("The start time to query from for annotations, cannot be older than 90 days from current date.")
      @query("start")
      start: string;

      @doc("The end time to query for annotations.")
      @query("end")
      end: string;
    },
    AnnotationsListResult
  >;

  @doc("Get the annotation for given id.")
  // FIXME: Annotations_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/Annotations/{annotationId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the Application Insights component resource.")
      @path
      resourceName: string;

      @doc("The unique annotation ID. This is unique within a Application Insights component.")
      @path
      annotationId: string;
    },
    void
  >;
}

@armResourceOperations
@projectedName("client", "ComponentCurrentBillingFeatures")
interface ApplicationInsightsComponents_ComponentCurrentBillingFeatures {
  @doc("Returns current billing features for an Application Insights component.")
  // FIXME: ComponentCurrentBillingFeatures_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/currentbillingfeatures")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the Application Insights component resource.")
      @path
      resourceName: string;
    },
    ApplicationInsightsComponentBillingFeatures
  >;
}

@armResourceOperations
@projectedName("client", "ComponentQuotaStatus")
interface ApplicationInsightsComponents_ComponentQuotaStatus {
  @doc("Returns daily data volume cap (quota) status for an Application Insights component.")
  // FIXME: ComponentQuotaStatus_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/quotastatus")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the Application Insights component resource.")
      @path
      resourceName: string;
    },
    ApplicationInsightsComponentQuotaStatus
  >;
}

@armResourceOperations
@projectedName("client", "ComponentFeatureCapabilities")
interface ApplicationInsightsComponents_ComponentFeatureCapabilities {
  @doc("Returns feature capabilities of the application insights component.")
  // FIXME: ComponentFeatureCapabilities_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/featurecapabilities")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the Application Insights component resource.")
      @path
      resourceName: string;
    },
    ApplicationInsightsComponentFeatureCapabilities
  >;
}

@armResourceOperations
@projectedName("client", "ComponentAvailableFeatures")
interface ApplicationInsightsComponents_ComponentAvailableFeatures {
  @doc("Returns all available features of the application insights component.")
  // FIXME: ComponentAvailableFeatures_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/getavailablebillingfeatures")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the Application Insights component resource.")
      @path
      resourceName: string;
    },
    ApplicationInsightsComponentAvailableFeatures
  >;
}

@armResourceOperations
@projectedName("client", "ProactiveDetectionConfigurations")
interface ApplicationInsightsComponents_ProactiveDetectionConfigurations {
  @doc("Gets a list of ProactiveDetection configurations of an Application Insights component.")
  // FIXME: ProactiveDetectionConfigurations_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/ProactiveDetectionConfigs")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the Application Insights component resource.")
      @path
      resourceName: string;
    },
    void
  >;

  @doc("Get the ProactiveDetection configuration for this configuration id.")
  // FIXME: ProactiveDetectionConfigurations_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/ProactiveDetectionConfigs/{ConfigurationId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the Application Insights component resource.")
      @path
      resourceName: string;

      @doc("The ProactiveDetection configuration ID. This is unique within a Application Insights component.")
      @path
      ConfigurationId: string;
    },
    ApplicationInsightsComponentProactiveDetectionConfiguration
  >;
}

@armResourceOperations
@projectedName("client", "Favorites")
interface ApplicationInsightsComponents_Favorites {
  @doc("Gets a list of favorites defined within an Application Insights component.")
  // FIXME: Favorites_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/favorites")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the Application Insights component resource.")
      @path
      resourceName: string;

      @doc("The type of favorite. Value can be either shared or user.")
      @query("favoriteType")
      favoriteType?: FavoriteType;

      @doc("Source type of favorite to return. When left out, the source type defaults to 'other' (not present in this enum).")
      @query("sourceType")
      sourceType?: FavoriteSourceType;

      @doc("Flag indicating whether or not to return the full content for each applicable favorite. If false, only return summary content for favorites.")
      @query("canFetchContent")
      canFetchContent?: boolean;

      @doc("Tags that must be present on each favorite returned.")
      @query({
        name: "tags",
        format: "csv",
      })
      tags?: string[];
    },
    void
  >;

  @doc("Get a single favorite by its FavoriteId, defined within an Application Insights component.")
  // FIXME: Favorites_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/favorites/{favoriteId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the Application Insights component resource.")
      @path
      resourceName: string;

      @doc("The Id of a specific favorite defined in the Application Insights component")
      @path
      favoriteId: string;
    },
    ApplicationInsightsComponentFavorite
  >;
}

@armResourceOperations
@projectedName("client", "webTestLocations")
interface ApplicationInsightsComponents_webTestLocations {
  @doc("Gets a list of web test locations available to this Application Insights component.")
  // FIXME: webTestLocations_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/syntheticmonitorlocations")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the Application Insights component resource.")
      @path
      resourceName: string;
    },
    void
  >;
}

@armResourceOperations
@projectedName("client", "WebTests")
interface ApplicationInsightsComponents_WebTests {
  @doc("Get all Application Insights web tests defined for the specified component.")
  // FIXME: WebTests_ListByComponent could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{componentName}/webtests")
  @get
  ListByComponent is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the Application Insights component resource.")
      @path
      componentName: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;
    },
    ResourceListResult<WebTest>
  >;
}

@armResourceOperations
@projectedName("client", "AnalyticsItems")
interface ApplicationInsightsComponents_AnalyticsItems {
  @doc("Gets a list of Analytics Items defined within an Application Insights component.")
  // FIXME: AnalyticsItems_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.insights/components/{resourceName}/{scopePath}")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the Application Insights component resource.")
      @path
      resourceName: string;

      @doc("Enum indicating if this item definition is owned by a specific user or is shared between all users with access to the Application Insights component.")
      @path
      scopePath: ItemScopePath;

      @doc("Enum indicating if this item definition is owned by a specific user or is shared between all users with access to the Application Insights component.")
      @query("scope")
      scope?: ItemScope;

      @doc("Enum indicating the type of the Analytics item.")
      @query("type")
      type?: ItemTypeParameter = ItemTypeParameter.none;

      @doc("Flag indicating whether or not to return the content of each applicable item. If false, only return the item information.")
      @query("includeContent")
      includeContent?: boolean;
    },
    void
  >;

  @doc("Gets a specific Analytics Items defined within an Application Insights component.")
  // FIXME: AnalyticsItems_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.insights/components/{resourceName}/{scopePath}/item")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the Application Insights component resource.")
      @path
      resourceName: string;

      @doc("Enum indicating if this item definition is owned by a specific user or is shared between all users with access to the Application Insights component.")
      @path
      scopePath: ItemScopePath;

      @doc("The Id of a specific item defined in the Application Insights component")
      @query("id")
      id?: string;

      @doc("The name of a specific item defined in the Application Insights component")
      @query("name")
      name?: string;
    },
    ApplicationInsightsComponentAnalyticsItem
  >;
}
