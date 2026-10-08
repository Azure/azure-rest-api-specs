import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "../lib/main.tsp";

using TypeSpec.Http;
using Azure.Core;
using Microsoft.Foundry.Core;

/** A minimal sample service that runs an async "widget generation" job using the shared job templates. */
@service(#{ title: "Jobs Sample" })
namespace JobsSample;

@error
model WidgetError {
  message: string;
}

model WidgetInputs {
  prompt: string;
}

model WidgetResult {
  name: string;
}

model WidgetJob is JobLike<WidgetError, WidgetResult, WidgetInputs> {
  @visibility(Lifecycle.Read)
  createdAt: FoundryTimestamp;
}

interface WidgetJobs {
  @route("/widget-jobs")
  @pollingOperation(WidgetJobs.get)
  create is StandardOperations.PostJob<WidgetJob, WidgetError>;

  @route("/widget-jobs/{jobId}")
  get is StandardOperations.QueryJobStatus<WidgetJob, WidgetError>;

  @route("/widget-jobs")
  list is StandardOperations.ListJobs<WidgetJob, WidgetError>;

  @route("/widget-jobs/{jobId}:cancel")
  cancel is StandardOperations.CancelJob<WidgetJob, WidgetError>;

  @route("/widget-jobs/{jobId}")
  delete is StandardOperations.DeleteJob<WidgetError>;
}
