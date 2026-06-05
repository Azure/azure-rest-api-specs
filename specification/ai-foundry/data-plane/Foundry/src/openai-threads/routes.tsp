import "../common/models.tsp";
import "@typespec/http";
import "@azure-tools/openai-typespec/models/threads";
import "@azure-tools/openai-typespec/models/runs";
import "@azure-tools/openai-typespec/models/common";
import "@typespec/openapi";
import "@azure-tools/openai-typespec/models/messages";
using TypeSpec.Http;
using OpenAI;
using TypeSpec.OpenAPI;
namespace Azure.AI.Projects;
@route("openai/v1/threads")
@tag("Threads")
interface Threads {
  @tag("Assistants")
  @post
  @summary("Create a thread.")
  createThread is OpenAIOperation<
    {
      @body
      body: OpenAI.CreateThreadRequest;
    },
    OpenAI.ThreadObject
  >;

  @tag("Assistants")
  @route("runs")
  @post
  @summary("Create a thread and run it in one request.")
  createThreadAndRun is OpenAIOperation<
    {
      @body
      body: OpenAI.CreateThreadAndRunRequest;
    },
    OpenAI.RunObject
  >;

  @tag("Assistants")
  @route("{thread_id}")
  @delete
  @summary("Delete a thread.")
  deleteThread is OpenAIOperation<
    {
      /** The ID of the thread to delete. */
      @path
      thread_id: string;
    },
    OpenAI.DeleteThreadResponse
  >;

  @tag("Assistants")
  @route("{thread_id}")
  @get
  @summary("Retrieves a thread.")
  getThread is OpenAIOperation<
    {
      /** The ID of the thread to retrieve. */
      @path
      thread_id: string;
    },
    OpenAI.ThreadObject
  >;

  @tag("Assistants")
  @route("{thread_id}")
  @post
  @summary("Modifies a thread.")
  modifyThread is OpenAIOperation<
    {
      /** The ID of the thread to modify. Only the `metadata` can be modified. */
      @path
      thread_id: string;

      @body
      body: OpenAI.ModifyThreadRequest;
    },
    OpenAI.ThreadObject
  >;

