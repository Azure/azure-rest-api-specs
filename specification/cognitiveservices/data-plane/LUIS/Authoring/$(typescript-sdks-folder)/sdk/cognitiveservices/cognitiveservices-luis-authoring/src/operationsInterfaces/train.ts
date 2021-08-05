import {
  TrainTrainVersionOptionalParams,
  TrainTrainVersionResponse,
  TrainGetStatusOptionalParams,
  TrainGetStatusResponse
} from "../models";

/** Interface representing a Train. */
export interface Train {
  /**
   * Sends a training request for a version of a specified LUIS app. This POST request initiates a
   * request asynchronously. To determine whether the training request is successful, submit a GET
   * request to get training status. Note: The application version is not fully trained unless all the
   * models (intents and entities) are trained successfully or are up to date. To verify training
   * success, get the training status at least once after training is complete.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param options The options parameters.
   */
  trainVersion(
    appId: string,
    versionId: string,
    options?: TrainTrainVersionOptionalParams
  ): Promise<TrainTrainVersionResponse>;
  /**
   * Gets the training status of all models (intents and entities) for the specified LUIS app. You must
   * call the train API to train the LUIS app before you call this API to get training status. "appID"
   * specifies the LUIS app ID. "versionId" specifies the version number of the LUIS app. For example,
   * "0.1".
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param options The options parameters.
   */
  getStatus(
    appId: string,
    versionId: string,
    options?: TrainGetStatusOptionalParams
  ): Promise<TrainGetStatusResponse>;
}
