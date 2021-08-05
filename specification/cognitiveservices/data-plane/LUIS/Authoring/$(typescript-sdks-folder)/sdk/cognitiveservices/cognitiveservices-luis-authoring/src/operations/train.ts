import { Train } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { LuisAuthoringClientContext } from "../luisAuthoringClientContext";
import {
  TrainTrainVersionOptionalParams,
  TrainTrainVersionResponse,
  TrainGetStatusOptionalParams,
  TrainGetStatusResponse
} from "../models";

/** Class representing a Train. */
export class TrainImpl implements Train {
  private readonly client: LuisAuthoringClientContext;

  /**
   * Initialize a new instance of the class Train class.
   * @param client Reference to the service client
   */
  constructor(client: LuisAuthoringClientContext) {
    this.client = client;
  }

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
  ): Promise<TrainTrainVersionResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, options },
      trainVersionOperationSpec
    );
  }

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
  ): Promise<TrainGetStatusResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, options },
      getStatusOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const trainVersionOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/train",
  httpMethod: "POST",
  responses: {
    202: {
      bodyMapper: Mappers.EnqueueTrainingResponse
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  queryParameters: [Parameters.mode],
  urlParameters: [Parameters.endpoint, Parameters.appId, Parameters.versionId],
  headerParameters: [Parameters.accept],
  serializer
};
const getStatusOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/train",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: {
            type: { name: "Composite", className: "ModelTrainingInfo" }
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
