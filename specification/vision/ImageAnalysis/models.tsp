import "@typespec/http";

namespace ImageAnalysis;
using TypeSpec.Http;

@doc("A basic rectangle")
model ImageBoundingBox {
  @doc("X coordinate")
  @minValue(0)
  x: int32;

  @doc("Y coordinate")
  @minValue(0)
  y: int32;

  @doc("Width of the box")
  @minValue(0)
  @projectedName("json", "w")
  width: int32;

  @doc("Height of the box")
  @minValue(0)
  @projectedName("json", "h")
  height: int32;
}

@doc("A brief description of what the image depicts.")
model CaptionResult {
  @doc("The level of confidence the service has in the caption.")
  @minValue(0.0)
  @maxValue(1.0)
  confidence: float32;

  @doc("The text of the caption.")
  @minLength(1)
  text: string;
}

@doc("A region identified for smart cropping. There will be one region returned for each requested aspect ratio.")
model CropRegion {
  @doc("The aspect ratio of the crop region.")
  @minValue(0.0)
  aspectRatio: float32;

  @doc("The bounding box of the crop region.")
  boundingBox: ImageBoundingBox;
}

@doc("A brief description of what the image depicts.")
model DenseCaption {
  @doc("The level of confidence the service has in the caption.")
  @minValue(0.0)
  @maxValue(1.0)
  confidence: float32;

  @doc("The text of the caption.")
  @minLength(1)
  text: string;

  @doc("The bounding box of the caption.")
  boundingBox: ImageBoundingBox;
}

@doc("A list of captions.")
model DenseCaptionsResult {
  @doc("The list of captions.")
  @minItems(1)
  values: Array<DenseCaption>;
}

@doc("Describes a detected object in an image.")
model DetectedObject {
  @doc("Gets a rectangular boundary within which the object was detected.")
  boundingBox: ImageBoundingBox;

  @doc("Classification confidences of the detected object.")
  @minItems(0)
  tags: Array<DetectedTag>;
}

@doc("Represents a person detected in an image")
model DetectedPerson {
  @doc("Gets a rectangular boundary within which the person was detected.")
  @visibility("read")
  boundingBox: ImageBoundingBox;

  @doc("Gets the confidence value of the detected person.")
  @visibility("read")
  @minValue(0.0)
  @maxValue(1.0)
  confidence: float32;
}

@doc("A content line object consisting of an adjacent sequence of content elements, such as words and selection marks.")
model DocumentLine {
  @doc("The bounding box of the line.")
  boundingBox: Array<float32>;

  @doc("Concatenated content of the contained elements in reading order.")
  content: string;

  @doc("Location of the line in the reading order concatenated content.")
  spans: Array<DocumentSpan>;
}

@doc("The content and layout elements extracted from a page from the input.")
model DocumentPage {
  @doc("The general orientation of the content in clockwise direction, measured in degrees between (-180, 180].")
  angle: float32;

  @doc("The height of the image/PDF in pixels/inches, respectively.")
  height: float32;

  @doc("Extracted lines from the page, potentially containing both textual and visual elements.")
  lines: Array<DocumentLine>;

  @doc("1-based page number in the input document.")
  pageNumber: int32;

  @doc("Location of the page in the reading order concatenated content.")
  spans: Array<DocumentSpan>;

  @doc("The width of the image/PDF in pixels/inches, respectively.")
  width: float32;

  @doc("Extracted words from the page.")
  words: Array<DocumentWord>;
}

@doc("Contiguous region of the concatenated content property, specified as an offset and length.")
model DocumentSpan {
  @doc("Number of characters in the content represented by the span.")
  length: int32;

  @doc("Zero-based index of the content represented by the span.")
  offset: int32;
}

@doc("An object representing observed text styles.")
model DocumentStyle {
  @doc("Confidence of correctly identifying the style.")
  @minValue(0.0)
  @maxValue(1.0)
  confidence: float32;

  @doc("Is content handwritten or not.")
  isHandwritten: boolean;

  @doc("Location of the text elements in the concatenated content the style applies to.")
  spans: Array<DocumentSpan>;
}

