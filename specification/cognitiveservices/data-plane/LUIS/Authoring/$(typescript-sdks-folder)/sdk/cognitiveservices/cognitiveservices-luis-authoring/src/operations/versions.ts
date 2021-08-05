import { Versions } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { LuisAuthoringClientContext } from "../luisAuthoringClientContext";
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

/** Class representing a Versions. */
export class VersionsImpl implements Versions {
  private readonly client: LuisAuthoringClientContext;

  /**
   * Initialize a new instance of the class Versions class.
   * @param client Reference to the service client
   */
  constructor(client: LuisAuthoringClientContext) {
    this.client = client;
  }

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
  ): Promise<VersionsCloneResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, versionCloneObject, options },
      cloneOperationSpec
    );
  }

  /**
   * Gets a list of versions for this application ID.
   * @param appId The application ID.
   * @param options The options parameters.
   */
  list(
    appId: string,
    options?: VersionsListOptionalParams
  ): Promise<VersionsListResponse> {
    return this.client.sendOperationRequest(
      { appId, options },
      listOperationSpec
    );
  }

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
  ): Promise<VersionsGetResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, options },
      getOperationSpec
    );
  }

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
  ): Promise<VersionsUpdateResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, versionUpdateObject, options },
      updateOperationSpec
    );
  }

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
  ): Promise<VersionsDeleteResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, options },
      deleteOperationSpec
    );
  }

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
  ): Promise<VersionsExportResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, options },
      exportOperationSpec
    );
  }

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
  ): Promise<VersionsImportResponse> {
    return this.client.sendOperationRequest(
      { appId, luisApp, options },
      importOperationSpec
    );
  }

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
  ): Promise<VersionsDeleteUnlabelledUtteranceResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, utterance, options },
      deleteUnlabelledUtteranceOperationSpec
    );
  }

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
  ): Promise<VersionsImportV2AppResponse> {
    return this.client.sendOperationRequest(
      { appId, luisAppV2, options },
      importV2AppOperationSpec
    );
  }

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
  ): Promise<VersionsImportLuFormatResponse> {
    return this.client.sendOperationRequest(
      { appId, luisAppLu, options },
      importLuFormatOperationSpec
    );
  }

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
  ): Promise<VersionsExportLuFormatResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, options },
      exportLuFormatOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const cloneOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/clone",
  httpMethod: "POST",
  responses: {
    201: {
      bodyMapper: { type: { name: "String" } }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.versionCloneObject,
  urlParameters: [Parameters.endpoint, Parameters.appId, Parameters.versionId],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: { type: { name: "Composite", className: "VersionInfo" } }
        }
      }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  queryParameters: [Parameters.skip, Parameters.take],
  urlParameters: [Parameters.endpoint, Parameters.appId],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.VersionInfo
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
  path: "/apps/{appId}/versions/{versionId}/",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.OperationStatus
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.versionUpdateObject,
  urlParameters: [Parameters.endpoint, Parameters.appId, Parameters.versionId],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const deleteOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/",
  httpMethod: "DELETE",
  responses: {
    200: {
      bodyMapper: Mappers.OperationStatus
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [Parameters.endpoint, Parameters.appId, Parameters.versionId],
  headerParameters: [Parameters.accept],
  serializer
};
const exportOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/export",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.LuisApp
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [Parameters.endpoint, Parameters.appId, Parameters.versionId],
  headerParameters: [Parameters.accept],
  serializer
};
const importOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/import",
  httpMethod: "POST",
  responses: {
    201: {
      bodyMapper: { type: { name: "String" } }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.luisApp,
  queryParameters: [Parameters.versionId1],
  urlParameters: [Parameters.endpoint, Parameters.appId],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const deleteUnlabelledUtteranceOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/suggest",
  httpMethod: "DELETE",
  responses: {
    200: {
      bodyMapper: Mappers.OperationStatus
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.utterance,
  urlParameters: [Parameters.endpoint, Parameters.appId, Parameters.versionId],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const importV2AppOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/import",
  httpMethod: "POST",
  responses: {
    201: {
      bodyMapper: { type: { name: "String" } }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.luisAppV2,
  queryParameters: [Parameters.versionId1],
  urlParameters: [Parameters.endpoint, Parameters.appId],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const importLuFormatOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/import",
  httpMethod: "POST",
  responses: {
    201: {
      bodyMapper: { type: { name: "String" } }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.luisAppLu,
  queryParameters: [Parameters.versionId1],
  urlParameters: [Parameters.endpoint, Parameters.appId],
  headerParameters: [Parameters.contentType1, Parameters.accept3],
  mediaType: "text",
  serializer
};
const exportLuFormatOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/export",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: { type: { name: "Stream" }, serializedName: "parsedResponse" }
    },
    default: {}
  },
  queryParameters: [Parameters.format],
  urlParameters: [Parameters.endpoint, Parameters.appId, Parameters.versionId],
  headerParameters: [Parameters.accept1],
  serializer
};
