import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Insights;
@doc("An Application Insights component definition.")
model ApplicationInsightsComponent
  is TrackedResource<ApplicationInsightsComponentProperties> {
  @doc("The name of the Application Insights component resource.")
  @path
  @key("resourceName")
  @segment("components")
  name: string;

  @doc("Resource etag")
  etag?: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface ApplicationInsightsComponents {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns an Application Insights component.")
  @operationId("Components_Get")
  get is ArmResourceRead<ApplicationInsightsComponent>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates (or updates) an Application Insights component. Note: You cannot specify a different value for InstrumentationKey nor AppId in the Put operation.")
  @operationId("Components_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ApplicationInsightsComponent>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates an existing component's tags. To update other fields use the CreateOrUpdate method.")
  @operationId("Components_UpdateTags")
  updateTags is ArmCustomPatchSync<ApplicationInsightsComponent, TagsResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes an Application Insights component.")
  @operationId("Components_Delete")
  delete is ArmResourceDeleteSync<ApplicationInsightsComponent>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a list of Application Insights components within a resource group.")
  @operationId("Components_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<ApplicationInsightsComponent>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a list of all Application Insights components within a subscription.")
  @operationId("Components_List")
  list is ArmListBySubscription<ApplicationInsightsComponent>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("""
Purges data in an Application Insights component by a set of user-defined filters.

In order to manage system resources, purge requests are throttled at 50 requests per hour. You should batch the execution of purge requests by sending a single command whose predicate includes all user identities that require purging. Use the in operator to specify multiple identities. You should run the query prior to using for a purge request to verify that the results are expected.
Note: this operation is intended for Classic resources, for  workspace-based Application Insights resource please run purge operation (directly on the workspace)(https://docs.microsoft.com/en-us/rest/api/loganalytics/workspace-purge/purge) , scoped to specific resource id.
""")
  @operationId("Components_Purge")
  purge is ArmResourceActionNoContentSync<
    ApplicationInsightsComponent,
    ComponentPurgeBody
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create an API Key of an Application Insights component.")
  @operationId("APIKeys_Create")
  create is ArmResourceActionSync<
    ApplicationInsightsComponent,
    APIKeyRequest,
    ApplicationInsightsComponentAPIKey
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a Continuous Export configuration of an Application Insights component.")
  @operationId("ExportConfigurations_Create")
  create is ArmResourceActionSync<
    ApplicationInsightsComponent,
    ApplicationInsightsComponentExportRequest,
    ApplicationInsightsComponentExportConfigurationListResult
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a work item configuration for an Application Insights component.")
  @operationId("WorkItemConfigurations_Create")
  create is ArmResourceActionSync<
    ApplicationInsightsComponent,
    WorkItemCreateConfiguration,
    WorkItemConfiguration
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Components_GetPurgeStatus")
  @doc("Get status for an ongoing purge operation.")
  // FIXME: Components_GetPurgeStatus could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/operations/{purgeId}")
  @get
  getPurgeStatus is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Annotations_List")
  @doc("Gets the list of annotations for a component for given time range")
  // FIXME: Annotations_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/Annotations")
  @get
  list is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Annotations_Get")
  @doc("Get the annotation for given id.")
  // FIXME: Annotations_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/Annotations/{annotationId}")
  @get
  get is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("APIKeys_List")
  @doc("Gets a list of API keys of an Application Insights component.")
  // FIXME: APIKeys_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/ApiKeys")
  @get
  list is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("APIKeys_Get")
  @doc("Get the API Key for this key id.")
  // FIXME: APIKeys_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/APIKeys/{keyId}")
  @get
  get is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ExportConfigurations_List")
  @doc("Gets a list of Continuous Export configuration of an Application Insights component.")
  // FIXME: ExportConfigurations_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/exportconfiguration")
  @get
  list is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ExportConfigurations_Get")
  @doc("Get the Continuous Export configuration for this export id.")
  // FIXME: ExportConfigurations_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/exportconfiguration/{exportId}")
  @get
  get is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ComponentCurrentBillingFeatures_Get")
  @doc("Returns current billing features for an Application Insights component.")
  // FIXME: ComponentCurrentBillingFeatures_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/currentbillingfeatures")
  @get
  get is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ComponentQuotaStatus_Get")
  @doc("Returns daily data volume cap (quota) status for an Application Insights component.")
  // FIXME: ComponentQuotaStatus_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/quotastatus")
  @get
  get is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ComponentFeatureCapabilities_Get")
  @doc("Returns feature capabilities of the application insights component.")
  // FIXME: ComponentFeatureCapabilities_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/featurecapabilities")
  @get
  get is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ComponentAvailableFeatures_Get")
  @doc("Returns all available features of the application insights component.")
  // FIXME: ComponentAvailableFeatures_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/getavailablebillingfeatures")
  @get
  get is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ProactiveDetectionConfigurations_List")
  @doc("Gets a list of ProactiveDetection configurations of an Application Insights component.")
  // FIXME: ProactiveDetectionConfigurations_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/ProactiveDetectionConfigs")
  @get
  list is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ProactiveDetectionConfigurations_Get")
  @doc("Get the ProactiveDetection configuration for this configuration id.")
  // FIXME: ProactiveDetectionConfigurations_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/ProactiveDetectionConfigs/{ConfigurationId}")
  @get
  get is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkItemConfigurations_List")
  @doc("Gets the list work item configurations that exist for the application")
  // FIXME: WorkItemConfigurations_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/WorkItemConfigs")
  @get
  list is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkItemConfigurations_GetDefault")
  @doc("Gets default work item configurations that exist for the application")
  // FIXME: WorkItemConfigurations_GetDefault could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/DefaultWorkItemConfig")
  @get
  getDefault is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkItemConfigurations_GetItem")
  @doc("Gets specified work item configuration for an Application Insights component.")
  // FIXME: WorkItemConfigurations_GetItem could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/WorkItemConfigs/{workItemConfigId}")
  @get
  getItem is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Favorites_List")
  @doc("Gets a list of favorites defined within an Application Insights component.")
  // FIXME: Favorites_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/favorites")
  @get
  list is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Favorites_Get")
  @doc("Get a single favorite by its FavoriteId, defined within an Application Insights component.")
  // FIXME: Favorites_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/favorites/{favoriteId}")
  @get
  get is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("webTestLocations_List")
  @doc("Gets a list of web test locations available to this Application Insights component.")
  // FIXME: webTestLocations_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/syntheticmonitorlocations")
  @get
  list is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebTests_ListByComponent")
  @doc("Get all Application Insights web tests defined for the specified component.")
  // FIXME: WebTests_ListByComponent could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{componentName}/webtests")
  @get
  listByComponent is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AnalyticsItems_List")
  @doc("Gets a list of Analytics Items defined within an Application Insights component.")
  // FIXME: AnalyticsItems_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.insights/components/{resourceName}/{scopePath}")
  @get
  list is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AnalyticsItems_Get")
  @doc("Gets a specific Analytics Items defined within an Application Insights component.")
  // FIXME: AnalyticsItems_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.insights/components/{resourceName}/{scopePath}/item")
  @get
  get is Azure.Core.Foundations.Operation<
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

@@projectedName(ApplicationInsightsComponents.createOrUpdate::parameters.resource,
  "json",
  "InsightProperties"
);
@@extension(ApplicationInsightsComponents.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "InsightProperties"
);
@@doc(ApplicationInsightsComponents.createOrUpdate::parameters.resource,
  "Properties that need to be specified to create an Application Insights component."
);
@@projectedName(ApplicationInsightsComponents.updateTags::parameters.properties,
  "json",
  "ComponentTags"
);
@@extension(ApplicationInsightsComponents.updateTags::parameters.properties,
  "x-ms-client-name",
  "ComponentTags"
);
@@doc(ApplicationInsightsComponents.updateTags::parameters.properties,
  "Updated tag information to set into the component instance."
);
@@doc(ApplicationInsightsComponents.purge::parameters.body,
  "Describes the body of a request to purge data in a single table of an Application Insights component"
);
@@projectedName(ApplicationInsightsComponents.create::parameters.body,
  "json",
  "APIKeyProperties"
);
@@extension(ApplicationInsightsComponents.create::parameters.body,
  "x-ms-client-name",
  "APIKeyProperties"
);
@@doc(ApplicationInsightsComponents.create::parameters.body,
  "Properties that need to be specified to create an API key of a Application Insights component."
);
@@projectedName(ApplicationInsightsComponents.create::parameters.body,
  "json",
  "ExportProperties"
);
@@extension(ApplicationInsightsComponents.create::parameters.body,
  "x-ms-client-name",
  "ExportProperties"
);
@@doc(ApplicationInsightsComponents.create::parameters.body,
  "Properties that need to be specified to create a Continuous Export configuration of a Application Insights component."
);
@@projectedName(ApplicationInsightsComponents.create::parameters.body,
  "json",
  "WorkItemConfigurationProperties"
);
@@extension(ApplicationInsightsComponents.create::parameters.body,
  "x-ms-client-name",
  "WorkItemConfigurationProperties"
);
@@doc(ApplicationInsightsComponents.create::parameters.body,
  "Properties that need to be specified to create a work item configuration of a Application Insights component."
);
