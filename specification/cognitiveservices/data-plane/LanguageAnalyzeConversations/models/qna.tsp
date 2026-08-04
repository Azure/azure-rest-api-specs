import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Language.Conversations;

/** This is a set of request parameters for Question Answering knowledge bases. */
model QuestionAnsweringParameters extends AnalysisParameters {
  /** This is a set of request parameters for Question Answering knowledge bases. */
  targetProjectKind: targetProjectKind.QuestionAnswering;

  /** The options sent to a Question Answering KB. */
  callingOptions?: AnswersOptions;
}

/** It is a wrap up a Question Answering KB response. */
model QuestionAnsweringTargetIntentResult extends TargetIntentResult {
  /** It is a wrap up a Question Answering KB response. */
  targetProjectKind: targetProjectKind.QuestionAnswering;

  /** The generated answer by a Question Answering KB. */
  result?: AnswersResult;
}
