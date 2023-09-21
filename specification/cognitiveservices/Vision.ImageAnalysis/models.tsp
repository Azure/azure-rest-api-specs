import "@typespec/http";

namespace ImageAnalysis;
using TypeSpec.Http;

@doc("A basic rectangle")
model BoundingBox {
  @doc("X coordinate")
  x: int64;

  @doc("Y coordinate")
  y: int64;

  @doc("Width of the box")
  w: int64;

  @doc("Height of the box")
  h: int64;
}

@doc("A brief description of what the image depicts.")
model CaptionResult {
  @doc("The level of confidence the service has in the caption.")
  confidence: float64;

  @doc("The text of the caption.")
  text: string;
}

@doc("A region identified for smart cropping. There will be one region returned for each requested aspect ratio.")
model CropRegion {
  @doc("The aspect ratio of the crop region.")
  aspectRatio: float64;

  @doc("The bounding box of the crop region.")
  boundingBox: BoundingBox;
}

@doc("A brief description of what the image depicts.")
model DenseCaption {
  @doc("The level of confidence the service has in the caption.")
  confidence: float64;

  @doc("The text of the caption.")
  text: string;

  @doc("The bounding box of the caption.")
  boundingBox: BoundingBox;
}

@doc("A list of captions.")
model DenseCaptionsResult {
  @doc("The list of captions.")
  values: Array<DenseCaption>;
}

@doc("Describes a detected object in an image.")
model DetectedObject {
  @doc("Gets a rectangular boundary within which the object was detected.")
  boundingBox: BoundingBox;

  @doc("Classification confidences of the detected object.")
  tags: Array<Tag>;
}

@doc("Represents a person detected in an image")
model DetectedPerson {
  @doc("Gets a rectangular boundary within which the person was detected.")
  @visibility("read")
  boundingBox: BoundingBox;

  @doc("Gets the confidence value of the detected person.")
  @visibility("read")
  confidence: float64;
}

@doc("A content line object consisting of an adjacent sequence of content elements, such as words and selection marks.")
model DocumentLine {
  @doc("The bounding box of the line.")
  boundingBox: Array<float64>;

  @doc("Concatenated content of the contained elements in reading order.")
  content: string;

  @doc("Location of the line in the reading order concatenated content.")
  spans: Array<DocumentSpan>;
}

@doc("The content and layout elements extracted from a page from the input.")
model DocumentPage {
  @doc("The general orientation of the content in clockwise direction, measured in degrees between (-180, 180].")
  angle: float64;

  @doc("The height of the image/PDF in pixels/inches, respectively.")
  height: float64;

  @doc("Extracted lines from the page, potentially containing both textual and visual elements.")
  lines: Array<DocumentLine>;

  @doc("1-based page number in the input document.")
  pageNumber: int64;

  @doc("Location of the page in the reading order concatenated content.")
  spans: Array<DocumentSpan>;

  @doc("The width of the image/PDF in pixels/inches, respectively.")
  width: float64;

  @doc("Extracted words from the page.")
  words: Array<DocumentWord>;
}

@doc("Contiguous region of the concatenated content property, specified as an offset and length.")
model DocumentSpan {
  @doc("Number of characters in the content represented by the span.")
  length: int64;

  @doc("Zero-based index of the content represented by the span.")
  offset: int64;
}

@doc("An object representing observed text styles.")
model DocumentStyle {
  @doc("Confidence of correctly identifying the style.")
  confidence: float64;

  @doc("Is content handwritten or not.")
  isHandwritten: boolean;

  @doc("Location of the text elements in the concatenated content the style applies to.")
  spans: Array<DocumentSpan>;
}

@doc("A word object consisting of a contiguous sequence of characters. For non-space delimited languages,\r\nsuch as Chinese, Japanese, and Korean, each character is represented as its own word.")
model DocumentWord {
  @doc("Bounding box of the word.")
  boundingBox: Array<float64>;

  @doc("Confidence of correctly extracting the word.")
  confidence: float64;

  @doc("Text content of the word.")
  content: string;

  @doc("Location of the word in the reading order concatenated content.")
  span: DocumentSpan;
}

