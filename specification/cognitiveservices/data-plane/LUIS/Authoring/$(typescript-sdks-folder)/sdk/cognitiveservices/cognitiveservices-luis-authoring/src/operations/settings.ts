import { Settings } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { LuisAuthoringClientContext } from "../luisAuthoringClientContext";
import {
  SettingsListOptionalParams,
  SettingsListResponse,
  AppVersionSettingObject,
  SettingsUpdateOptionalParams,
  SettingsUpdateResponse
} from "../models";

/** Class representing a Settings. */
export class SettingsImpl implements Settings {
  private readonly client: LuisAuthoringClientContext;

  /**
   * Initialize a new instance of the class Settings class.
   * @param client Reference to the service client
   */
  constructor(client: LuisAuthoringClientContext) {
    this.client = client;
  }

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
  ): Promise<SettingsListResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, options },
      listOperationSpec
    );
  }

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
  ): Promise<SettingsUpdateResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, listOfAppVersionSettingObject, options },
      updateOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const listOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/settings",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: {
            type: { name: "Composite", className: "AppVersionSettingObject" }
          }
        }
      }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [Parameters.endpoint, Parameters.appId, Parameters.versionId],
  headerParameters: [Parameters.accept],
  serializer
};
const updateOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/settings",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.OperationStatus
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.listOfAppVersionSettingObject,
  urlParameters: [Parameters.endpoint, Parameters.appId, Parameters.versionId],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
