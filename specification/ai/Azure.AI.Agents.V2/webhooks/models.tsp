import "@typespec/openapi";
using TypeSpec.OpenAPI;
namespace OpenAI;
/** Sent when a batch API request has been cancelled. */
@summary("batch.cancelled")
@extension(
  "x-oaiMeta",
  #{
    name: "batch.cancelled",
    group: "webhook-events",
    example: "{\n  \"id\": \"evt_abc123\",\n  \"type\": \"batch.cancelled\",\n  \"created_at\": 1719168000,\n  \"data\": {\n    \"id\": \"batch_abc123\"\n  }\n}\n",
  }
)
model WebhookBatchCancelled {
  /** The Unix timestamp (in seconds) of when the batch API request was cancelled. */
  created_at: integer;

  /** The unique ID of the event. */
  id: string;

  /** Event data payload. */
  data: {
    id: string;
  };

  /** The object of the event. Always `event`. */
  @extension("x-stainless-const", true)
  object?: "event";

  /** The type of the event. Always `batch.cancelled`. */
  @extension("x-stainless-const", true)
  type: "batch.cancelled";
}

/** Sent when a batch API request has been completed. */
@summary("batch.completed")
@extension(
  "x-oaiMeta",
  #{
    name: "batch.completed",
    group: "webhook-events",
    example: "{\n  \"id\": \"evt_abc123\",\n  \"type\": \"batch.completed\",\n  \"created_at\": 1719168000,\n  \"data\": {\n    \"id\": \"batch_abc123\"\n  }\n}\n",
  }
)
model WebhookBatchCompleted {
  /** The Unix timestamp (in seconds) of when the batch API request was completed. */
  created_at: integer;

  /** The unique ID of the event. */
  id: string;

  /** Event data payload. */
  data: {
    id: string;
  };

  /** The object of the event. Always `event`. */
  @extension("x-stainless-const", true)
  object?: "event";

  /** The type of the event. Always `batch.completed`. */
  @extension("x-stainless-const", true)
  type: "batch.completed";
}

/** Sent when a batch API request has expired. */
@summary("batch.expired")
@extension(
  "x-oaiMeta",
  #{
    name: "batch.expired",
    group: "webhook-events",
    example: "{\n  \"id\": \"evt_abc123\",\n  \"type\": \"batch.expired\",\n  \"created_at\": 1719168000,\n  \"data\": {\n    \"id\": \"batch_abc123\"\n  }\n}\n",
  }
)
model WebhookBatchExpired {
  /** The Unix timestamp (in seconds) of when the batch API request expired. */
  created_at: integer;

  /** The unique ID of the event. */
  id: string;

  /** Event data payload. */
  data: {
    id: string;
  };

  /** The object of the event. Always `event`. */
  @extension("x-stainless-const", true)
  object?: "event";

  /** The type of the event. Always `batch.expired`. */
  @extension("x-stainless-const", true)
  type: "batch.expired";
}

/** Sent when a batch API request has failed. */
@summary("batch.failed")
@extension(
  "x-oaiMeta",
  #{
    name: "batch.failed",
    group: "webhook-events",
    example: "{\n  \"id\": \"evt_abc123\",\n  \"type\": \"batch.failed\",\n  \"created_at\": 1719168000,\n  \"data\": {\n    \"id\": \"batch_abc123\"\n  }\n}\n",
  }
)
model WebhookBatchFailed {
  /** The Unix timestamp (in seconds) of when the batch API request failed. */
  created_at: integer;

  /** The unique ID of the event. */
  id: string;

  /** Event data payload. */
  data: {
    id: string;
  };

  /** The object of the event. Always `event`. */
  @extension("x-stainless-const", true)
  object?: "event";

  /** The type of the event. Always `batch.failed`. */
  @extension("x-stainless-const", true)
  type: "batch.failed";
}

/** Sent when an eval run has been canceled. */
@summary("eval.run.canceled")
@extension(
  "x-oaiMeta",
  #{
    name: "eval.run.canceled",
    group: "webhook-events",
    example: "{\n  \"id\": \"evt_abc123\",\n  \"type\": \"eval.run.canceled\",\n  \"created_at\": 1719168000,\n  \"data\": {\n    \"id\": \"evalrun_abc123\"\n  }\n} \n",
  }
)
model WebhookEvalRunCanceled {
  /** The Unix timestamp (in seconds) of when the eval run was canceled. */
  created_at: integer;

  /** The unique ID of the event. */
  id: string;

  /** Event data payload. */
  data: {
    id: string;
  };

  /** The object of the event. Always `event`. */
  @extension("x-stainless-const", true)
  object?: "event";

  /** The type of the event. Always `eval.run.canceled`. */
  @extension("x-stainless-const", true)
  type: "eval.run.canceled";
}

