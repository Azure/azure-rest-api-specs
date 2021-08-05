import {
  ApplicationCreateObject,
  AppsAddOptionalParams,
  AppsAddResponse,
  AppsListOptionalParams,
  AppsListResponse,
  LuisApp,
  AppsImportOptionalParams,
  AppsImportResponse,
  AppsListCortanaEndpointsOptionalParams,
  AppsListCortanaEndpointsResponse,
  AppsListDomainsOptionalParams,
  AppsListDomainsResponse,
  AppsListUsageScenariosOptionalParams,
  AppsListUsageScenariosResponse,
  AppsListSupportedCulturesOptionalParams,
  AppsListSupportedCulturesResponse,
  AppsDownloadQueryLogsOptionalParams,
  AppsDownloadQueryLogsResponse,
  AppsGetOptionalParams,
  AppsGetResponse,
  ApplicationUpdateObject,
  AppsUpdateOptionalParams,
  AppsUpdateResponse,
  AppsDeleteOptionalParams,
  AppsDeleteResponse,
  ApplicationPublishObject,
  AppsPublishOptionalParams,
  AppsPublishResponse,
  AppsGetSettingsOptionalParams,
  AppsGetSettingsResponse,
  ApplicationSettingUpdateObject,
  AppsUpdateSettingsOptionalParams,
  AppsUpdateSettingsResponse,
  AppsGetPublishSettingsOptionalParams,
  AppsGetPublishSettingsResponse,
  PublishSettingUpdateObject,
  AppsUpdatePublishSettingsOptionalParams,
  AppsUpdatePublishSettingsResponse,
  AppsListEndpointsOptionalParams,
  AppsListEndpointsResponse,
  AppsListAvailableCustomPrebuiltDomainsOptionalParams,
  AppsListAvailableCustomPrebuiltDomainsResponse,
  PrebuiltDomainCreateObject,
  AppsAddCustomPrebuiltDomainOptionalParams,
  AppsAddCustomPrebuiltDomainResponse,
  AppsListAvailableCustomPrebuiltDomainsForCultureOptionalParams,
  AppsListAvailableCustomPrebuiltDomainsForCultureResponse,
  AppsPackagePublishedApplicationAsGzipOptionalParams,
  AppsPackagePublishedApplicationAsGzipResponse,
  AppsPackageTrainedApplicationAsGzipOptionalParams,
  AppsPackageTrainedApplicationAsGzipResponse,
  LuisAppV2,
  AppsImportV2AppOptionalParams,
  AppsImportV2AppResponse,
  AppsImportLuFormatOptionalParams,
  AppsImportLuFormatResponse
} from "../models";

