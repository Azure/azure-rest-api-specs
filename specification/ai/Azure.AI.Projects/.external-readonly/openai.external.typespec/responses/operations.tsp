import "@typespec/http";
import "@typespec/openapi";

import "../common/custom.tsp";
import "./custom.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace OpenAI;

@route("responses")
@tag("Responses")
interface Responses {
  /**
   * Creates a model response.
   */
  @operationId("createResponse")
  @post
  createResponse(
    ...AcceptJsonOrEventStreamHeader,
    @body requestBody: CreateResponse,
  ): Response | SseResponseOf<ResponseStreamEvent> | ResponseErrorResponse;

  /**
   * Retrieves a model response with the given ID.
   *
   * @param response_id The ID of the response to retrieve.
   * @param include Specifies additional output data to include in the model response.
   * @param stream If set to true, model response data will be streamed to the client as it is generated using server-sent events.
   * @param starting_after The sequence number of the event after which to start streaming.
   */
  @operationId("getResponse")
  @get
  @route("{response_id}")
  getResponse(
    @path
    @example("resp_677efb5139a88190b512bc3fef8e535d")
    response_id: string,

    @query(#{ name: "include[]", explode: true })
    includables?: Includable[] = #[],

    @query stream?: boolean = false,
    @query starting_after?: int32,
  ): Response | SseResponseOf<ResponseStreamEvent> | ResponseErrorResponse;

  @delete
  @route("{response_id}")
  @operationId("deleteResponse")
  deleteResponse(
    /**
     * The ID of the response to delete.
     */
    @path
    @example("resp_677efb5139a88190b512bc3fef8e535d")
    response_id: string,
  ): {
    id: string;
    object: "response";
    deleted: true;
  } | ResponseErrorResponse;

  @post
  @route("{response_id}/cancel")
  @operationId("cancelResponse")
  cancelResponse(
    /**
     * The ID of the response to cancel.
     */
    @path
    @example("resp_677efb5139a88190b512bc3fef8e535d")
    response_id: string,
  ): Response | ResponseErrorResponse;

  /**
   * Returns a list of input items for a given response.
   *
   * @param response_id The ID of the response to retrieve.
   */
  @operationId("listInputItems")
  @get
  @route("{response_id}/input_items")
  listInputItems(
    @path
    @example("resp_677efb5139a88190b512bc3fef8e535d")
    response_id: string,

    ...CommonPageQueryParameters,
  ): ResponseItemList | ResponseErrorResponse;
}
