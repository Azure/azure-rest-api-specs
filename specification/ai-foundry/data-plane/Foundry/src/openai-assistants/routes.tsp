import "../common/models.tsp";
import "@typespec/http";
import "@azure-tools/openai-typespec/models/common";
import "@typespec/openapi";
import "@azure-tools/openai-typespec/models/assistants";
using TypeSpec.Http;
using OpenAI;
using TypeSpec.OpenAPI;
namespace Azure.AI.Projects;
@route("openai/v1/assistants")
@tag("Assistants")
interface Assistants {
  @list
  @get
  @summary("Returns a list of assistants.")
  listAssistants is OpenAIOperation<
    {
      /** A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 20. */
      @query(#{ explode: true })
      limit?: integer = 20;

      /** Sort order by the `created_at` timestamp of the objects. `asc` for ascending order and `desc` for descending order. */
      @query(#{ explode: true })
      order?: OpenAI.OrderEnum = OrderEnum.desc;

      /** A cursor for use in pagination. `after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include after=obj_foo in order to fetch the next page of the list. */
      @extension("x-ms-list-continuation-token", true)
      @continuationToken
      @query(#{ explode: true })
      after?: string;

      /** A cursor for use in pagination. `before` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, starting with obj_foo, your subsequent call can include before=obj_foo in order to fetch the previous page of the list. */
      @query(#{ explode: true })
      before?: string;
    },
    OpenAI.ListAssistantsResponse
  >;

  @post
  @summary("Create an assistant with a model and instructions.")
  createAssistant is OpenAIOperation<
    {
      @body
      body: OpenAI.CreateAssistantRequest;
    },
    OpenAI.AssistantObject
  >;

  @route("{assistant_id}")
  @delete
  @summary("Delete an assistant.")
  deleteAssistant is OpenAIOperation<
    {
      /** The ID of the assistant to delete. */
      @path
      assistant_id: string;
    },
    OpenAI.DeleteAssistantResponse
  >;

  @route("{assistant_id}")
  @get
  @summary("Retrieves an assistant.")
  getAssistant is OpenAIOperation<
    {
      /** The ID of the assistant to retrieve. */
      @path
      assistant_id: string;
    },
    OpenAI.AssistantObject
  >;

  @route("{assistant_id}")
  @post
  @summary("Modifies an assistant.")
  modifyAssistant is OpenAIOperation<
    {
      /** The ID of the assistant to modify. */
      @path
      assistant_id: string;

      @body
      body: OpenAI.ModifyAssistantRequest;
    },
    OpenAI.AssistantObject
  >;
}
