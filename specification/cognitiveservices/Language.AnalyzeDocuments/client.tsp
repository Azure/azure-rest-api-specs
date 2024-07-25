import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Language.AnalyzeDocuments;
using Azure.ClientGenerator.Core;

namespace Language.AnalyzeDocumentsClientCustomizations;

@@clientName(Tasks, "TasksStatus", "csharp");
@@clientName(State, "CurrentState", "csharp");
@@clientName(Error, "AnalyzeDocumentsError", "csharp");
@@clientName(TaskParameters, "TaskContent", "csharp");
@@clientName(PreBuiltTaskParameters, "PreBuiltTaskContent", "csharp");
@@clientName(AbstractiveSummarizationTaskParametersBase,
  "AbstractiveSummarizationTaskContentBase",
  "csharp"
);

@@clientName(ExtractiveSummarizationTaskParameters,
  "ExtractiveSummarizationTaskContent",
  "csharp"
);
@@clientName(AbstractiveSummarizationTaskParameters,
  "AbstractiveSummarizationTaskContent",
  "csharp"
);
