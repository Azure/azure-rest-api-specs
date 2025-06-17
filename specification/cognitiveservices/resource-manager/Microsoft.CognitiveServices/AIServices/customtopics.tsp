import "@typespec/http";

using Http;

/*
 * This is the API spec for custom topics feature.
 * This feature is to enable customers to train a new model with their own data and apply the model to
 * content filter.
 *
 * The APIs defined here are for control plane. The caller (e.g. the AOAI UX) will call https://management.azure.com/batch
 * API and in the request body, there is a field named "RelativeURL" which indicate the API defined here.
 * e.g.
 * "RelativeUrl":"/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.CognitiveServices/accounts/{account}/raiTopics/{topicName}?api-version=2025-05-01-preview"
 */

@service(#{ title: "Custom Topic API" })
namespace CustomTopic;

model CustomTopicCreationRequest {
  topicName: string;
  description: string;
  sampleBlobUrl: string;
}

model CustomTopicModelResponse {
  id: string;
  name: string;
  description: string;
  sampleBlobUrl: string;
  status: string;
  failedReason: string;
  createdAt: string;
  lastModifiedAt: string;
}

model CustomTopicBasicQueryParameters {
  "api-version": string
}

@error
model NotFoundError {
  code: "NOT_FOUND";
  message: string;
}

@error
model ValidationError {
  code: "VALIDATION_ERROR";
  message: string;
}

@error
model InternalServerError {
  code: "INTERNAL_SERVER_ERROR";
  message: string;
}

namespace CustomTopic {
  @route("/raitopics/{topicName}:createAndTrain")
  @put
  op createAndTrain(topicName: string, @body body: CustomTopicCreationRequest, @query query: CustomTopicBasicQueryParameters): {
    @statusCode statusCode: 201;
    @body newModel: CustomTopicModelResponse;
  } | {
        @statusCode statusCode: 400;
        @body error: ValidationError;
      }
    | {
        @statusCode statusCode: 500;
        @body error: InternalServerError;
      };

  @route("/raitopics/{topicName}")
  @get
  op get(topicName: string, @query query: CustomTopicBasicQueryParameters): {
    @statusCode statusCode: 200;
    @body existingModel: CustomTopicModelResponse;
  } | {
    @statusCode statusCode: 404;

    @body error: NotFoundError;
  };
  @delete
  op delete(topicName: string, @query query: CustomTopicBasicQueryParameters): {
    @statusCode statusCode: 204;
  } | {
    @statusCode statusCode: 404;

    @body error: NotFoundError;
  };

  @route("/raitopics/")
  @get
  op listTopics(@query query: CustomTopicBasicQueryParameters): {
    @statusCode statusCode: 200;
    @body existingModels: CustomTopicModelResponse[];
  } | {
    @statusCode statusCode: 404;

    @body error: NotFoundError;
  };
}
