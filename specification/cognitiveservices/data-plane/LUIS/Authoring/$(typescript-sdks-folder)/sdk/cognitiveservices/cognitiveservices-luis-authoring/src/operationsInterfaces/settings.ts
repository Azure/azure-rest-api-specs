import {
  SettingsListOptionalParams,
  SettingsListResponse,
  AppVersionSettingObject,
  SettingsUpdateOptionalParams,
  SettingsUpdateResponse
} from "../models";

/** Interface representing a Settings. */
export interface Settings {
  /**
   * Gets the settings in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param options The options parameters.
   */
  list(
    appId: string,
    versionId: string,
    options?: SettingsListOptionalParams
  ): Promise<SettingsListResponse>;
  /**
   * Updates the settings in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param listOfAppVersionSettingObject A list of the updated application version settings.
   * @param options The options parameters.
   */
  update(
    appId: string,
    versionId: string,
    listOfAppVersionSettingObject: AppVersionSettingObject[],
    options?: SettingsUpdateOptionalParams
  ): Promise<SettingsUpdateResponse>;
}