/** Interface representing a Apps. */
export interface Apps {
  /**
   * Creates a new LUIS app.
   * @param applicationCreateObject An application containing Name, Description (optional), Culture,
   *                                Usage Scenario (optional), Domain (optional) and initial version ID (optional) of the application.
   *                                Default value for the version ID is "0.1". Note: the culture cannot be changed after the app is
   *                                created.
   * @param options The options parameters.
   */
  add(
    applicationCreateObject: ApplicationCreateObject,
    options?: AppsAddOptionalParams
  ): Promise<AppsAddResponse>;
  /**
   * Lists all of the user's applications.
   * @param options The options parameters.
   */
  list(options?: AppsListOptionalParams): Promise<AppsListResponse>;
  /**
   * Imports an application to LUIS, the application's structure is included in the request body.
   * @param luisApp A LUIS application structure.
   * @param options The options parameters.
   */
  import(
    luisApp: LuisApp,
    options?: AppsImportOptionalParams
  ): Promise<AppsImportResponse>;
  /**
   * Gets the endpoint URLs for the prebuilt Cortana applications.
   * @param options The options parameters.
   */
  listCortanaEndpoints(
    options?: AppsListCortanaEndpointsOptionalParams
  ): Promise<AppsListCortanaEndpointsResponse>;
  /**
   * Gets the available application domains.
   * @param options The options parameters.
   */
  listDomains(
    options?: AppsListDomainsOptionalParams
  ): Promise<AppsListDomainsResponse>;
  /**
   * Gets the application available usage scenarios.
   * @param options The options parameters.
   */
  listUsageScenarios(
    options?: AppsListUsageScenariosOptionalParams
  ): Promise<AppsListUsageScenariosResponse>;
  /**
   * Gets a list of supported cultures. Cultures are equivalent to the written language and locale. For
   * example,"en-us" represents the U.S. variation of English.
   * @param options The options parameters.
   */
  listSupportedCultures(
    options?: AppsListSupportedCulturesOptionalParams
  ): Promise<AppsListSupportedCulturesResponse>;
  /**
   * Gets the logs of the past month's endpoint queries for the application.
   * @param appId The application ID.
   * @param options The options parameters.
   */
  downloadQueryLogs(
    appId: string,
    options?: AppsDownloadQueryLogsOptionalParams
  ): Promise<AppsDownloadQueryLogsResponse>;
  /**
   * Gets the application info.
   * @param appId The application ID.
   * @param options The options parameters.
   */
  get(appId: string, options?: AppsGetOptionalParams): Promise<AppsGetResponse>;
  /**
   * Updates the name or description of the application.
   * @param appId The application ID.
   * @param applicationUpdateObject A model containing Name and Description of the application.
   * @param options The options parameters.
   */
  update(
    appId: string,
    applicationUpdateObject: ApplicationUpdateObject,
    options?: AppsUpdateOptionalParams
  ): Promise<AppsUpdateResponse>;
  /**
   * Deletes an application.
   * @param appId The application ID.
   * @param options The options parameters.
   */
  delete(
    appId: string,
    options?: AppsDeleteOptionalParams
  ): Promise<AppsDeleteResponse>;
  /**
   * Publishes a specific version of the application.
   * @param appId The application ID.
   * @param applicationPublishObject The application publish object. The region is the target region that
   *                                 the application is published to.
   * @param options The options parameters.
   */
  publish(
    appId: string,
    applicationPublishObject: ApplicationPublishObject,
    options?: AppsPublishOptionalParams
  ): Promise<AppsPublishResponse>;
  /**
   * Get the application settings including 'UseAllTrainingData'.
   * @param appId The application ID.
   * @param options The options parameters.
   */
  getSettings(
    appId: string,
    options?: AppsGetSettingsOptionalParams
  ): Promise<AppsGetSettingsResponse>;
  /**
   * Updates the application settings including 'UseAllTrainingData'.
   * @param appId The application ID.
   * @param applicationSettingUpdateObject An object containing the new application settings.
   * @param options The options parameters.
   */
  updateSettings(
    appId: string,
    applicationSettingUpdateObject: ApplicationSettingUpdateObject,
    options?: AppsUpdateSettingsOptionalParams
  ): Promise<AppsUpdateSettingsResponse>;
  /**
   * Get the application publish settings including 'UseAllTrainingData'.
   * @param appId The application ID.
   * @param options The options parameters.
   */
  getPublishSettings(
    appId: string,
    options?: AppsGetPublishSettingsOptionalParams
  ): Promise<AppsGetPublishSettingsResponse>;
  /**
   * Updates the application publish settings including 'UseAllTrainingData'.
   * @param appId The application ID.
   * @param publishSettingUpdateObject An object containing the new publish application settings.
   * @param options The options parameters.
   */
  updatePublishSettings(
    appId: string,
    publishSettingUpdateObject: PublishSettingUpdateObject,
    options?: AppsUpdatePublishSettingsOptionalParams
  ): Promise<AppsUpdatePublishSettingsResponse>;
  /**
   * Returns the available endpoint deployment regions and URLs.
   * @param appId The application ID.
   * @param options The options parameters.
   */
  listEndpoints(
    appId: string,
    options?: AppsListEndpointsOptionalParams
  ): Promise<AppsListEndpointsResponse>;
  /**
   * Gets all the available custom prebuilt domains for all cultures.
   * @param options The options parameters.
   */
  listAvailableCustomPrebuiltDomains(
    options?: AppsListAvailableCustomPrebuiltDomainsOptionalParams
  ): Promise<AppsListAvailableCustomPrebuiltDomainsResponse>;
  /**
   * Adds a prebuilt domain along with its intent and entity models as a new application.
   * @param prebuiltDomainCreateObject A prebuilt domain create object containing the name and culture of
   *                                   the domain.
   * @param options The options parameters.
   */
  addCustomPrebuiltDomain(
    prebuiltDomainCreateObject: PrebuiltDomainCreateObject,
    options?: AppsAddCustomPrebuiltDomainOptionalParams
  ): Promise<AppsAddCustomPrebuiltDomainResponse>;
  /**
   * Gets all the available prebuilt domains for a specific culture.
   * @param culture Culture.
   * @param options The options parameters.
   */
  listAvailableCustomPrebuiltDomainsForCulture(
    culture: string,
    options?: AppsListAvailableCustomPrebuiltDomainsForCultureOptionalParams
  ): Promise<AppsListAvailableCustomPrebuiltDomainsForCultureResponse>;
  /**
   * Packages a published LUIS application as a GZip file to be used in the LUIS container.
   * @param appId The application ID.
   * @param slotName The publishing slot name.
   * @param options The options parameters.
   */
  packagePublishedApplicationAsGzip(
    appId: string,
    slotName: string,
    options?: AppsPackagePublishedApplicationAsGzipOptionalParams
  ): Promise<AppsPackagePublishedApplicationAsGzipResponse>;
  /**
   * Packages trained LUIS application as GZip file to be used in the LUIS container.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param options The options parameters.
   */
  packageTrainedApplicationAsGzip(
    appId: string,
    versionId: string,
    options?: AppsPackageTrainedApplicationAsGzipOptionalParams
  ): Promise<AppsPackageTrainedApplicationAsGzipResponse>;
  /**
   * Imports an application to LUIS, the application's structure is included in the request body.
   * @param luisAppV2 A LUIS application structure.
   * @param options The options parameters.
   */
  importV2App(
    luisAppV2: LuisAppV2,
    options?: AppsImportV2AppOptionalParams
  ): Promise<AppsImportV2AppResponse>;
  /**
   * Imports an application to LUIS, the application's structure is included in the request body.
   * @param luisAppLu A LUIS application structure.
   * @param options The options parameters.
   */
  importLuFormat(
    luisAppLu: string,
    options?: AppsImportLuFormatOptionalParams
  ): Promise<AppsImportLuFormatResponse>;
}
