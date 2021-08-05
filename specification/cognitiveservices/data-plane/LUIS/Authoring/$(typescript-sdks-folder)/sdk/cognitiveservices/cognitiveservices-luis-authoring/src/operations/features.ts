import { Features } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { LuisAuthoringClientContext } from "../luisAuthoringClientContext";
import {
  PhraselistCreateObject,
  FeaturesAddPhraseListOptionalParams,
  FeaturesAddPhraseListResponse,
  FeaturesListPhraseListsOptionalParams,
  FeaturesListPhraseListsResponse,
  FeaturesListOptionalParams,
  FeaturesListResponse,
  FeaturesGetPhraseListOptionalParams,
  FeaturesGetPhraseListResponse,
  FeaturesUpdatePhraseListOptionalParams,
  FeaturesUpdatePhraseListResponse,
  FeaturesDeletePhraseListOptionalParams,
  FeaturesDeletePhraseListResponse,
  ModelFeatureInformation,
  FeaturesAddIntentFeatureOptionalParams,
  FeaturesAddIntentFeatureResponse,
  FeaturesAddEntityFeatureOptionalParams,
  FeaturesAddEntityFeatureResponse
} from "../models";

/** Class representing a Features. */
export class FeaturesImpl implements Features {
  private readonly client: LuisAuthoringClientContext;

  /**
   * Initialize a new instance of the class Features class.
   * @param client Reference to the service client
   */
  constructor(client: LuisAuthoringClientContext) {
    this.client = client;
  }

  /**
   * Creates a new phraselist feature in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param phraselistCreateObject A Phraselist object containing Name, comma-separated Phrases and the
   *                               isExchangeable boolean. Default value for isExchangeable is true.
   * @param options The options parameters.
   */
  addPhraseList(
    appId: string,
    versionId: string,
    phraselistCreateObject: PhraselistCreateObject,
    options?: FeaturesAddPhraseListOptionalParams
  ): Promise<FeaturesAddPhraseListResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, phraselistCreateObject, options },
      addPhraseListOperationSpec
    );
  }

  /**
   * Gets all the phraselist features in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param options The options parameters.
   */
  listPhraseLists(
    appId: string,
    versionId: string,
    options?: FeaturesListPhraseListsOptionalParams
  ): Promise<FeaturesListPhraseListsResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, options },
      listPhraseListsOperationSpec
    );
  }

  /**
   * Gets all the extraction phraselist and pattern features in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param options The options parameters.
   */
  list(
    appId: string,
    versionId: string,
    options?: FeaturesListOptionalParams
  ): Promise<FeaturesListResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, options },
      listOperationSpec
    );
  }

  /**
   * Gets phraselist feature info in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param phraselistId The ID of the feature to be retrieved.
   * @param options The options parameters.
   */
  getPhraseList(
    appId: string,
    versionId: string,
    phraselistId: number,
    options?: FeaturesGetPhraseListOptionalParams
  ): Promise<FeaturesGetPhraseListResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, phraselistId, options },
      getPhraseListOperationSpec
    );
  }

  /**
   * Updates the phrases, the state and the name of the phraselist feature in a version of the
   * application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param phraselistId The ID of the feature to be updated.
   * @param options The options parameters.
   */
  updatePhraseList(
    appId: string,
    versionId: string,
    phraselistId: number,
    options?: FeaturesUpdatePhraseListOptionalParams
  ): Promise<FeaturesUpdatePhraseListResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, phraselistId, options },
      updatePhraseListOperationSpec
    );
  }

  /**
   * Deletes a phraselist feature from a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param phraselistId The ID of the feature to be deleted.
   * @param options The options parameters.
   */
  deletePhraseList(
    appId: string,
    versionId: string,
    phraselistId: number,
    options?: FeaturesDeletePhraseListOptionalParams
  ): Promise<FeaturesDeletePhraseListResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, phraselistId, options },
      deletePhraseListOperationSpec
    );
  }

  /**
   * Adds a new feature relation to be used by the intent in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param intentId The intent classifier ID.
   * @param featureRelationCreateObject A Feature relation information object.
   * @param options The options parameters.
   */
  addIntentFeature(
    appId: string,
    versionId: string,
    intentId: string,
    featureRelationCreateObject: ModelFeatureInformation,
    options?: FeaturesAddIntentFeatureOptionalParams
  ): Promise<FeaturesAddIntentFeatureResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, intentId, featureRelationCreateObject, options },
      addIntentFeatureOperationSpec
    );
  }

  /**
   * Adds a new feature relation to be used by the entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId The entity extractor ID.
   * @param featureRelationCreateObject A Feature relation information object.
   * @param options The options parameters.
   */
  addEntityFeature(
    appId: string,
    versionId: string,
    entityId: string,
    featureRelationCreateObject: ModelFeatureInformation,
    options?: FeaturesAddEntityFeatureOptionalParams
  ): Promise<FeaturesAddEntityFeatureResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, featureRelationCreateObject, options },
      addEntityFeatureOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const addPhraseListOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/phraselists",
  httpMethod: "POST",
  responses: {
    201: {
      bodyMapper: { type: { name: "Number" } }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.phraselistCreateObject,
  urlParameters: [Parameters.endpoint, Parameters.appId, Parameters.versionId],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const listPhraseListsOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/phraselists",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: {
            type: { name: "Composite", className: "PhraseListFeatureInfo" }
          }
        }
      }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  queryParameters: [Parameters.skip, Parameters.take],
  urlParameters: [Parameters.endpoint, Parameters.appId, Parameters.versionId],
  headerParameters: [Parameters.accept],
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/features",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.FeaturesResponseObject
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  queryParameters: [Parameters.skip, Parameters.take],
  urlParameters: [Parameters.endpoint, Parameters.appId, Parameters.versionId],
  headerParameters: [Parameters.accept],
  serializer
};
const getPhraseListOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/phraselists/{phraselistId}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.PhraseListFeatureInfo
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.phraselistId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const updatePhraseListOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/phraselists/{phraselistId}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.OperationStatus
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.phraselistUpdateObject,
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.phraselistId
  ],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const deletePhraseListOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/phraselists/{phraselistId}",
  httpMethod: "DELETE",
  responses: {
    200: {
      bodyMapper: Mappers.OperationStatus
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.phraselistId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const addIntentFeatureOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/intents/{intentId}/features",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.OperationStatus
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.featureRelationCreateObject,
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.intentId
  ],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const addEntityFeatureOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/entities/{entityId}/features",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.OperationStatus
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.featureRelationCreateObject,
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.entityId
  ],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
