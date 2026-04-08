import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.Core.Traits;

namespace CustomVoiceApi;

/** Service traits - suppress standard Azure headers not used by this API. */
alias CustomVoiceServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;

/** Standard resource operations with Custom Voice service traits. */
alias ops = Azure.Core.ResourceOperations<CustomVoiceServiceTraits>;

/**
 * Common list query parameters for resource list operations.
 */
model CustomListQueryParameters {
  /**
   * The number of result items to skip.
   */
  @query("skip")
  @offset
  skip?: int32 = 0;

  /**
   * The maximum number of items to include in a single response.
   */
  @query("maxpagesize")
  @pageSize
  maxpagesize?: int32 = 100;

  /**
   * Filter condition.
   *   - **Supported properties:** projectId, createdDateTime, locale, kind
   *   - **Operators:**
   *     - eq, ne are supported for all properties.
   *     - gt, ge, lt, le are supported for createdDateTime.
   *   - **Example:**
   *     - ```filter=projectId eq 'Jessica'``` (filter by project ID)
   *     - ```filter=kind eq 'ProfessionalVoice'``` (filter project by kind)
   *     - ```filter=locale eq 'en-US'``` (filter training set and model by locale)
   *     - ```filter=createdDateTime gt 2022-12-30T23:59:59.99Z``` (filter resource
   * created time after 2023-11-01)
   */
  @query("filter")
  filter?: string;
}

interface Projects {
  /**
   * Gets a list of projects for the authenticated Speech service resource.
   */
  list is ops.ResourceList<
    Project,
    ListQueryParametersTrait<CustomListQueryParameters>
  >;

  /**
   * Gets the project identified by the given ID.
   */
  get is ops.ResourceRead<Project>;

  /**
   * Deletes the project identified by the given ID. All data (like consent,
   * training set) in this project will be deleted automatically.
   */
  @route("/projects/{id}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /** The ID of the resource. */
      @path
      id: resourceId;

      /**
       * Set this to true if you want to delete a project with model and endpoint.
       * Otherwise, the delete operation will fail.
       */
      @query("forceDelete")
      forceDelete?: boolean;
    },
    void
  >;

  /**
   * Creates a new project.
   */
  @route("/projects/{id}")
  @put
  create is Azure.Core.Foundations.Operation<
    {
      /** The ID of the resource. */
      @path
      id: resourceId;

      /**
       * project definition
       */
      @bodyRoot
      project: Project;
    },
    {
      @statusCode statusCode: 201;
      @bodyRoot body: Project;
    }
  >;
}

interface Consents {
  /**
   * Gets a list of consents for the authenticated Speech service resource.
   */
  list is ops.ResourceList<
    Consent,
    ListQueryParametersTrait<CustomListQueryParameters>
  >;

  /**
   * Gets the consent identified by the given ID.
   */
  get is ops.ResourceRead<Consent>;

  /**
   * Deletes the consent identified by the given ID.
   */
  delete is ops.ResourceDelete<Consent>;

  /**
   * Creates a new voice talent consent with the provided audio URL.
   */
  @pollingOperation(Operations.get)
  create is ops.LongRunningResourceCreateOrReplace<
    Consent,
    RequestHeadersTrait<OperationIdHeader>
  >;

  /**
   * Creates a new voice talent consent with the provided audio file.
   */
  @route("/consents/{id}")
  @post
  @pollingOperation(Operations.get)
  @useFinalStateVia("operation-location")
  createFromAudioFile is Azure.Core.Foundations.Operation<
    {
      ...OperationIdHeader;

      /** The ID of the resource. */
      @path
      id: resourceId;

      /** Content type for multipart form data. */
      @header contentType: "multipart/form-data";

      /** Consent form data */
      @multipartBody
      body: ConsentPostFormData;
    },
    {
      @statusCode statusCode: 201;
      @header("Operation-Location") operationLocation: string;
      @header("Operation-Id") operationIdHeader: string;
      @bodyRoot body: Consent;
    }
  >;
}

interface TrainingSets {
  /**
   * Gets a list of training sets for the authenticated Speech service resource.
   */
  list is ops.ResourceList<
    TrainingSet,
    ListQueryParametersTrait<CustomListQueryParameters>
  >;

  /**
   * Gets the training set identified by the given ID.
   */
  get is ops.ResourceRead<TrainingSet>;

  /**
   * Deletes the training set identified by the given ID.
   */
  delete is ops.ResourceDelete<TrainingSet>;

  /**
   * Creates a new training set.
   */
  @route("/trainingsets/{id}")
  @put
  create is Azure.Core.Foundations.Operation<
    {
      /** The ID of the resource. */
      @path
      id: resourceId;

      /**
       * training set definition
       */
      @bodyRoot
      trainingset: TrainingSet;
    },
    {
      @statusCode statusCode: 201;
      @bodyRoot body: TrainingSet;
    }
  >;

