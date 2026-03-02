import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace CustomvoiceAPI;

interface ProjectsOperationGroup {
  /**
   * Gets a list of projects for the authenticated Speech service resource.
   */
  @operationId("Projects_List")
  @route("/projects")
  @get
  @extension("x-ms-pageable", #{ nextLinkName: "nextLink", itemName: "value" })
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The number of result items to skip.
       */
      @query("skip")
      skip?: int32 = 0;

      /**
       * The maximum number of items to include in a single response.
       */
      @query("maxpagesize")
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
    },
    PaginatedProjects
  >;

  /**
   * Gets the project identified by the given ID.
   */
  @operationId("Projects_Get")
  @route("/projects/{id}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the resource.
       */
      @maxLength(64)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
      @path
      id: string;
    },
    Project
  >;

  /**
   * Deletes the project identified by the given ID. All data (like consent,
   * training set) in this project will be deleted automatically.
   */
  @operationId("Projects_Delete")
  @route("/projects/{id}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the resource.
       */
      @maxLength(64)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
      @path
      id: string;

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
  @operationId("Projects_Create")
  @route("/projects/{id}")
  @put
  create is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the resource.
       */
      @maxLength(64)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
      @path
      id: string;

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

interface ConsentsOperationGroup {
  /**
   * Gets a list of consents for the authenticated Speech service resource.
   */
  @operationId("Consents_List")
  @route("/consents")
  @get
  @extension("x-ms-pageable", #{ nextLinkName: "nextLink", itemName: "value" })
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The number of result items to skip.
       */
      @query("skip")
      skip?: int32 = 0;

      /**
       * The maximum number of items to include in a single response.
       */
      @query("maxpagesize")
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
    },
    PaginatedConsents
  >;

  /**
   * Gets the consent identified by the given ID.
   */
  @operationId("Consents_Get")
  @route("/consents/{id}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the resource.
       */
      @maxLength(64)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
      @path
      id: string;
    },
    Consent
  >;

  /**
   * Deletes the consent identified by the given ID.
   */
  @operationId("Consents_Delete")
  @route("/consents/{id}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the resource.
       */
      @maxLength(64)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
      @path
      id: string;
    },
    void
  >;

  /**
   * Creates a new voice talent consent with the provided audio URL.
   */
  @operationId("Consents_Create")
  @route("/consents/{id}")
  @put
  @extension("x-ms-long-running-operation", true)
  create is Azure.Core.Foundations.Operation<
    {
      /**
       * ID of the status monitor for the operation. If the Operation-Id header matches
       * an existing operation and the request is not identical to the prior request, it
       * will fail with a 400 Bad Request.
       */
      @maxLength(64)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
      @header("Operation-Id")
      `Operation-Id`?: string;

      /**
       * The ID of the resource.
       */
      @maxLength(64)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
      @path
      id: string;

      /**
       * consent definition
       */
      @bodyRoot
      consent: Consent;
    },
    {
      @statusCode statusCode: 201;
      @header("Operation-Location") operationLocation: string;
      @header("Operation-Id") operationIdHeader: string;
      @bodyRoot body: Consent;
    }
  >;

  /**
   * Creates a new voice talent consent with the provided audio file.
   */
  @operationId("Consents_Post")
  @route("/consents/{id}")
  @post
  @extension("x-ms-long-running-operation", true)
  @extension("x-ms-long-running-operation-options", #{ `final-state-via`: "operation-location" })
  post is Azure.Core.Foundations.Operation<
    {
      /**
       * ID of the status monitor for the operation. If the Operation-Id header matches
       * an existing operation and the request is not identical to the prior request, it
       * will fail with a 400 Bad Request.
       */
      @maxLength(64)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
      @header("Operation-Id")
      `Operation-Id`?: string;

      /**
       * The ID of the resource.
       */
      @maxLength(64)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
      @path
      id: string;

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

interface TrainingSetsOperationGroup {
  /**
   * Gets a list of training sets for the authenticated Speech service resource.
   */
  @operationId("TrainingSets_List")
  @route("/trainingsets")
  @get
  @extension("x-ms-pageable", #{ nextLinkName: "nextLink", itemName: "value" })
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The number of result items to skip.
       */
      @query("skip")
      skip?: int32 = 0;

      /**
       * The maximum number of items to include in a single response.
       */
      @query("maxpagesize")
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
    },
    PaginatedTrainingSets
  >;

  /**
   * Gets the training set identified by the given ID.
   */
  @operationId("TrainingSets_Get")
  @route("/trainingsets/{id}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the resource.
       */
      @maxLength(64)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
      @path
      id: string;
    },
    TrainingSet
  >;

  /**
   * Deletes the training set identified by the given ID.
   */
  @operationId("TrainingSets_Delete")
  @route("/trainingsets/{id}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the resource.
       */
      @maxLength(64)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
      @path
      id: string;
    },
    void
  >;

  /**
   * Creates a new training set.
   */
  @operationId("TrainingSets_Create")
  @route("/trainingsets/{id}")
  @put
  create is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the resource.
       */
      @maxLength(64)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
      @path
      id: string;

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
  @operationId("TrainingSets_UploadData")
  @route("/trainingsets/{id}:upload")
  @post
  @extension("x-ms-long-running-operation", true)
  @extension("x-ms-long-running-operation-options", #{ `final-state-via`: "operation-location" })
  uploadData is Azure.Core.Foundations.Operation<
    {
      /**
       * ID of the status monitor for the operation. If the Operation-Id header matches
       * an existing operation and the request is not identical to the prior request, it
       * will fail with a 400 Bad Request.
       */
      @maxLength(64)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
      @header("Operation-Id")
      `Operation-Id`?: string;

      /**
       * The ID of the resource.
       */
      @maxLength(64)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
      @path
      id: string;

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

interface ModelsOperationGroup {
  /**
   * Get a list of supported recipes for model building. Different recipes have
   * different capabilities such as support for multi-style voice models.
   */
  @operationId("Models_ListRecipes")
  @route("/modelrecipes")
  @get
  @extension("x-ms-pageable", #{ nextLinkName: "nextLink", itemName: "value" })
  listRecipes is Azure.Core.Foundations.Operation<{}, PaginatedRecipes>;

  /**
   * Gets the list of models for the authenticated Speech service resource.
   */
  @operationId("Models_List")
  @route("/models")
  @get
  @extension("x-ms-pageable", #{ nextLinkName: "nextLink", itemName: "value" })
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The number of result items to skip.
       */
      @query("skip")
      skip?: int32 = 0;

      /**
       * The maximum number of items to include in a single response.
       */
      @query("maxpagesize")
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
    },
    PaginatedModels
  >;

  /**
   * Gets the model identified by the given ID.
   */
  @operationId("Models_Get")
  @route("/models/{id}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the resource.
       */
      @maxLength(64)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
      @path
      id: string;
    },
    Model
  >;

  /**
   * Deletes the model identified by the given ID.
   */
  @operationId("Models_Delete")
  @route("/models/{id}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the resource.
       */
      @maxLength(64)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
      @path
      id: string;
    },
    void
  >;

  /**
   * Creates a new voice model.
   */
  @operationId("Models_Create")
  @route("/models/{id}")
  @put
  @extension("x-ms-long-running-operation", true)
  create is Azure.Core.Foundations.Operation<
    {
      /**
       * ID of the status monitor for the operation. If the Operation-Id header matches
       * an existing operation and the request is not identical to the prior request, it
       * will fail with a 400 Bad Request.
       */
      @maxLength(64)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
      @header("Operation-Id")
      `Operation-Id`?: string;

      /**
       * The ID of the resource.
       */
      @maxLength(64)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
      @path
      id: string;

      /**
       * Model definition
       */
      @bodyRoot
      `model`: Model;
    },
    {
      @statusCode statusCode: 201;
      @header("Operation-Location") operationLocation: string;
      @header("Operation-Id") operationIdHeader: string;
      @bodyRoot body: Model;
    }
  >;
}

interface EndpointsOperationGroup {
  /**
   * Gets a list of endpoints for the authenticated Speech service resource.
   */
  @operationId("Endpoints_List")
  @route("/endpoints")
  @get
  @extension("x-ms-pageable", #{ nextLinkName: "nextLink", itemName: "value" })
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The number of result items to skip.
       */
      @query("skip")
      skip?: int32 = 0;

      /**
       * The maximum number of items to include in a single response.
       */
      @query("maxpagesize")
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
    },
    PaginatedEndpoints
  >;

  /**
   * Gets the endpoint identified by the given ID.
   */
  @operationId("Endpoints_Get")
  @route("/endpoints/{id}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The resource ID, which should be UUID.
       */
      @format("uuid")
      @path
      id: string;
    },
    Endpoint
  >;

  /**
   * Deletes the endpoint identified by the given ID.
   */
  @operationId("Endpoints_Delete")
  @route("/endpoints/{id}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * The resource ID, which should be UUID.
       */
      @format("uuid")
      @path
      id: string;
    },
    void
  >;

  /**
   * Creates a new endpoint.
   */
  @operationId("Endpoints_Create")
  @route("/endpoints/{id}")
  @put
  @extension("x-ms-long-running-operation", true)
  create is Azure.Core.Foundations.Operation<
    {
      /**
       * ID of the status monitor for the operation. If the Operation-Id header matches
       * an existing operation and the request is not identical to the prior request, it
       * will fail with a 400 Bad Request.
       */
      @maxLength(64)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
      @header("Operation-Id")
      `Operation-Id`?: string;

      /**
       * The resource ID, which should be UUID.
       */
      @format("uuid")
      @path
      id: string;

      /**
       * Endpoint definition
       */
      @bodyRoot
      endpoint: Endpoint;
    },
    {
      @statusCode statusCode: 201;
      @header("Operation-Location") operationLocation: string;
      @header("Operation-Id") operationIdHeader: string;
      @bodyRoot body: Endpoint;
    }
  >;

  /**
   * Resumes the endpoint identified by the given ID.
   */
  @operationId("Endpoints_Resume")
  @route("/endpoints/{id}:resume")
  @post
  @extension("x-ms-long-running-operation", true)
  @extension("x-ms-long-running-operation-options", #{ `final-state-via`: "operation-location" })
  resume is Azure.Core.Foundations.Operation<
    {
      /**
       * ID of the status monitor for the operation. If the Operation-Id header matches
       * an existing operation and the request is not identical to the prior request, it
       * will fail with a 400 Bad Request.
       */
      @maxLength(64)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
      @header("Operation-Id")
      `Operation-Id`?: string;

      /**
       * The resource ID, which should be UUID.
       */
      @format("uuid")
      @path
      id: string;
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
  @operationId("Endpoints_Suspend")
  @route("/endpoints/{id}:suspend")
  @post
  @extension("x-ms-long-running-operation", true)
  @extension("x-ms-long-running-operation-options", #{ `final-state-via`: "operation-location" })
  suspend is Azure.Core.Foundations.Operation<
    {
      /**
       * ID of the status monitor for the operation. If the Operation-Id header matches
       * an existing operation and the request is not identical to the prior request, it
       * will fail with a 400 Bad Request.
       */
      @maxLength(64)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
      @header("Operation-Id")
      `Operation-Id`?: string;

      /**
       * The resource ID, which should be UUID.
       */
      @format("uuid")
      @path
      id: string;
    },
    {
      @statusCode statusCode: 202;
      @header("Operation-Location") operationLocation: string;
      @header("Operation-Id") operationIdHeader: string;
      @bodyRoot body: Endpoint;
    }
  >;
}

interface BaseModelsOperationGroup {
  /**
   * Gets a list of base models.
   */
  @operationId("BaseModels_List")
  @route("/basemodels")
  @get
  @extension("x-ms-pageable", #{ nextLinkName: "nextLink", itemName: "value" })
  list is Azure.Core.Foundations.Operation<{}, PaginatedBaseModels>;
}

interface PersonalVoicesOperationGroup {
  /**
   * Gets a list of personal voices for the authenticated Speech service resource.
   */
  @operationId("PersonalVoices_List")
  @route("/personalvoices")
  @get
  @extension("x-ms-pageable", #{ nextLinkName: "nextLink", itemName: "value" })
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The number of result items to skip.
       */
      @query("skip")
      skip?: int32 = 0;

      /**
       * The maximum number of items to include in a single response.
       */
      @query("maxpagesize")
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
    },
    PaginatedPersonalVoices
  >;

  /**
   * Gets the personal voice identified by the given ID.
   */
  @operationId("PersonalVoices_Get")
  @route("/personalvoices/{id}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the resource.
       */
      @maxLength(64)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
      @path
      id: string;
    },
    PersonalVoice
  >;

  /**
   * Deletes the personal voice identified by the given ID.
   */
  @operationId("PersonalVoices_Delete")
  @route("/personalvoices/{id}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the resource.
       */
      @maxLength(64)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
      @path
      id: string;
    },
    void
  >;

  /**
   * Creates a new personal voice with audio files in Azure Blob Storage.
   */
  @operationId("PersonalVoices_Create")
  @route("/personalvoices/{id}")
  @put
  @extension("x-ms-long-running-operation", true)
  create is Azure.Core.Foundations.Operation<
    {
      /**
       * ID of the status monitor for the operation. If the Operation-Id header matches
       * an existing operation and the request is not identical to the prior request, it
       * will fail with a 400 Bad Request.
       */
      @maxLength(64)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
      @header("Operation-Id")
      `Operation-Id`?: string;

      /**
       * The ID of the resource.
       */
      @maxLength(64)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
      @path
      id: string;

      /**
       * personal voice definition
       */
      @bodyRoot
      personalvoice: PersonalVoice;
    },
    {
      @statusCode statusCode: 201;
      @header("Operation-Location") operationLocation: string;
      @header("Operation-Id") operationIdHeader: string;
      @bodyRoot body: PersonalVoice;
    }
  >;

  /**
   * Creates a new personal voice with audio files in the client.
   */
  @operationId("PersonalVoices_Post")
  @route("/personalvoices/{id}")
  @post
  @extension("x-ms-long-running-operation", true)
  @extension("x-ms-long-running-operation-options", #{ `final-state-via`: "operation-location" })
  post is Azure.Core.Foundations.Operation<
    {
      /**
       * ID of the status monitor for the operation. If the Operation-Id header matches
       * an existing operation and the request is not identical to the prior request, it
       * will fail with a 400 Bad Request.
       */
      @maxLength(64)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
      @header("Operation-Id")
      `Operation-Id`?: string;

      /**
       * The ID of the resource.
       */
      @maxLength(64)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
      @path
      id: string;

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

interface OperationsOperationGroup {
  /**
   * Gets operation info.
   */
  @operationId("Operations_Get")
  @route("/operations/{id}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the operation
       */
      @maxLength(64)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
      @path
      id: string;
    },
    Operation
  >;
}