@doc("Describe the combined results of different types of image analysis.")
model ImageAnalysisResult {
  @doc("A CaptionResult for the image.")
  captionResult?: CaptionResult;

  @doc("A list of categories for the image.")
  customModelResult?: ImagePredictionResult;

  @doc("A denseCaptionsResult for the image.")
  denseCaptionsResult?: DenseCaptionsResult;

  @doc("The model used for the analysis")
  metadata: ImageMetadataApiModel;

  @doc("The model used for the analysis")
  modelVersion: string;

  @doc("A list of objects for the image.")
  objectsResult?: ObjectsResult;

  @doc("A list of people for the image.")
  peopleResult?: PeopleResult;

  @doc("A readResult for the image.")
  readResult?: ReadResult;

  @doc("A list of regions for the image.")
  smartCropsResult?: SmartCropsResult;

  @doc("A list of tags for the image.")
  tagsResult?: TagsResult;
}

@doc("The image metadata information such as height and width.")
model ImageMetadata {
  @doc("The height of the image in pixels.")
  height: int64;

  @doc("The width of the image in pixels.")
  width: int64;
}

@doc("Describes the prediction result of an image.")
model ImagePredictionResult {
  @doc("The list of predicted objects.")
  objectsResult: ObjectsResult;

  @doc("The list of predicted tags.")
  tagsResult: TagsResult;
}

@doc("Describes detected objects in an image.")
model ObjectsResult {
  @doc("An array of detected objects.")
  values: Array<DetectedObject>;
}

@doc("An object describing whether the image contains people.")
model PeopleResult {
  @doc("An array of detected people.")
  values: Array<DetectedPerson>;
}

@doc("The results of an Read operation.")
model ReadResult {
  @doc("Concatenate string representation of all textual and visual elements in reading order.")
  content: string;

  @doc("A list of analyzed pages.")
  pages: Array<DocumentPage>;

  @doc("The method used to compute string offset and length, possible values include: 'textElements', 'unicodeCodePoint', 'utf16CodeUnit' etc.")
  stringIndexType: string;

  @doc("Extracted font styles.")
  styles: Array<DocumentStyle>;
}

@doc("Smart cropping result.")
model SmartCropsResult {
  @doc("Recommended regions for cropping the image.")
  values: Array<CropRegion>;
}

@doc("An entity observation in the image, along with the confidence score.")
model Tag {
  @doc("The level of confidence that the entity was observed.")
  confidence: float64;

  @doc("Name of the entity.")
  name: string;
}

@doc("A list of tags with confidence level.")
model TagsResult {
  @doc("A list of tags with confidence level.")
  values: Array<Tag>;
}

@doc("Represents the configuration options that control the function of the ImageAnalyzer")
model ImageAnalysisClientOptions {
  @query("model-name")
  @doc("The name of the custom trained model. This parameter needs to be specified if the parameter \"features\" is not specified.")
  modelName?: string;

  @query("language")
  @doc("The desired language for output generation. If this parameter is not specified, the default value is \"en\". See https://aka.ms/cv-languages for a list of supported languages.")
  language?: string = "en";

  @query("smartcrops-aspect-ratios")
  @doc("A list of aspect ratios to use for smartCrops feature. Aspect ratios are calculated by dividing the target crop width by the height. Supported values are between 0.75 and 1.8 (inclusive). Multiple values should be comma-separated. If this parameter is not specified, the service will return one crop suggestion with an aspect ratio it sees fit between 0.5 and 2.0 (inclusive).")
  smartCropsAspectRatios?: string;

  @query("gender-neutral-caption")
  @doc("Boolean flag for enabling gender-neutral captioning for caption and denseCaptions features. If this parameter is not specified, the default value is \"false\".")
  genderNeutralCaption?: boolean = false;
}

@doc("The visual features requested: tags, objects, caption, denseCaptions, read, smartCrops, people. This parameter needs to be specified if the parameter \"model-name\" is not specified.")
enum visualFeatures{
  @doc("Tags")
  "tags",
  @doc("Caption")
  "caption",
  @doc("DenseCaptions")
  "denseCaptions",
  @doc("Objects")
  "objects",
  @doc("Read")
  "read",
  @doc("SmartCrops")
  "smartCrops",
  @doc("People")
  "people"
}

@doc("A JSON document with a URL pointing to the image that is to be analyzed.")
model ImageUrl{
  @doc("Publicly reachable URL of an image.")
  url:url;
}