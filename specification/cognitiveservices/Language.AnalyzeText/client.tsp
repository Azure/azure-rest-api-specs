import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Language.Text;
using Azure.ClientGenerator.Core;

namespace Language.AnalyzeTextClientCustomizations;

@@clientName(Tasks, "TasksStatus", "csharp");
@@clientName(State, "CurrentState", "csharp");
@@clientName(Error, "AnalyzeTextError", "csharp");
@@clientName(TaskParameters, "TaskContent", "csharp");
@@clientName(PreBuiltTaskParameters, "PreBuiltTaskContent", "csharp");
@@clientName(AbstractiveSummarizationTaskParametersBase,
  "AbstractiveSummarizationTaskContentBase",
  "csharp"
);
@@clientName(CustomTaskParameters, "CustomTaskContent", "csharp");
@@clientName(CustomEntitiesTaskParameters,
  "CustomEntitiesTaskContent",
  "csharp"
);
@@clientName(CustomSingleLabelClassificationTaskParameters,
  "CustomSingleLabelClassificationTaskContent",
  "csharp"
);
@@clientName(CustomMultiLabelClassificationTaskParameters,
  "CustomMultiLabelClassificationTaskContent",
  "csharp"
);
@@clientName(DynamicClassificationTaskParameters,
  "DynamicClassificationTaskContent",
  "csharp"
);
@@clientName(EntityLinkingTaskParameters, "EntityLinkingTaskContent", "csharp");
@@clientName(Match, "EntityLinkingMatch", "csharp");
@@clientName(EntitiesTaskParameters, "EntitiesTaskContent", "csharp");
@@clientName(Entity, "NamedEntity", "csharp");
@@clientName(EntityInferenceOptions, "EntityInferenceConfig", "csharp");
@@clientName(HealthcareTaskParameters, "HealthcareTaskContent", "csharp");
@@clientName(Temporality, "HealthcareAssertionTemporality", "csharp");
@@clientName(Conditionality, "HealthcareAssertionConditionality", "csharp");
@@clientName(Certainty, "HealthcareAssertionCertainty", "csharp");
@@clientName(Association, "HealthcareAssertionAssociation", "csharp");
@@clientName(KeyPhraseTaskParameters, "KeyPhraseTaskContent", "csharp");
@@clientName(LanguageDetectionTaskParameters,
  "LanguageDetectionTaskContent",
  "csharp"
);
@@clientName(PiiTaskParameters, "PiiTaskContent", "csharp");
@@clientName(SentimentAnalysisTaskParameters,
  "SentimentAnalysisTaskContent",
  "csharp"
);
@@clientName(SentimentResponse, "SentimentResult", "csharp");
@@clientName(CustomSentimentAnalysisTaskParameters,
  "CustomSentimentAnalysisTaskContent",
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
@@clientName(CustomAbstractiveSummarizationTaskParameters,
  "CustomAbstractiveSummarizationTaskContent",
  "csharp"
);

@@clientName(AbstractiveSummarizationLROResult,
  "AbstractiveSummarizationTaskResult",
  "csharp"
);

@@clientName(ExtractiveSummarizationLROResult,
  "ExtractiveSummarizationTaskResult",
  "csharp"
);

@@clientName(CustomHealthcareTaskParameters,
  "CustomHealthcareTaskContent",
  "csharp"
);

@@clientName(AnalyzeTextLROTaskKind, "AnalyzeTextJobTaskKind", "csharp");

@@clientName(AnalyzeTextLROTask, "AnalyzeTextJobTask", "csharp");

@@clientName(AnalyzeTextLROResult, "AnalyzeTextJobTaskResult", "csharp");

@@clientName(JobState.createdDateTime, "CreatedAt", "csharp");

@@clientName(JobState.expirationDateTime, "ExpiresOn", "csharp");

@@clientName(JobState.lastUpdatedDateTime, "LastUpdatedAt", "csharp");

@@clientName(BaseEntityOverlapPolicy, "EntityOverlapPolicy", "csharp");

@@clientName(BaseTemporalMetadata, "TemporalMetadata", "csharp");

@@clientName(BaseTemporalMetadata.dateValues, "Dates", "csharp");

@@clientName(EntitiesTaskParameters.exclusionList, "Exclusions", "csharp");

@@clientName(EntitiesTaskParameters.inclusionList, "Inclusions", "csharp");

@@clientName(EntityCategory.GPE, "GeoPoliticalEntity", "csharp");

@@clientName(EntityCategory.IP, "IpAddress", "csharp");

@@clientName(EntityCategory.URL, "Uri", "csharp");

@@clientName(ErrorCode, "AnalyzeTextErrorCode", "csharp");

@@clientName(WarningCodeValue, "WarningCode", "csharp");

@@clientName(DocumentSentimentValue, "DocumentSentiment", "csharp");

@@clientName(TokenSentimentValue, "TokenSentiment", "csharp");

@@clientName(AbstractiveSummarizationLROTask,
  "AbstractiveSummarizationJobTask",
  "csharp"
);

@@clientName(ExtractiveSummarizationLROTask,
  "ExtractiveSummarizationJobTask",
  "csharp"
);

@@clientName(CustomAbstractiveSummarizationLROTask,
  "CustomAbstractiveSummarizationJobTask",
  "csharp"
);

@@clientName(CustomHealthcareLROTask, "CustomHealthcareJobTask", "csharp");

@@clientName(CustomHealthcareLROResult,
  "CustomHealthcareJobTaskResult",
  "csharp"
);

@@clientName(CustomEntitiesLROTask, "CustomEntitiesJobTask", "csharp");

@@clientName(CustomEntityRecognitionLROResult,
  "CustomEntitiesJobTaskResult",
  "csharp"
);

@@clientName(CustomSingleLabelClassificationLROTask,
  "CustomSingleLabelClassificationJobTask",
  "csharp"
);

@@clientName(CustomMultiLabelClassificationLROTask,
  "CustomMultiLabelClassificationJobTask",
  "csharp"
);

@@clientName(EntityLinkingLROTask, "EntityLinkingJobTask", "csharp");

@@clientName(EntitiesLROTask, "EntitiesJobTask", "csharp");

@@clientName(KeyPhraseLROTask, "KeyPhraseJobTask", "csharp");

@@clientName(PiiLROTask, "PiiJobTask", "csharp");

@@clientName(SentimentAnalysisLROTask, "SentimentAnalysisJobTask", "csharp");

@@clientName(CustomSentimentAnalysisLROTask,
  "CustomSentimentAnalysisJobTask",
  "csharp"
);

@@clientName(CustomSentimentAnalysisLROResult,
  "CustomSentimentAnalysisJobTaskResult",
  "csharp"
);

@@clientName(CustomSingleLabelClassificationLROResult,
  "CustomSingleLabelClassificationJobTaskResult",
  "csharp"
);

@@clientName(CustomMultiLabelClassificationLROResult,
  "CustomMultiLabelClassificationJobTaskResult",
  "csharp"
);

@@clientName(EntityLinkingLROResult, "EntityLinkingJobTaskResult", "csharp");

@@clientName(PiiEntityRecognitionLROResult,
  "PiiEntityRecognitionResult",
  "csharp"
);

@@clientName(EntityRecognitionLROResult, "EntitiesJobTaskResult", "csharp");

@@clientName(SentimentLROResult, "SentimentAnalysisJobTaskResult", "csharp");
