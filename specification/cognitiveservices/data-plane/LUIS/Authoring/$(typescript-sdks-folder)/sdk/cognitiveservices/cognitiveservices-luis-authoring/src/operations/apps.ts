import { Apps } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { LuisAuthoringClientContext } from "../luisAuthoringClientContext";
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

/** Class representing a Apps. */
export class AppsImpl implements Apps {
  private readonly client: LuisAuthoringClientContext;

  /**
   * Initialize a new instance of the class Apps class.
   * @param client Reference to the service client
   */
  constructor(client: LuisAuthoringClientContext) {
    this.client = client;
  }

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
  ): Promise<AppsAddResponse> {
    return this.client.sendOperationRequest(
      { applicationCreateObject, options },
      addOperationSpec
    );
  }

  /**
   * Lists all of the user's applications.
   * @param options The options parameters.
   */
  list(options?: AppsListOptionalParams): Promise<AppsListResponse> {
    return this.client.sendOperationRequest({ options }, listOperationSpec);
  }

  /**
   * Imports an application to LUIS, the application's structure is included in the request body.
   * @param luisApp A LUIS application structure.
   * @param options The options parameters.
   */
  import(
    luisApp: LuisApp,
    options?: AppsImportOptionalParams
  ): Promise<AppsImportResponse> {
    return this.client.sendOperationRequest(
      { luisApp, options },
      importOperationSpec
    );
  }

  /**
   * Gets the endpoint URLs for the prebuilt Cortana applications.
   * @param options The options parameters.
   */
  listCortanaEndpoints(
    options?: AppsListCortanaEndpointsOptionalParams
  ): Promise<AppsListCortanaEndpointsResponse> {
    return this.client.sendOperationRequest(
      { options },
      listCortanaEndpointsOperationSpec
    );
  }

  /**
   * Gets the available application domains.
   * @param options The options parameters.
   */
  listDomains(
    options?: AppsListDomainsOptionalParams
  ): Promise<AppsListDomainsResponse> {
    return this.client.sendOperationRequest(
      { options },
      listDomainsOperationSpec
    );
  }

  /**
   * Gets the application available usage scenarios.
   * @param options The options parameters.
   */
  listUsageScenarios(
    options?: AppsListUsageScenariosOptionalParams
  ): Promise<AppsListUsageScenariosResponse> {
    return this.client.sendOperationRequest(
      { options },
      listUsageScenariosOperationSpec
    );
  }

  /**
   * Gets a list of supported cultures. Cultures are equivalent to the written language and locale. For
   * example,"en-us" represents the U.S. variation of English.
   * @param options The options parameters.
   */
  listSupportedCultures(
    options?: AppsListSupportedCulturesOptionalParams
  ): Promise<AppsListSupportedCulturesResponse> {
    return this.client.sendOperationRequest(
      { options },
      listSupportedCulturesOperationSpec
    );
  }

  /**
   * Gets the logs of the past month's endpoint queries for the application.
   * @param appId The application ID.
   * @param options The options parameters.
   */
  downloadQueryLogs(
    appId: string,
    options?: AppsDownloadQueryLogsOptionalParams
  ): Promise<AppsDownloadQueryLogsResponse> {
    return this.client.sendOperationRequest(
      { appId, options },
      downloadQueryLogsOperationSpec
    );
  }

  /**
   * Gets the application info.
   * @param appId The application ID.
   * @param options The options parameters.
   */
  get(
    appId: string,
    options?: AppsGetOptionalParams
  ): Promise<AppsGetResponse> {
    return this.client.sendOperationRequest(
      { appId, options },
      getOperationSpec
    );
  }

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
  ): Promise<AppsUpdateResponse> {
    return this.client.sendOperationRequest(
      { appId, applicationUpdateObject, options },
      updateOperationSpec
    );
  }

  /**
   * Deletes an application.
   * @param appId The application ID.
   * @param options The options parameters.
   */
  delete(
    appId: string,
    options?: AppsDeleteOptionalParams
  ): Promise<AppsDeleteResponse> {
    return this.client.sendOperationRequest(
      { appId, options },
      deleteOperationSpec
    );
  }

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
  ): Promise<AppsPublishResponse> {
    return this.client.sendOperationRequest(
      { appId, applicationPublishObject, options },
      publishOperationSpec
    );
  }

  /**
   * Get the application settings including 'UseAllTrainingData'.
   * @param appId The application ID.
   * @param options The options parameters.
   */
  getSettings(
    appId: string,
    options?: AppsGetSettingsOptionalParams
  ): Promise<AppsGetSettingsResponse> {
    return this.client.sendOperationRequest(
      { appId, options },
      getSettingsOperationSpec
    );
  }

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
  ): Promise<AppsUpdateSettingsResponse> {
    return this.client.sendOperationRequest(
      { appId, applicationSettingUpdateObject, options },
      updateSettingsOperationSpec
    );
  }

  /**
   * Get the application publish settings including 'UseAllTrainingData'.
   * @param appId The application ID.
   * @param options The options parameters.
   */
  getPublishSettings(
    appId: string,
    options?: AppsGetPublishSettingsOptionalParams
  ): Promise<AppsGetPublishSettingsResponse> {
    return this.client.sendOperationRequest(
      { appId, options },
      getPublishSettingsOperationSpec
    );
  }

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
  ): Promise<AppsUpdatePublishSettingsResponse> {
    return this.client.sendOperationRequest(
      { appId, publishSettingUpdateObject, options },
      updatePublishSettingsOperationSpec
    );
  }

  /**
   * Returns the available endpoint deployment regions and URLs.
   * @param appId The application ID.
   * @param options The options parameters.
   */
  listEndpoints(
    appId: string,
    options?: AppsListEndpointsOptionalParams
  ): Promise<AppsListEndpointsResponse> {
    return this.client.sendOperationRequest(
      { appId, options },
      listEndpointsOperationSpec
    );
  }

  /**
   * Gets all the available custom prebuilt domains for all cultures.
   * @param options The options parameters.
   */
  listAvailableCustomPrebuiltDomains(
    options?: AppsListAvailableCustomPrebuiltDomainsOptionalParams
  ): Promise<AppsListAvailableCustomPrebuiltDomainsResponse> {
    return this.client.sendOperationRequest(
      { options },
      listAvailableCustomPrebuiltDomainsOperationSpec
    );
  }

  /**
   * Adds a prebuilt domain along with its intent and entity models as a new application.
   * @param prebuiltDomainCreateObject A prebuilt domain create object containing the name and culture of
   *                                   the domain.
   * @param options The options parameters.
   */
  addCustomPrebuiltDomain(
    prebuiltDomainCreateObject: PrebuiltDomainCreateObject,
    options?: AppsAddCustomPrebuiltDomainOptionalParams
  ): Promise<AppsAddCustomPrebuiltDomainResponse> {
    return this.client.sendOperationRequest(
      { prebuiltDomainCreateObject, options },
      addCustomPrebuiltDomainOperationSpec
    );
  }

  /**
   * Gets all the available prebuilt domains for a specific culture.
   * @param culture Culture.
   * @param options The options parameters.
   */
  listAvailableCustomPrebuiltDomainsForCulture(
    culture: string,
    options?: AppsListAvailableCustomPrebuiltDomainsForCultureOptionalParams
  ): Promise<AppsListAvailableCustomPrebuiltDomainsForCultureResponse> {
    return this.client.sendOperationRequest(
      { culture, options },
      listAvailableCustomPrebuiltDomainsForCultureOperationSpec
    );
  }

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
  ): Promise<AppsPackagePublishedApplicationAsGzipResponse> {
    return this.client.sendOperationRequest(
      { appId, slotName, options },
      packagePublishedApplicationAsGzipOperationSpec
    );
  }

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
  ): Promise<AppsPackageTrainedApplicationAsGzipResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, options },
      packageTrainedApplicationAsGzipOperationSpec
    );
  }

  /**
   * Imports an application to LUIS, the application's structure is included in the request body.
   * @param luisAppV2 A LUIS application structure.
   * @param options The options parameters.
   */
  importV2App(
    luisAppV2: LuisAppV2,
    options?: AppsImportV2AppOptionalParams
  ): Promise<AppsImportV2AppResponse> {
    return this.client.sendOperationRequest(
      { luisAppV2, options },
      importV2AppOperationSpec
    );
  }

  /**
   * Imports an application to LUIS, the application's structure is included in the request body.
   * @param luisAppLu A LUIS application structure.
   * @param options The options parameters.
   */
  importLuFormat(
    luisAppLu: string,
    options?: AppsImportLuFormatOptionalParams
  ): Promise<AppsImportLuFormatResponse> {
    return this.client.sendOperationRequest(
      { luisAppLu, options },
      importLuFormatOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const addOperationSpec: coreClient.OperationSpec = {
  path: "/apps/",
  httpMethod: "POST",
  responses: {
    201: {
      bodyMapper: { type: { name: "Uuid" } }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.applicationCreateObject,
  urlParameters: [Parameters.endpoint],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path: "/apps/",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: {
            type: { name: "Composite", className: "ApplicationInfoResponse" }
          }
        }
      }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  queryParameters: [Parameters.skip, Parameters.take],
  urlParameters: [Parameters.endpoint],
  headerParameters: [Parameters.accept],
  serializer
};
const importOperationSpec: coreClient.OperationSpec = {
  path: "/apps/import",
  httpMethod: "POST",
  responses: {
    201: {
      bodyMapper: { type: { name: "Uuid" } }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.luisApp,
  queryParameters: [Parameters.appName],
  urlParameters: [Parameters.endpoint],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const listCortanaEndpointsOperationSpec: coreClient.OperationSpec = {
  path: "/apps/assistants",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.PersonalAssistantsResponse
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [Parameters.endpoint],
  headerParameters: [Parameters.accept],
  serializer
};
const listDomainsOperationSpec: coreClient.OperationSpec = {
  path: "/apps/domains",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: { name: "Sequence", element: { type: { name: "String" } } }
      }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [Parameters.endpoint],
  headerParameters: [Parameters.accept],
  serializer
};
const listUsageScenariosOperationSpec: coreClient.OperationSpec = {
  path: "/apps/usagescenarios",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: { name: "Sequence", element: { type: { name: "String" } } }
      }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [Parameters.endpoint],
  headerParameters: [Parameters.accept],
  serializer
};
const listSupportedCulturesOperationSpec: coreClient.OperationSpec = {
  path: "/apps/cultures",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: {
            type: { name: "Composite", className: "AvailableCulture" }
          }
        }
      }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [Parameters.endpoint],
  headerParameters: [Parameters.accept],
  serializer
};
const downloadQueryLogsOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/querylogs",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: { type: { name: "Stream" }, serializedName: "parsedResponse" }
    },
    default: {}
  },
  urlParameters: [Parameters.endpoint, Parameters.appId],
  headerParameters: [Parameters.accept1],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ApplicationInfoResponse
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [Parameters.endpoint, Parameters.appId],
  headerParameters: [Parameters.accept],
  serializer
};
const updateOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.OperationStatus
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.applicationUpdateObject,
  urlParameters: [Parameters.endpoint, Parameters.appId],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const deleteOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}",
  httpMethod: "DELETE",
  responses: {
    200: {
      bodyMapper: Mappers.OperationStatus
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  queryParameters: [Parameters.force],
  urlParameters: [Parameters.endpoint, Parameters.appId],
  headerParameters: [Parameters.accept],
  serializer
};
const publishOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/publish",
  httpMethod: "POST",
  responses: {
    201: {
      bodyMapper: Mappers.ProductionOrStagingEndpointInfo
    },
    207: {
      bodyMapper: Mappers.ProductionOrStagingEndpointInfo
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.applicationPublishObject,
  urlParameters: [Parameters.endpoint, Parameters.appId],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const getSettingsOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/settings",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ApplicationSettings
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [Parameters.endpoint, Parameters.appId],
  headerParameters: [Parameters.accept],
  serializer
};
const updateSettingsOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/settings",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.OperationStatus
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.applicationSettingUpdateObject,
  urlParameters: [Parameters.endpoint, Parameters.appId],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const getPublishSettingsOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/publishsettings",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.PublishSettings
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [Parameters.endpoint, Parameters.appId],
  headerParameters: [Parameters.accept],
  serializer
};
const updatePublishSettingsOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/publishsettings",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.OperationStatus
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.publishSettingUpdateObject,
  urlParameters: [Parameters.endpoint, Parameters.appId],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const listEndpointsOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/endpoints",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: { name: "Dictionary", value: { type: { name: "String" } } }
      }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [Parameters.endpoint, Parameters.appId],
  headerParameters: [Parameters.accept],
  serializer
};
const listAvailableCustomPrebuiltDomainsOperationSpec: coreClient.OperationSpec = {
  path: "/apps/customprebuiltdomains",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: { type: { name: "Composite", className: "PrebuiltDomain" } }
        }
      }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [Parameters.endpoint],
  headerParameters: [Parameters.accept],
  serializer
};
const addCustomPrebuiltDomainOperationSpec: coreClient.OperationSpec = {
  path: "/apps/customprebuiltdomains",
  httpMethod: "POST",
  responses: {
    201: {
      bodyMapper: { type: { name: "Uuid" } }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.prebuiltDomainCreateObject,
  urlParameters: [Parameters.endpoint],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const listAvailableCustomPrebuiltDomainsForCultureOperationSpec: coreClient.OperationSpec = {
  path: "/apps/customprebuiltdomains/{culture}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: { type: { name: "Composite", className: "PrebuiltDomain" } }
        }
      }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [Parameters.endpoint, Parameters.culture],
  headerParameters: [Parameters.accept],
  serializer
};
const packagePublishedApplicationAsGzipOperationSpec: coreClient.OperationSpec = {
  path: "/package/{appId}/slot/{slotName}/gzip",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: { type: { name: "Stream" }, serializedName: "parsedResponse" }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [Parameters.endpoint, Parameters.appId, Parameters.slotName],
  headerParameters: [Parameters.accept2],
  serializer
};
const packageTrainedApplicationAsGzipOperationSpec: coreClient.OperationSpec = {
  path: "/package/{appId}/versions/{versionId}/gzip",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: { type: { name: "Stream" }, serializedName: "parsedResponse" }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [Parameters.endpoint, Parameters.appId, Parameters.versionId],
  headerParameters: [Parameters.accept2],
  serializer
};
const importV2AppOperationSpec: coreClient.OperationSpec = {
  path: "/apps/import",
  httpMethod: "POST",
  responses: {
    201: {
      bodyMapper: { type: { name: "Uuid" } }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.luisAppV2,
  queryParameters: [Parameters.appName],
  urlParameters: [Parameters.endpoint],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const importLuFormatOperationSpec: coreClient.OperationSpec = {
  path: "/apps/import",
  httpMethod: "POST",
  responses: {
    201: {
      bodyMapper: { type: { name: "Uuid" } }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.luisAppLu,
  queryParameters: [Parameters.appName],
  urlParameters: [Parameters.endpoint],
  headerParameters: [Parameters.contentType1, Parameters.accept3],
  mediaType: "text",
  serializer
};
