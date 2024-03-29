import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "Ocp-Apim-Subscription-Key"> | OAuth2Auth<[
    {
      type: OAuth2FlowType.clientCredentials,
      tokenUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/token",
      refreshUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/token",
      scopes: ["https://cognitiveservices.azure.com/.default"],
    }
  ]>
)
@service({
  title: "Speech Ingestion service",
})
@versioned(Speech.Ingestion.Versions)
namespace Speech.Ingestion;

@doc("The SpeechIngestion service versions.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("The 2024-05-15-preview version of the SpeechIngestion service.")
  `2024-05-15-preview`,
}

@doc("A registration.")
@resource("registrations")
model Registration {
  @key("name")
  @visibility("read")
  @doc("The unique name of the registration resource.")
  name: string;

  @doc("Storage configuration.")
  storage: StorageModel;

  @doc("Processing configuration.")
  processing: ProcessingModel;

  @doc("Batch transcription configuration.")
  batchTranscription: BatchTranscriptionPropertiesModel;

  @doc("Analytics configuration.")
  analytics?: AnalyticsModel;

  @doc("Status of the registration.")
  @visibility("read")
  status: StatusModel;
}

@doc("Storage model")
model StorageModel {
  @doc("The Uri of the blob storage account in the form of 'https://<accountname>.blob.core.windows.net'.")
  blobStorageEndpoint: string;
  
  @doc("The name of the container that holds the audio files to be processed.")
  inputContainerName: string;
  
  @doc("The name of the container that stores the transcription and analytics results.")
  outputContainerName: string;
  
  @doc("The name of the container that archives the audio files that have been transcribed.")
  processedContainerName: string;
  
  @doc("The name of the container that saves the error messages during processing.")
  errorOutputContainerName: string;
}

@doc("Processing model")
model ProcessingModel {
  @doc("deliveryMode.")
  deliveryMode: string;
  
  @doc("Extensions of input files.")
  subjectEndsWith?: string;
  
  @doc("ResourceId for System Topic.")
  systemTopicResourceId?: string;
}

@doc("Batch Transcription Properties model")
model BatchTranscriptionPropertiesModel {

  @doc("The expected locale of the audio data to transcribe. For example, 'en-US', 'fr-FR', 'zh-CN', etc. For a full list of supported locales, see [Supported languages and regions](https://learn.microsoft.com/azure/ai-services/speech-service/language-support?tabs=stt).")
  locale?: string;

  @doc("The model property to use a specific base model or Custom Speech model. If you don't specify the model, the default base model for the locale is used.")
  modelX?: EntityReferenceModel;

  @doc("Custom domain name for batch transcription.")
  customDomain: string;

  @doc("The transcription batch API properties that allow you to customize the transcription process. For more information, see [Request configuration options](https://learn.microsoft.com/en-us/azure/ai-services/speech-service/batch-transcription-create?pivots=rest-api#request-configuration-options).")
  transcriptionProperties?: TranscriptionPropertiesModel;
}

@doc("Batch Transcription Properties model")
model TranscriptionPropertiesModel {
  @doc("Specifies if word level timestamps should be included in the output. The default value is false.")
  wordLevelTimestampsEnabled?: boolean = false; 

  @doc("Specifies whether to include word-level timestamps on the display form of the transcription results. The results are returned in the displayWords property of the transcription file. The default value is false.")
  displayFormWordLevelTimestampsEnabled?: boolean = false; 

  @doc("An array of channel numbers to process. Channels 0 and 1 are transcribed by default.")
  channels?: int8[] = [0, 1];

  @doc("Specifies how to handle punctuation in recognition results. Accepted values are None to disable punctuation, Dictated to imply explicit (spoken) punctuation, Automatic to let the decoder deal with punctuation, or DictatedAndAutomatic to use dictated and automatic punctuation. The default value is DictatedAndAutomatic.")
  punctuationMode?: string = "DictatedAndAutomatic";

  @doc("Specifies how to handle profanity in recognition results. Accepted values are None to disable profanity filtering, Masked to replace profanity with asterisks, Removed to remove all profanity from the result, or Tags to add profanity tags. The default value is Masked.")
  profanityFilterMode?: string = "Masked";

  @doc("Specifies that the Speech service should attempt diarization analysis on the input, which is expected to be a mono channel that contains two voices. The default value is false.")
  diarizationEnabled?: boolean = false;

  @doc("Indicates that the Speech service should attempt diarization analysis on the input, which is expected to be a mono channel that contains multiple voices. The feature isn't available with stereo recordings.")
  diarization?: DiarizationPropertiesModel;

  @doc("Language identification is used to identify languages spoken in audio when compared against a list of supported languages. https://learn.microsoft.com/azure/ai-services/speech-service/language-support?tabs=language-identification")
  languageIdentification?: LanguageIdentificationPropertiesModel;
}

@doc("DiarizationProperties model")
model DiarizationPropertiesModel {
  @doc("speakers properties.")
  speakers: DiarizationSpeakersPropertiesModel;
}

@doc("DiarizationSpeakersProperties model")
model DiarizationSpeakersPropertiesModel {
  @doc("Minimum count of speakers")
  minCount?: int8;
  @doc("Maximum count of speakers")
  maxCount?: int8;
}

@doc("LanguageIdentificationProperties model")
model LanguageIdentificationPropertiesModel {
  @doc("mode")
  mode: string;

  @doc("candidateLocales.")
  candidateLocales: string[];

  @doc("speechModelMapping")
  speechModelMapping?: Record<EntityReferenceModel>;
}

@doc("Analytics model")
model AnalyticsModel {
  @doc("The analytics endpoint to call.")
  endpoint: string;
}

@doc("Status model")
model StatusModel {
  @doc("Status code.")
  code: string;

  @doc("Message.")
  message?: string;
}

@doc("Entity ReferenceModel model")
model EntityReferenceModel {
  @doc("self.")
  self: string;
}

interface Registrations {
  @doc("Fetch a Registration by name.")
  getRegistration is ResourceRead<Registration>;

  @doc("Creates or replaces a Registration.")
  createOrReplaceRegistration is ResourceCreateOrReplace<Registration>;

  @doc("Delete a Registration.")
  deleteRegistration is ResourceDelete<Registration>;

  @doc("List Registration resources")
  listRegistrations is ResourceList<Registration>;
}

