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

namespace ComponentAPIs;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface AnnotationsOperationGroup {
  /**
   * Gets the list of annotations for a component for given time range
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/Annotations")
  @get
  @list
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the Application Insights component resource.
     */
    @path
    resourceName: string,

    /**
     * The start time to query from for annotations, cannot be older than 90 days from current date.
     */
    @query("start")
    start: string,

    /**
     * The end time to query for annotations.
     */
    @query("end")
    end: string,
  ): ArmResponse<AnnotationsListResult> | AnnotationError;

  /**
   * Create an Annotation of an Application Insights component.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/Annotations")
  @put
  create(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the Application Insights component resource.
     */
    @path
    @segment("components")
    resourceName: string,

    /** Properties that need to be specified to create an annotation of a Application Insights component. */
    @bodyRoot
    body: Annotation,
  ): {
    #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @bodyRoot _: Annotation[];
  } | AnnotationError;

  /**
   * Delete an Annotation of an Application Insights component.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/Annotations/{annotationId}")
  @delete
  delete(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    /**
     * The name of the Application Insights component resource.
     */
    @path
    resourceName: string,

    /**
     * The unique annotation ID. This is unique within a Application Insights component.
     */
    @path
    annotationId: string,
  ): OkResponse | never;

  /**
   * Get the annotation for given id.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/Annotations/{annotationId}")
  @get
  get(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    /**
     * The name of the Application Insights component resource.
     */
    @path
    resourceName: string,

    /**
     * The unique annotation ID. This is unique within a Application Insights component.
     */
    @path
    annotationId: string,
  ): ArmResponse<Annotation[]> | AnnotationError;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface APIKeysOperationGroup {
  /**
   * Gets a list of API keys of an Application Insights component.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/ApiKeys")
  @get
  @list
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the Application Insights component resource.
     */
    @path
    resourceName: string,
  ): ArmResponse<ApplicationInsightsComponentAPIKeyListResult> | never;

  /**
   * Create an API Key of an Application Insights component.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/ApiKeys")
  @post
  create(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the Application Insights component resource.
     */
    @path
    resourceName: string,

    /** Properties that need to be specified to create an API Key of an Application Insights component. */
    @bodyRoot
    body: APIKeyRequest,
  ): ArmResponse<ApplicationInsightsComponentAPIKey> | never;
  /**
   * Delete an API Key of an Application Insights component.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/APIKeys/{keyId}")
  @delete
  delete(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    /**
     * The name of the Application Insights component resource.
     */
    @path
    resourceName: string,

    /**
     * The API Key ID. This is unique within a Application Insights component.
     */
    @path
    keyId: string,
  ): ArmResponse<ApplicationInsightsComponentAPIKey> | never;

  /**
   * Get the API Key for this key id.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/APIKeys/{keyId}")
  @get
  get(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    /**
     * The name of the Application Insights component resource.
     */
    @path
    resourceName: string,

    /**
     * The API Key ID. This is unique within a Application Insights component.
     */
    @path
    keyId: string,
  ): ArmResponse<ApplicationInsightsComponentAPIKey> | never;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ExportConfigurationsOperationGroup {
  /**
   * Gets a list of Continuous Export configuration of an Application Insights component.
   */
  @autoRoute
  @get
  @action("exportconfiguration")
  list is ArmProviderActionSync<
    Response = {
      @bodyRoot
      @identifiers(#["ExportId"])
      _: ApplicationInsightsComponentExportConfiguration[];
    },
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The name of the Application Insights component resource.
       */
      @path
      @segment("components")
      resourceName: string;
    },
    Error = never
  >;
  /**
   * Create a Continuous Export configuration of an Application Insights component.
   */
  @autoRoute
  @action("exportconfiguration")
  create is ArmProviderActionSync<
    Request = ApplicationInsightsComponentExportRequest,
    Response = {
      #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @bodyRoot _: ApplicationInsightsComponentExportConfiguration[];
    },
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The name of the Application Insights component resource.
       */
      @path
      @segment("components")
      resourceName: string;
    },
    Error = never
  >;
  /**
   * Delete a Continuous Export configuration of an Application Insights component.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/exportconfiguration/{exportId}")
  @delete
  delete(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    /**
     * The name of the Application Insights component resource.
     */
    @path
    resourceName: string,

    /**
     * The Continuous Export configuration ID. This is unique within a Application Insights component.
     */
    @path
    exportId: string,
  ): ArmResponse<ApplicationInsightsComponentExportConfiguration> | never;

  /**
   * Get the Continuous Export configuration for this export id.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/exportconfiguration/{exportId}")
  @get
  get(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    /**
     * The name of the Application Insights component resource.
     */
    @path
    resourceName: string,

    /**
     * The Continuous Export configuration ID. This is unique within a Application Insights component.
     */
    @path
    exportId: string,
  ): ArmResponse<ApplicationInsightsComponentExportConfiguration> | never;

  /**
   * Update the Continuous Export configuration for this export id.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/exportconfiguration/{exportId}")
  @put
  update(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    /**
     * The name of the Application Insights component resource.
     */
    @path
    resourceName: string,

    /**
     * The Continuous Export configuration ID. This is unique within a Application Insights component.
     */
    @path
    exportId: string,

    /**
     * Properties that need to be specified to update the Continuous Export configuration.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @bodyRoot
    ExportProperties: ApplicationInsightsComponentExportRequest,
  ): ArmResponse<ApplicationInsightsComponentExportConfiguration> | never;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ComponentCurrentBillingFeaturesOperationGroup {
  /**
   * Returns current billing features for an Application Insights component.
   */
  @autoRoute
  @get
  @action("currentbillingfeatures")
  get is ArmProviderActionSync<
    Response = ApplicationInsightsComponentBillingFeatures,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The name of the Application Insights component resource.
       */
      @path
      @segment("components")
      resourceName: string;
    },
    Error = never
  >;
  /**
   * Update current billing features for an Application Insights component.
   */
  @autoRoute
  @put
  @action("currentbillingfeatures")
  update is ArmProviderActionSync<
    Request = ApplicationInsightsComponentBillingFeatures,
    Response = ApplicationInsightsComponentBillingFeatures,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The name of the Application Insights component resource.
       */
      @path
      @segment("components")
      resourceName: string;
    },
    Error = never
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ComponentQuotaStatusOperationGroup {
  /**
   * Returns daily data volume cap (quota) status for an Application Insights component.
   */
  @autoRoute
  @get
  @action("quotastatus")
  get is ArmProviderActionSync<
    Response = ApplicationInsightsComponentQuotaStatus,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The name of the Application Insights component resource.
       */
      @path
      @segment("components")
      resourceName: string;
    },
    Error = never
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ComponentFeatureCapabilitiesOperationGroup {
  /**
   * Returns feature capabilities of the application insights component.
   */
  @autoRoute
  @get
  @action("featurecapabilities")
  get is ArmProviderActionSync<
    Response = ApplicationInsightsComponentFeatureCapabilities,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The name of the Application Insights component resource.
       */
      @path
      @segment("components")
      resourceName: string;
    },
    Error = never
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ComponentAvailableFeaturesOperationGroup {
  /**
   * Returns all available features of the application insights component.
   */
  @autoRoute
  @get
  @action("getavailablebillingfeatures")
  get is ArmProviderActionSync<
    Response = ApplicationInsightsComponentAvailableFeatures,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The name of the Application Insights component resource.
       */
      @path
      @segment("components")
      resourceName: string;
    },
    Error = never
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ProactiveDetectionConfigurationsOperationGroup {
  /**
   * Gets a list of ProactiveDetection configurations of an Application Insights component.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/ProactiveDetectionConfigs")
  @get
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the Application Insights component resource.
     */
    @path
    resourceName: string,
  ): {
    @bodyRoot
    @identifiers(#["Name"])
    _: ApplicationInsightsComponentProactiveDetectionConfiguration[];
  } | never;
  /**
   * Get the ProactiveDetection configuration for this configuration id.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/ProactiveDetectionConfigs/{ConfigurationId}")
  @get
  get(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    /**
     * The name of the Application Insights component resource.
     */
    @path
    resourceName: string,

    /**
     * The ProactiveDetection configuration ID. This is unique within a Application Insights component.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    ConfigurationId: string,
  ): ArmResponse<ApplicationInsightsComponentProactiveDetectionConfiguration> | never;

  /**
   * Update the ProactiveDetection configuration for this configuration id.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/ProactiveDetectionConfigs/{ConfigurationId}")
  @put
  update(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    /**
     * The name of the Application Insights component resource.
     */
    @path
    resourceName: string,

    /**
     * The ProactiveDetection configuration ID. This is unique within a Application Insights component.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    ConfigurationId: string,

    /**
     * Properties that need to be specified to update the ProactiveDetection configuration.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @bodyRoot
    ProactiveDetectionProperties: ApplicationInsightsComponentProactiveDetectionConfiguration,
  ): ArmResponse<ApplicationInsightsComponentProactiveDetectionConfiguration> | never;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface WorkItemConfigurationsOperationGroup {
  /**
   * Gets the list work item configurations that exist for the application
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/WorkItemConfigs")
  @get
  @list
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the Application Insights component resource.
     */
    @path
    resourceName: string,
  ): ArmResponse<WorkItemConfigurationsListResult> | WorkItemConfigurationError;

  /**
   * Create a work item configuration for an Application Insights component.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/WorkItemConfigs")
  @post
  create(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the Application Insights component resource.
     */
    @path
    resourceName: string,

    /** Work item configuration creation payload */
    @bodyRoot
    body: WorkItemCreateConfiguration,
  ): ArmResponse<WorkItemConfiguration> | never;

  /**
   * Gets default work item configurations that exist for the application
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/DefaultWorkItemConfig")
  @get
  getDefault(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the Application Insights component resource.
     */
    @path
    resourceName: string,
  ): ArmResponse<WorkItemConfiguration> | never;
  /**
   * Delete a work item configuration of an Application Insights component.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/WorkItemConfigs/{workItemConfigId}")
  @delete
  delete(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    /**
     * The name of the Application Insights component resource.
     */
    @path
    resourceName: string,

    /**
     * The unique work item configuration Id. This can be either friendly name of connector as defined in connector configuration
     */
    @path
    workItemConfigId: string,
  ): OkResponse | never;

  /**
   * Gets specified work item configuration for an Application Insights component.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/WorkItemConfigs/{workItemConfigId}")
  @get
  getItem(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    /**
     * The name of the Application Insights component resource.
     */
    @path
    resourceName: string,

    /**
     * The unique work item configuration Id. This can be either friendly name of connector as defined in connector configuration
     */
    @path
    workItemConfigId: string,
  ): ArmResponse<WorkItemConfiguration> | never;

  /**
   * Update a work item configuration for an Application Insights component.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/WorkItemConfigs/{workItemConfigId}")
  @patch(#{ implicitOptionality: true })
  updateItem(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    /**
     * The name of the Application Insights component resource.
     */
    @path
    resourceName: string,

    /**
     * The unique work item configuration Id. This can be either friendly name of connector as defined in connector configuration
     */
    @path
    workItemConfigId: string,

    /**
     * Properties that need to be specified to update a work item configuration for this Application Insights component.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @bodyRoot
    WorkItemConfigurationProperties: WorkItemCreateConfiguration,
  ): ArmResponse<WorkItemConfiguration> | never;
}
