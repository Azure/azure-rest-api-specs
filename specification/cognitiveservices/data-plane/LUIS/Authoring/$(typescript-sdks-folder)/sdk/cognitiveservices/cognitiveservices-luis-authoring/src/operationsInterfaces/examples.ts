import {
  ExampleLabelObject,
  ExamplesAddOptionalParams,
  ExamplesAddResponse,
  ExamplesBatchOptionalParams,
  ExamplesBatchResponse,
  ExamplesListOptionalParams,
  ExamplesListResponse,
  ExamplesDeleteOptionalParams,
  ExamplesDeleteResponse
} from "../models";

/** Interface representing a Examples. */
export interface Examples {
  /**
   * Adds a labeled example utterance in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param exampleLabelObject A labeled example utterance with the expected intent and entities.
   * @param options The options parameters.
   */
  add(
    appId: string,
    versionId: string,
    exampleLabelObject: ExampleLabelObject,
    options?: ExamplesAddOptionalParams
  ): Promise<ExamplesAddResponse>;
  /**
   * Adds a batch of labeled example utterances to a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param exampleLabelObjectArray Array of example utterances.
   * @param options The options parameters.
   */
  batch(
    appId: string,
    versionId: string,
    exampleLabelObjectArray: ExampleLabelObject[],
    options?: ExamplesBatchOptionalParams
  ): Promise<ExamplesBatchResponse>;
  /**
   * Returns example utterances to be reviewed from a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param options The options parameters.
   */
  list(
    appId: string,
    versionId: string,
    options?: ExamplesListOptionalParams
  ): Promise<ExamplesListResponse>;
  /**
   * Deletes the labeled example utterances with the specified ID from a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param exampleId The example ID.
   * @param options The options parameters.
   */
  delete(
    appId: string,
    versionId: string,
    exampleId: number,
    options?: ExamplesDeleteOptionalParams
  ): Promise<ExamplesDeleteResponse>;
}
