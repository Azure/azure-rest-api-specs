import "@azure-tools/typespec-azure-core";
import "@typespec/rest";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace FoundryLocal.AgenticRAG;

/** Operations for managing conversation threads. */
interface ThreadsOperationGroup {
  /** Creates a new conversation thread. */
  @summary("Create Thread")
  @route("/threads")
  @post
  createThread is Azure.Core.RpcOperation<CreateThreadRequest, Thread>;

  /**
   * Lists all conversation threads with cursor-based pagination. Returns only
   * threads owned by the authenticated user.
   */
  @summary("List Threads")
  @route("/threads")
  @get
  listThreads is Azure.Core.RpcOperation<
    {
      /** Maximum number of threads to return. */
      @maxValue(100)
      @minValue(1)
      @query("limit")
      limit?: int32 = 20;

      /** Sort order by created_at. */
      @query("order")
      order?: SortOrder;

      /** Cursor - return threads after this ID. */
      @query("after")
      after?: string;

      /** Cursor - return threads before this ID. */
      @query("before")
      before?: string;
    },
    ThreadList
  >;

  /** Get Thread */
  @summary("Get Thread")
  @route("/threads/{threadId}")
  @get
  getThread is Azure.Core.RpcOperation<
    {
      /** Unique thread identifier (format: thread_{uuid}). */
      @path
      threadId: string;
    },
    Thread
  >;

  /** Modify Thread */
  @summary("Modify Thread")
  @route("/threads/{threadId}")
  @post
  modifyThread is Azure.Core.RpcOperation<
    {
      /** Unique thread identifier. */
      @path
      threadId: string;

      /** The request body containing fields to update. */
      @bodyRoot
      body: ModifyThreadRequest;
    },
    Thread
  >;

  /** Delete Thread */
  @summary("Delete Thread")
  @route("/threads/{threadId}")
  @delete
  deleteThread is Azure.Core.RpcOperation<
    {
      /** Unique thread identifier. */
      @path
      threadId: string;
    },
    DeleteResponse
  >;
}

/** Operations for managing messages within threads. */
interface MessagesOperationGroup {
  /** Create Message */
  @summary("Create Message")
  @route("/threads/{threadId}/messages")
  @post
  createMessage is Azure.Core.RpcOperation<
    {
      /** The thread identifier to add the message to. */
      @path
      threadId: string;

      /** The request body for the new message. */
      @bodyRoot
      body: CreateMessageRequest;
    },
    Message
  >;

  /** List Messages */
  @summary("List Messages")
  @route("/threads/{threadId}/messages")
  @get
  listMessages is Azure.Core.RpcOperation<
    {
      /** The thread identifier to list messages from. */
      @path
      threadId: string;

      /** Maximum number of messages to return. */
      @maxValue(100)
      @minValue(1)
      @query("limit")
      limit?: int32 = 20;

      /** Sort order by created_at. */
      @query("order")
      order?: SortOrder;

      /** Cursor - return messages after this ID. */
      @query("after")
      after?: string;

      /** Cursor - return messages before this ID. */
      @query("before")
      before?: string;
    },
    MessageList
  >;

  /** Get Message */
  @summary("Get Message")
  @route("/threads/{threadId}/messages/{messageId}")
  @get
  getMessage is Azure.Core.RpcOperation<
    {
      /** The thread identifier. */
      @path
      threadId: string;

      /** Unique message identifier (format: msg_{uuid}). */
      @path
      messageId: string;
    },
    Message
  >;

  /** Delete Message */
  @summary("Delete Message")
  @route("/threads/{threadId}/messages/{messageId}")
  @delete
  deleteMessage is Azure.Core.RpcOperation<
    {
      /** The thread identifier. */
      @path
      threadId: string;

      /** The message identifier to delete. */
      @path
      messageId: string;
    },
    DeleteResponse
  >;
}

/** Operations for managing runs on threads. */
interface RunsOperationGroup {
  /**
   * Creates and executes a run against a thread. Supports synchronous and streaming
   * (SSE) modes. When `stream=true`, the response is returned as a server-sent events
   * (text/event-stream) stream instead of a single JSON object.
   */
  @summary("Create Run")
  @route("/threads/{threadId}/runs")
  @post
  createRun is Azure.Core.RpcOperation<
    {
      /** The thread identifier to run against. */
      @path
      threadId: string;

      /** When true, returns SSE stream. */
      @query("stream")
      stream?: boolean;

      /** The request body for the new run. */
      @bodyRoot
      body: CreateRunRequest;
    },
    Run
  >;

  /** Get Run */
  @summary("Get Run")
  @route("/threads/{threadId}/runs/{runId}")
  @get
  getRun is Azure.Core.RpcOperation<
    {
      /** The thread identifier. */
      @path
      threadId: string;

      /** Unique run identifier (format: run_{uuid}). */
      @path
      runId: string;
    },
    Run
  >;

  /** Cancel Run */
  @summary("Cancel Run")
  @route("/threads/{threadId}/runs/{runId}/cancel")
  @post
  cancelRun is Azure.Core.RpcOperation<
    {
      /** The thread identifier. */
      @path
      threadId: string;

      /** The run identifier to cancel. */
      @path
      runId: string;
    },
    Run
  >;
}

/** Operations for listing and retrieving run steps. */
interface RunStepsOperationGroup {
  /** List Run Steps */
  @summary("List Run Steps")
  @route("/threads/{threadId}/runs/{runId}/steps")
  @get
  listRunSteps is Azure.Core.RpcOperation<
    {
      /** The thread identifier. */
      @path
      threadId: string;

      /** The run identifier. */
      @path
      runId: string;

      /** Maximum number of steps to return. */
      @maxValue(100)
      @minValue(1)
      @query("limit")
      limit?: int32 = 20;

      /** Sort order by created_at. */
      @query("order")
      order?: SortOrder;

      /** Cursor - return steps after this ID. */
      @query("after")
      after?: string;

      /** Cursor - return steps before this ID. */
      @query("before")
      before?: string;
    },
    RunStepList
  >;

  /** Get Run Step */
  @summary("Get Run Step")
  @route("/threads/{threadId}/runs/{runId}/steps/{stepId}")
  @get
  getRunStep is Azure.Core.RpcOperation<
    {
      /** The thread identifier. */
      @path
      threadId: string;

      /** The run identifier. */
      @path
      runId: string;

      /** Unique step identifier (format: step_{uuid}). */
      @path
      stepId: string;
    },
    RunStep
  >;
}
