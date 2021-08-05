import * as coreClient from "@azure/core-client";
import * as coreAuth from "@azure/core-auth";
import { LuisAuthoringClientOptionalParams } from "./models";

export class LuisAuthoringClientContext extends coreClient.ServiceClient {
  endpoint: string;

  /**
   * Initializes a new instance of the LuisAuthoringClientContext class.
   * @param credentials Subscription credentials which uniquely identify client subscription.
   * @param endpoint Supported Cognitive Services endpoints (protocol and hostname, for example:
   *                 https://westus.api.cognitive.microsoft.com).
   * @param options The parameter options
   */
  constructor(
    credentials: coreAuth.TokenCredential,
    endpoint: string,
    options?: LuisAuthoringClientOptionalParams
  ) {
    if (credentials === undefined) {
      throw new Error("'credentials' cannot be null");
    }
    if (endpoint === undefined) {
      throw new Error("'endpoint' cannot be null");
    }

    // Initializing default values for options
    if (!options) {
      options = {};
    }
    const defaults: LuisAuthoringClientOptionalParams = {
      requestContentType: "application/json; charset=utf-8",
      credential: credentials
    };

    const packageDetails = `azsdk-js-cognitiveservices-luis-authoring/1.0.0-beta.1`;
    const userAgentPrefix =
      options.userAgentOptions && options.userAgentOptions.userAgentPrefix
        ? `${options.userAgentOptions.userAgentPrefix} ${packageDetails}`
        : `${packageDetails}`;

    const optionsWithDefaults = {
      ...defaults,
      ...options,
      userAgentOptions: {
        userAgentPrefix
      },
      baseUri: options.endpoint || "{Endpoint}/luis/authoring/v3.0"
    };
    super(optionsWithDefaults);
    // Parameter assignments
    this.endpoint = endpoint;
  }
}
