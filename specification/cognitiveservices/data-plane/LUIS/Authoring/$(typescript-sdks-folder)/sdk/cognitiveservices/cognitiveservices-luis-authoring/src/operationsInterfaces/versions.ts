import {
  TaskUpdateObject,
  VersionsCloneOptionalParams,
  VersionsCloneResponse,
  VersionsListOptionalParams,
  VersionsListResponse,
  VersionsGetOptionalParams,
  VersionsGetResponse,
  VersionsUpdateOptionalParams,
  VersionsUpdateResponse,
  VersionsDeleteOptionalParams,
  VersionsDeleteResponse,
  VersionsExportOptionalParams,
  VersionsExportResponse,
  LuisApp,
  VersionsImportOptionalParams,
  VersionsImportResponse,
  VersionsDeleteUnlabelledUtteranceOptionalParams,
  VersionsDeleteUnlabelledUtteranceResponse,
  LuisAppV2,
  VersionsImportV2AppOptionalParams,
  VersionsImportV2AppResponse,
  VersionsImportLuFormatOptionalParams,
  VersionsImportLuFormatResponse,
  VersionsExportLuFormatOptionalParams,
  VersionsExportLuFormatResponse
} from "../models";

/** Interface representing a Versions. */
export interface Versions {
  /**
   * Creates a new version from the selected version.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param versionCloneObject A model containing the new version ID.
   * @param options The options parameters.
   */
  clone(
    appId: string,
    versionId: string,
    versionCloneObject: TaskUpdateObject,
    options?: VersionsCloneOptionalParams
  ): Promise<VersionsCloneResponse>;
  /**
   * Gets a list of versions for this application ID.
   * @param appId The application ID.
   * @param options The options parameters.
   */
  list(
    appId: string,
    options?: VersionsListOptionalParams
  ): Promise<VersionsListResponse>;
  /**
   * Gets the version information such as date created, last modified date, endpoint URL, count of
   * intents and entities, training and publishing status.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param options The options parameters.
   */
  get(
    appId: string,
    versionId: string,
    options?: VersionsGetOptionalParams
  ): Promise<VersionsGetResponse>;
  /**
   * Updates the name or description of the application version.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param versionUpdateObject A model containing Name and Description of the application.
   * @param options The options parameters.
   */
  update(
    appId: string,
    versionId: string,
    versionUpdateObject: TaskUpdateObject,
    options?: VersionsUpdateOptionalParams
  ): Promise<VersionsUpdateResponse>;
  /**
   * Deletes an application version.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param options The options parameters.
   */
  delete(
    appId: string,
    versionId: string,
    options?: VersionsDeleteOptionalParams
  ): Promise<VersionsDeleteResponse>;
  /**
   * Exports a LUIS application to JSON format.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param options The options parameters.
   */
  export(
    appId: string,
    versionId: string,
    options?: VersionsExportOptionalParams
  ): Promise<VersionsExportResponse>;
  /**
   * Imports a new version into a LUIS application.
   * @param appId The application ID.
   * @param luisApp A LUIS application structure.
   * @param options The options parameters.
   */
  import(
    appId: string,
    luisApp: LuisApp,
    options?: VersionsImportOptionalParams
  ): Promise<VersionsImportResponse>;
  /**
   * Deleted an unlabelled utterance in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param utterance The utterance text to delete.
   * @param options The options parameters.
   */
  deleteUnlabelledUtterance(
    appId: string,
    versionId: string,
    utterance: string,
    options?: VersionsDeleteUnlabelledUtteranceOptionalParams
  ): Promise<VersionsDeleteUnlabelledUtteranceResponse>;
  /**
   * Imports a new version into a LUIS application.
   * @param appId The application ID.
   * @param luisAppV2 A LUIS application structure.
   * @param options The options parameters.
   */
  importV2App(
    appId: string,
    luisAppV2: LuisAppV2,
    options?: VersionsImportV2AppOptionalParams
  ): Promise<VersionsImportV2AppResponse>;
  /**
   * Imports a new version into a LUIS application.
   * @param appId The application ID.
   * @param luisAppLu An LU representing the LUIS application structure.
   * @param options The options parameters.
   */
  importLuFormat(
    appId: string,
    luisAppLu: string,
    options?: VersionsImportLuFormatOptionalParams
  ): Promise<VersionsImportLuFormatResponse>;
  /**
   * Exports a LUIS application to text format.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param options The options parameters.
   */
  exportLuFormat(
    appId: string,
    versionId: string,
    options?: VersionsExportLuFormatOptionalParams
  ): Promise<VersionsExportLuFormatResponse>;
}