/** Sent when an eval run has failed. */
@summary("eval.run.failed")
@extension(
  "x-oaiMeta",
  #{
    name: "eval.run.failed",
    group: "webhook-events",
    example: "{\n  \"id\": \"evt_abc123\",\n  \"type\": \"eval.run.failed\",\n  \"created_at\": 1719168000,\n  \"data\": {\n    \"id\": \"evalrun_abc123\"\n  }\n} \n",
  }
)
model WebhookEvalRunFailed {
  /** The Unix timestamp (in seconds) of when the eval run failed. */
  created_at: integer;

  /** The unique ID of the event. */
  id: string;

  /** Event data payload. */
  data: {
    id: string;
  };

  /** The object of the event. Always `event`. */
  @extension("x-stainless-const", true)
  object?: "event";

  /** The type of the event. Always `eval.run.failed`. */
  @extension("x-stainless-const", true)
  type: "eval.run.failed";
}

/** Sent when an eval run has succeeded. */
@summary("eval.run.succeeded")
@extension(
  "x-oaiMeta",
  #{
    name: "eval.run.succeeded",
    group: "webhook-events",
    example: "{\n  \"id\": \"evt_abc123\",\n  \"type\": \"eval.run.succeeded\",\n  \"created_at\": 1719168000,\n  \"data\": {\n    \"id\": \"evalrun_abc123\"\n  }\n} \n",
  }
)
model WebhookEvalRunSucceeded {
  /** The Unix timestamp (in seconds) of when the eval run succeeded. */
  created_at: integer;

  /** The unique ID of the event. */
  id: string;

  /** Event data payload. */
  data: {
    id: string;
  };

  /** The object of the event. Always `event`. */
  @extension("x-stainless-const", true)
  object?: "event";

  /** The type of the event. Always `eval.run.succeeded`. */
  @extension("x-stainless-const", true)
  type: "eval.run.succeeded";
}

/** Sent when a fine-tuning job has been cancelled. */
@summary("fine_tuning.job.cancelled")
@extension(
  "x-oaiMeta",
  #{
    name: "fine_tuning.job.cancelled",
    group: "webhook-events",
    example: "{\n  \"id\": \"evt_abc123\",\n  \"type\": \"fine_tuning.job.cancelled\",\n  \"created_at\": 1719168000,\n  \"data\": {\n    \"id\": \"ftjob_abc123\"\n  }\n} \n",
  }
)
model WebhookFineTuningJobCancelled {
  /** The Unix timestamp (in seconds) of when the fine-tuning job was cancelled. */
  created_at: integer;

  /** The unique ID of the event. */
  id: string;

  /** Event data payload. */
  data: {
    id: string;
  };

  /** The object of the event. Always `event`. */
  @extension("x-stainless-const", true)
  object?: "event";

  /** The type of the event. Always `fine_tuning.job.cancelled`. */
  @extension("x-stainless-const", true)
  type: "fine_tuning.job.cancelled";
}

/** Sent when a fine-tuning job has failed. */
@summary("fine_tuning.job.failed")
@extension(
  "x-oaiMeta",
  #{
    name: "fine_tuning.job.failed",
    group: "webhook-events",
    example: "{\n  \"id\": \"evt_abc123\",\n  \"type\": \"fine_tuning.job.failed\",\n  \"created_at\": 1719168000,\n  \"data\": {\n    \"id\": \"ftjob_abc123\"\n  }\n} \n",
  }
)
model WebhookFineTuningJobFailed {
  /** The Unix timestamp (in seconds) of when the fine-tuning job failed. */
  created_at: integer;

  /** The unique ID of the event. */
  id: string;

  /** Event data payload. */
  data: {
    id: string;
  };

  /** The object of the event. Always `event`. */
  @extension("x-stainless-const", true)
  object?: "event";

  /** The type of the event. Always `fine_tuning.job.failed`. */
  @extension("x-stainless-const", true)
  type: "fine_tuning.job.failed";
}

/** Sent when a fine-tuning job has succeeded. */
@summary("fine_tuning.job.succeeded")
@extension(
  "x-oaiMeta",
  #{
    name: "fine_tuning.job.succeeded",
    group: "webhook-events",
    example: "{\n  \"id\": \"evt_abc123\",\n  \"type\": \"fine_tuning.job.succeeded\",\n  \"created_at\": 1719168000,\n  \"data\": {\n    \"id\": \"ftjob_abc123\"\n  }\n} \n",
  }
)
model WebhookFineTuningJobSucceeded {
  /** The Unix timestamp (in seconds) of when the fine-tuning job succeeded. */
  created_at: integer;

  /** The unique ID of the event. */
  id: string;

  /** Event data payload. */
  data: {
    id: string;
  };

  /** The object of the event. Always `event`. */
  @extension("x-stainless-const", true)
  object?: "event";

  /** The type of the event. Always `fine_tuning.job.succeeded`. */
  @extension("x-stainless-const", true)
  type: "fine_tuning.job.succeeded";
}