  /**
   * Uploads data to the specified training set.
   */
  @route("/trainingsets/{id}:upload")
  @post
  @pollingOperation(Operations.get)
  @useFinalStateVia("operation-location")
  uploadData is Azure.Core.Foundations.Operation<
    {
      ...OperationIdHeader;

      /** The ID of the resource. */
      @path
      id: resourceId;

      /**
       * Dataset to be uploaded
       */
      @bodyRoot
      dataset: Dataset;
    },
    {
      @statusCode statusCode: 202;
      @header("Operation-Location") operationLocation: string;
      @header("Operation-Id") operationIdHeader: string;
    }
  >;
}

interface Models {
  /**
   * Get a list of supported recipes for model building. Different recipes have
   * different capabilities such as support for multi-style voice models.
   */
  @route("/modelrecipes")
  @get
  @list
  listRecipes is Azure.Core.Foundations.Operation<{}, Azure.Core.Page<Recipe>>;

  /**
   * Gets the list of models for the authenticated Speech service resource.
   */
  list is ops.ResourceList<
    Model,
    ListQueryParametersTrait<CustomListQueryParameters>
  >;

  /**
   * Gets the model identified by the given ID.
   */
  get is ops.ResourceRead<Model>;

  /**
   * Deletes the model identified by the given ID.
   */
  delete is ops.ResourceDelete<Model>;

  /**
   * Creates a new voice model.
   */
  @pollingOperation(Operations.get)
  create is ops.LongRunningResourceCreateOrReplace<
    Model,
    RequestHeadersTrait<OperationIdHeader>
  >;
}

interface Endpoints {
  /**
   * Gets a list of endpoints for the authenticated Speech service resource.
   */
  list is ops.ResourceList<
    Endpoint,
    ListQueryParametersTrait<CustomListQueryParameters>
  >;

  /**
   * Gets the endpoint identified by the given ID.
   */
  get is ops.ResourceRead<Endpoint>;

  /**
   * Deletes the endpoint identified by the given ID.
   */
  delete is ops.ResourceDelete<Endpoint>;

  /**
   * Creates a new endpoint.
   */
  @pollingOperation(Operations.get)
  create is ops.LongRunningResourceCreateOrReplace<
    Endpoint,
    RequestHeadersTrait<OperationIdHeader>
  >;

  /**
   * Resumes the endpoint identified by the given ID.
   */
  @route("/endpoints/{id}:resume")
  @post
  @pollingOperation(Operations.get)
  @useFinalStateVia("operation-location")
  resume is Azure.Core.Foundations.Operation<
    {
      ...OperationIdHeader;

      /**
       * The resource ID, which should be UUID.
       */
      @path
      id: uuid;
    },
    {
      @statusCode statusCode: 202;
      @header("Operation-Location") operationLocation: string;
      @header("Operation-Id") operationIdHeader: string;
      @bodyRoot body: Endpoint;
    }
  >;

  /**
   * Suspends the endpoint identified by the given ID.
   */
  @route("/endpoints/{id}:suspend")
  @post
  @pollingOperation(Operations.get)
  @useFinalStateVia("operation-location")
  suspend is Azure.Core.Foundations.Operation<
    {
      ...OperationIdHeader;

      /**
       * The resource ID, which should be UUID.
       */
      @path
      id: uuid;
    },
    {
      @statusCode statusCode: 202;
      @header("Operation-Location") operationLocation: string;
      @header("Operation-Id") operationIdHeader: string;
      @bodyRoot body: Endpoint;
    }
  >;
}

interface BaseModels {
  /**
   * Gets a list of base models.
   */
  list is ops.ResourceList<BaseModel>;
}

interface PersonalVoices {
  /**
   * Gets a list of personal voices for the authenticated Speech service resource.
   */
  list is ops.ResourceList<
    PersonalVoice,
    ListQueryParametersTrait<CustomListQueryParameters>
  >;

  /**
   * Gets the personal voice identified by the given ID.
   */
  get is ops.ResourceRead<PersonalVoice>;

  /**
   * Deletes the personal voice identified by the given ID.
   */
  delete is ops.ResourceDelete<PersonalVoice>;

  /**
   * Creates a new personal voice with audio files in Azure Blob Storage.
   */
  @pollingOperation(Operations.get)
  create is ops.LongRunningResourceCreateOrReplace<
    PersonalVoice,
    RequestHeadersTrait<OperationIdHeader>
  >;

  /**
   * Creates a new personal voice with audio files in the client.
   */
  @route("/personalvoices/{id}")
  @post
  @pollingOperation(Operations.get)
  @useFinalStateVia("operation-location")
  createFromAudioFile is Azure.Core.Foundations.Operation<
    {
      ...OperationIdHeader;

      /** The ID of the resource. */
      @path
      id: resourceId;

      /** Content type for multipart form data. */
      @header contentType: "multipart/form-data";

      /** Personal voice form data */
      @multipartBody
      body: PersonalVoicePostFormData;
    },
    {
      @statusCode statusCode: 201;
      @header("Operation-Location") operationLocation: string;
      @header("Operation-Id") operationIdHeader: string;
      @bodyRoot body: PersonalVoice;
    }
  >;
}

interface Operations {
  /**
   * Gets operation info.
   */
  get is ops.ResourceRead<Operation>;
}