  @tag("Assistants")
  @list
  @route("{thread_id}/messages")
  @get
  @summary("Returns a list of messages for a given thread.")
  listMessages is OpenAIOperation<
    {
      /** The ID of the [thread](/docs/api-reference/threads) the messages belong to. */
      @path
      thread_id: string;

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

      /** Filter messages by the run ID that generated them. */
      @query(#{ explode: true })
      run_id?: string;
    },
    OpenAI.ListMessagesResponse
  >;

  @tag("Assistants")
  @route("{thread_id}/messages")
  @post
  @summary("Create a message.")
  createMessage is OpenAIOperation<
    {
      /** The ID of the [thread](/docs/api-reference/threads) to create a message for. */
      @path
      thread_id: string;

      @body
      body: OpenAI.CreateMessageRequest;
    },
    OpenAI.MessageObject
  >;

  @tag("Assistants")
  @route("{thread_id}/messages/{message_id}")
  @delete
  @summary("Deletes a message.")
  deleteMessage is OpenAIOperation<
    {
      /** The ID of the thread to which this message belongs. */
      @path
      thread_id: string;

      /** The ID of the message to delete. */
      @path
      message_id: string;
    },
    OpenAI.DeleteMessageResponse
  >;

  @tag("Assistants")
  @route("{thread_id}/messages/{message_id}")
  @get
  @summary("Retrieve a message.")
  getMessage is OpenAIOperation<
    {
      /** The ID of the [thread](/docs/api-reference/threads) to which this message belongs. */
      @path
      thread_id: string;

      /** The ID of the message to retrieve. */
      @path
      message_id: string;
    },
    OpenAI.MessageObject
  >;

  @tag("Assistants")
  @route("{thread_id}/messages/{message_id}")
  @post
  @summary("Modifies a message.")
  modifyMessage is OpenAIOperation<
    {
      /** The ID of the thread to which this message belongs. */
      @path
      thread_id: string;

      /** The ID of the message to modify. */
      @path
      message_id: string;

      @body
      body: OpenAI.ModifyMessageRequest;
    },
    OpenAI.MessageObject
  >;

  @tag("Assistants")
  @list
  @route("{thread_id}/runs")
  @get
  @summary("Returns a list of runs belonging to a thread.")
  listRuns is OpenAIOperation<
    {
      /** The ID of the thread the run belongs to. */
      @path
      thread_id: string;

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
    OpenAI.ListRunsResponse
  >;

  @tag("Assistants")
  @route("{thread_id}/runs")
  @post
  @summary("Create a run.")
  createRun is OpenAIOperation<
    {
      /** The ID of the thread to run. */
      @path
      thread_id: string;

      /**A list of additional fields to include in the response. Currently the only supported value is `step_details.tool_calls[*].file_search.results[*].content` to fetch the file search result content.
  See the [file search tool documentation](/docs/assistants/tools/file-search#customizing-file-search-settings) for more information.*/
      @query(#{ explode: true })
      `include[]`?: "step_details.tool_calls[*].file_search.results[*].content"[];

      @body
      body: OpenAI.CreateRunRequest;
    },
    OpenAI.RunObject
  >;

  @tag("Assistants")
  @route("{thread_id}/runs/{run_id}")
  @get
  @summary("Retrieves a run.")
  getRun is OpenAIOperation<
    {
      /** The ID of the [thread](/docs/api-reference/threads) that was run. */
      @path
      thread_id: string;

      /** The ID of the run to retrieve. */
      @path
      run_id: string;
    },
    OpenAI.RunObject
  >;

  @tag("Assistants")
  @route("{thread_id}/runs/{run_id}")
  @post
  @summary("Modifies a run.")
  modifyRun is OpenAIOperation<
    {
      /** The ID of the [thread](/docs/api-reference/threads) that was run. */
      @path
      thread_id: string;

      /** The ID of the run to modify. */
      @path
      run_id: string;

      @body
      body: OpenAI.ModifyRunRequest;
    },
    OpenAI.RunObject
  >;

  @tag("Assistants")
  @route("{thread_id}/runs/{run_id}/cancel")
  @post
  @summary("Cancels a run that is `in_progress`.")
  cancelRun is OpenAIOperation<
    {
      /** The ID of the thread to which this run belongs. */
      @path
      thread_id: string;

      /** The ID of the run to cancel. */
      @path
      run_id: string;
    },
    OpenAI.RunObject
  >;

  @tag("Assistants")
  @list
  @route("{thread_id}/runs/{run_id}/steps")
  @get
  @summary("Returns a list of run steps belonging to a run.")
  listRunSteps is OpenAIOperation<
    {
      /** The ID of the thread the run and run steps belong to. */
      @path
      thread_id: string;

      /** The ID of the run the run steps belong to. */
      @path
      run_id: string;

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

      /**A list of additional fields to include in the response. Currently the only supported value is `step_details.tool_calls[*].file_search.results[*].content` to fetch the file search result content.
  See the [file search tool documentation](/docs/assistants/tools/file-search#customizing-file-search-settings) for more information.*/
      @query(#{ explode: true })
      `include[]`?: "step_details.tool_calls[*].file_search.results[*].content"[];
    },
    OpenAI.ListRunStepsResponse
  >;

  @tag("Assistants")
  @route("{thread_id}/runs/{run_id}/steps/{step_id}")
  @get
  @summary("Retrieves a run step.")
  getRunStep is OpenAIOperation<
    {
      /** The ID of the thread to which the run and run step belongs. */
      @path
      thread_id: string;

      /** The ID of the run to which the run step belongs. */
      @path
      run_id: string;

      /** The ID of the run step to retrieve. */
      @path
      step_id: string;

      /**A list of additional fields to include in the response. Currently the only supported value is `step_details.tool_calls[*].file_search.results[*].content` to fetch the file search result content.
  See the [file search tool documentation](/docs/assistants/tools/file-search#customizing-file-search-settings) for more information.*/
      @query(#{ explode: true })
      `include[]`?: "step_details.tool_calls[*].file_search.results[*].content"[];
    },
    OpenAI.RunStepObject
  >;

  @tag("Assistants")
  @route("{thread_id}/runs/{run_id}/submit_tool_outputs")
  @post
  @summary("""
    When a run has the `status: "requires_action"` and `required_action.type` is `submit_tool_outputs`, this endpoint can be used to submit the outputs from the tool calls once they're all completed. All outputs must be submitted in a single request.
    
    """)
  submitToolOuputsToRun is OpenAIOperation<
    {
      /** The ID of the [thread](/docs/api-reference/threads) to which this run belongs. */
      @path
      thread_id: string;

      /** The ID of the run that requires the tool output submission. */
      @path
      run_id: string;

      @body
      body: OpenAI.SubmitToolOutputsRunRequest;
    },
    OpenAI.RunObject
  >;
}