/** Sent when Realtime API Receives a incoming SIP call. */
@summary("realtime.call.incoming")
@extension(
  "x-oaiMeta",
  #{
    name: "realtime.call.incoming",
    group: "webhook-events",
    example: "{\n  \"id\": \"evt_abc123\",\n  \"type\": \"realtime.call.incoming\",\n  \"created_at\": 1719168000,\n  \"data\": {\n    \"call_id\": \"rtc_479a275623b54bdb9b6fbae2f7cbd408\",\n    \"sip_headers\": [\n      {\"name\": \"Max-Forwards\", \"value\": \"63\"},\n      {\"name\": \"CSeq\", \"value\": \"851287 INVITE\"},\n      {\"name\": \"Content-Type\", \"value\": \"application/sdp\"},\n    ]\n  }\n}\n",
  }
)
model WebhookRealtimeCallIncoming {
  /** The Unix timestamp (in seconds) of when the model response was completed. */
  created_at: integer;

  /** The unique ID of the event. */
  id: string;

  /** Event data payload. */
  data: {
    call_id: string;
    sip_headers: {
      name: string;
      value: string;
    }[];
  };

  /** The object of the event. Always `event`. */
  @extension("x-stainless-const", true)
  object?: "event";

  /** The type of the event. Always `realtime.call.incoming`. */
  @extension("x-stainless-const", true)
  type: "realtime.call.incoming";
}

/** Sent when a background response has been cancelled. */
@summary("response.cancelled")
@extension(
  "x-oaiMeta",
  #{
    name: "response.cancelled",
    group: "webhook-events",
    example: "{\n  \"id\": \"evt_abc123\",\n  \"type\": \"response.cancelled\",\n  \"created_at\": 1719168000,\n  \"data\": {\n    \"id\": \"resp_abc123\"\n  }\n}\n",
  }
)
model WebhookResponseCancelled {
  /** The Unix timestamp (in seconds) of when the model response was cancelled. */
  created_at: integer;

  /** The unique ID of the event. */
  id: string;

  /** Event data payload. */
  data: {
    id: string;
  };

  /** The object of the event. Always `event`. */
  @extension("x-stainless-const", true)
  object?: "event";

  /** The type of the event. Always `response.cancelled`. */
  @extension("x-stainless-const", true)
  type: "response.cancelled";
}

/** Sent when a background response has been completed. */
@summary("response.completed")
@extension(
  "x-oaiMeta",
  #{
    name: "response.completed",
    group: "webhook-events",
    example: "{\n  \"id\": \"evt_abc123\",\n  \"type\": \"response.completed\",\n  \"created_at\": 1719168000,\n  \"data\": {\n    \"id\": \"resp_abc123\"\n  }\n}\n",
  }
)
model WebhookResponseCompleted {
  /** The Unix timestamp (in seconds) of when the model response was completed. */
  created_at: integer;

  /** The unique ID of the event. */
  id: string;

  /** Event data payload. */
  data: {
    id: string;
  };

  /** The object of the event. Always `event`. */
  @extension("x-stainless-const", true)
  object?: "event";

  /** The type of the event. Always `response.completed`. */
  @extension("x-stainless-const", true)
  type: "response.completed";
}

/** Sent when a background response has failed. */
@summary("response.failed")
@extension(
  "x-oaiMeta",
  #{
    name: "response.failed",
    group: "webhook-events",
    example: "{\n  \"id\": \"evt_abc123\",\n  \"type\": \"response.failed\",\n  \"created_at\": 1719168000,\n  \"data\": {\n    \"id\": \"resp_abc123\"\n  }\n}\n",
  }
)
model WebhookResponseFailed {
  /** The Unix timestamp (in seconds) of when the model response failed. */
  created_at: integer;

  /** The unique ID of the event. */
  id: string;

  /** Event data payload. */
  data: {
    id: string;
  };

  /** The object of the event. Always `event`. */
  @extension("x-stainless-const", true)
  object?: "event";

  /** The type of the event. Always `response.failed`. */
  @extension("x-stainless-const", true)
  type: "response.failed";
}

/** Sent when a background response has been interrupted. */
@summary("response.incomplete")
@extension(
  "x-oaiMeta",
  #{
    name: "response.incomplete",
    group: "webhook-events",
    example: "{\n  \"id\": \"evt_abc123\",\n  \"type\": \"response.incomplete\",\n  \"created_at\": 1719168000,\n  \"data\": {\n    \"id\": \"resp_abc123\"\n  }\n}\n",
  }
)
model WebhookResponseIncomplete {
  /** The Unix timestamp (in seconds) of when the model response was interrupted. */
  created_at: integer;

  /** The unique ID of the event. */
  id: string;

  /** Event data payload. */
  data: {
    id: string;
  };

  /** The object of the event. Always `event`. */
  @extension("x-stainless-const", true)
  object?: "event";

  /** The type of the event. Always `response.incomplete`. */
  @extension("x-stainless-const", true)
  type: "response.incomplete";
}