@doc("A word object consisting of a contiguous sequence of characters. For non-space delimited languages,\r\nsuch as Chinese, Japanese, and Korean, each character is represented as its own word.")
model DocumentWord {
  @doc("Bounding box of the word.")
  boundingBox: Array<float32>;

  @doc("Confidence of correctly extracting the word.")
  confidence: float32;

  @doc("Text content of the word.")
  content: string;

  @doc("Location of the word in the reading order concatenated content.")
  span: DocumentSpan;
}

@doc("Describe the combined results of different types of image analysis.")
model ImageAnalysisResult {
  @doc("A CaptionResult for the image.")
  @projectedName("json", "captionResult")
  caption?: CaptionResult;

  @doc("A list of categories for the image.")
  customModelResult?: CustomModelResult;

  @doc("A denseCaptionsResult for the image.")
  @projectedName("json", "denseCaptionsResult")
  denseCaptions?: DenseCaptionsResult;

  @doc("The model used for the analysis")
  metadata: ImageMetadata;

  @doc("The model used for the analysis")
  modelVersion: string;

  @doc("A list of objects for the image.")
  @projectedName("json", "objectsResult")
  objects?: ObjectsResult;

  @doc("A list of people for the image.")
  @projectedName("json", "peopleResult")
  people?: PeopleResult;

  @doc("A readResult for the image.")
  @projectedName("json", "readResult")
  read?: ReadResult;

  @doc("A list of regions for the image.")
  @projectedName("json", "smartCropsResult")
  smartCrops?: SmartCropsResult;

  @doc("A list of tags for the image.")
  @projectedName("json", "tagsResult")
  tags?: TagsResult;
}

@doc("The image metadata information such as height and width.")
model ImageMetadata {
  @doc("The height of the image in pixels.")
  @minValue(1)
  height: int32;

  @doc("The width of the image in pixels.")
  @minValue(1)
  width: int32;
}

@doc("Describes the result of image analysis using a custom model.")
model CustomModelResult {
  @doc("The list of predicted objects.")
  @projectedName("json", "objectsResult")
  objects: ObjectsResult;

  @doc("The list of predicted tags.")
  @projectedName("json", "tagsResult")
  tags: TagsResult;
}

@doc("Describes detected objects in an image.")
model ObjectsResult {
  @doc("An array of detected objects.")
  @minItems(0)
  values: Array<DetectedObject>;
}

@doc("An object describing whether the image contains people.")
model PeopleResult {
  @doc("An array of detected people.")
  @minItems(0)
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

  @doc("The model used to generate the Read result.")
  modelVersion: string;
}

@doc("Smart cropping result.")
model SmartCropsResult {
  @doc("Recommended regions for cropping the image.")
  @minItems(1)
  values: Array<CropRegion>;
}

@doc("An entity observation in the image, along with the confidence score.")
model DetectedTag {
  @doc("The level of confidence that the entity was observed.")
  @minValue(0.0)
  @maxValue(1.0)
  confidence: float32;

  @doc("Name of the entity.")
  @minLength(1)
  name: string;
}

@doc("A list of tags with confidence level.")
model TagsResult {
  @doc("A list of tags with confidence level.")
  @minItems(0)
  values: Array<DetectedTag>;
}

@doc("The visual features requested: tags, objects, caption, denseCaptions, read, smartCrops, people. This parameter needs to be specified if the parameter \"model-name\" is not specified.")
enum VisualFeatures {
  @doc("Tags")
  tags,

  @doc("Caption")
  caption,

  @doc("DenseCaptions")
  denseCaptions,

  @doc("Objects")
  objects,

  @doc("Read")
  read,

  @doc("SmartCrops")
  smartCrops,

  @doc("People")
  people,
}

@doc("The segmentation mode requested.")
enum SegmentationMode {
  @doc("Remove the background")
  backgroundRemoval,

  @doc("Matt the foreground")
  foregroundMatting,
}

@doc("A JSON document with a URL pointing to the image that is to be analyzed.")
model ImageUrl {
  @doc("Publicly reachable URL of an image.")
  url: url;
}
