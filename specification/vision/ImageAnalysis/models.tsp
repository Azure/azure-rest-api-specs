import "@typespec/http";

namespace ImageAnalysis;
using TypeSpec.Http;

@doc("A basic rectangle specifying a sub-region of the image.")
model ImageBoundingBox {
  @doc("X-coordinate of the top left point of the area, in pixels.")
  @minValue(0)
  x: int32;

  @doc("Y-coordinate of the top left point of the area, in pixels.")
  @minValue(0)
  y: int32;

  @doc("Width of the area, in pixels.")
  @minValue(0)
  @projectedName("json", "w")
  width: int32;

  @doc("Height of the area, in pixels.")
  @minValue(0)
  @projectedName("json", "h")
  height: int32;
}

@doc("Represents a generated phrase that describes the content of the whole image.")
model CaptionResult {
  @doc("""
  A score, in the range of 0 to 1 (inclusive), representing the confidence that this description is accurate.
  Higher values indicating higher confidence.
  """)
  @minValue(0.0)
  @maxValue(1.0)
  confidence: float32;

  @doc("The text of the caption.")
  @minLength(1)
  text: string;
}

@doc("""
A region at the desired aspect ratio that can be used as image thumbnail.
The region preserves as much content as possible from the analyzed image, with priority given to detected faces.
""")
model CropRegion {
  @doc("""
  The aspect ratio of the crop region.
  Aspect ratio is calculated by dividing the width of the region in pixels by its height in pixels.
  The aspect ratio will be in the range 0.75 to 1.8 (inclusive) if provided by the developer during the analyze call.
  Otherwise, it will be in the range 0.5 to 2.0 (inclusive).
  """)
  @minValue(0.0)
  aspectRatio: float32;

  @doc("The bounding box of the region.")
  boundingBox: ImageBoundingBox;
}

@doc("Represents a generated phrase that describes the content of the whole image or a region in the image")
model DenseCaption {
  @doc("""
  A score, in the range of 0 to 1 (inclusive), representing the confidence that this description is accurate.
  Higher values indicating higher confidence.
  """)
  @minValue(0.0)
  @maxValue(1.0)
  confidence: float32;

  @doc("The text of the caption.")
  @minLength(1)
  text: string;

  @doc("The image region of which this caption applies.")
  boundingBox: ImageBoundingBox;
}

@doc("""
Represents a list of up to 10 image captions for different regions of the image.
The first caption always applies to the whole image.
""")
model DenseCaptionsResult {
  @doc("The list of image captions.")
  @minItems(1)
  values: Array<DenseCaption>;
}

@doc("Represents a physical object detected in an image.")
model DetectedObject {
  @doc("A rectangular boundary where the object was detected.")
  boundingBox: ImageBoundingBox;

  @doc("A single-item list containing the object information.")
  @minItems(0)
  tags: Array<DetectedTag>;
}

@doc("Represents a person detected in an image.")
model DetectedPerson {
  @doc("A rectangular boundary where the person was detected.")
  @visibility("read")
  boundingBox: ImageBoundingBox;

  @doc("""
  A score, in the range of 0 to 1 (inclusive), representing the confidence that this detection was accurate.
  Higher values indicating higher confidence.
  """)
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

@doc("Represents the outcome of an Image Analysis operation.")
model ImageAnalysisResult {
  @doc("The generated phrase that describes the content of the analyzed image.")
  @projectedName("json", "captionResult")
  caption?: CaptionResult;

  @doc("""
  The up to 10 generated phrases, the first describing the content of the whole image,
  and the others describing the content of different regions of the image.
  """)
  @projectedName("json", "denseCaptionsResult")
  denseCaptions?: DenseCaptionsResult;

  @doc("Metadata associated with the analyzed image.")
  metadata: ImageMetadata;

  @doc("The cloud AI model used for the analysis")
  modelVersion: string;

  @doc("A list of detected physical objects in the analyzed image, and their location.")
  @projectedName("json", "objectsResult")
  objects?: ObjectsResult;

  @doc("A list of detected people in the analyzed image, and their location.")
  @projectedName("json", "peopleResult")
  people?: PeopleResult;

  @doc("The extracted printed and hand-written text in the analyze image. Also knows as OCR.")
  @projectedName("json", "readResult")
  read?: ReadResult;

  @doc("""
  A list of crop regions at the desired as aspect ratios (if provided) that can be used as image thumbnails.
  These regions preserve as much content as possible from the analyzed image, with priority given to detected faces.
  """)
  @projectedName("json", "smartCropsResult")
  smartCrops?: SmartCropsResult;

  @doc("A list of content tags in the analyzed image.")
  @projectedName("json", "tagsResult")
  tags?: TagsResult;
}

@doc("Metadata associated with the analyzed image.")
model ImageMetadata {
  @doc("The height of the image in pixels.")
  @minValue(1)
  height: int32;

  @doc("The width of the image in pixels.")
  @minValue(1)
  width: int32;
}

@doc("Represents a list of physical object detected in an image and their location.")
model ObjectsResult {
  @doc("A list of physical object detected in an image and their location.")
  @minItems(0)
  values: Array<DetectedObject>;
}

@doc("Represents a list of people detected in an image and their location.")
model PeopleResult {
  @doc("A list of people detected in an image and their location.")
  @minItems(0)
  values: Array<DetectedPerson>;
}

@doc("The results of a Read (OCR) operation.")
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

@doc("""
Smart cropping result. A list of crop regions at the desired as aspect ratios (if provided) that can be used as image thumbnails.
These regions preserve as much content as possible from the analyzed image, with priority given to detected faces.
""")
model SmartCropsResult {
  @doc("A list of crop regions.")
  @minItems(1)
  values: Array<CropRegion>;
}

@doc("""
A content entity observation in the image. A tag can be a physical object, living being, scenery, or action
that appear in the image.
""")
model DetectedTag {
  @doc("""
  A score, in the range of 0 to 1 (inclusive), representing the confidence that this entity was observed.
  Higher values indicating higher confidence.
  """)
  @minValue(0.0)
  @maxValue(1.0)
  confidence: float32;

  @doc("Name of the entity.")
  @minLength(1)
  name: string;
}

@doc("""
A list of entities observed in the image. Tags can be physical objects, living being, scenery, or actions
that appear in the image.
""")
model TagsResult {
  @doc("A list of tags.")
  @minItems(0)
  values: Array<DetectedTag>;
}

@doc("The visual features supported by the Image Analysis service")
enum VisualFeatures {
  @doc("Extract content tags for thousands of recognizable objects, living beings, scenery, and actions that appear in the image.")
  tags,

  @doc("Generate a human-readable caption sentence that describes the content of the image.")
  caption,

  @doc("Generate human-readable caption sentences for up to 10 different regions in the image, including one for the whole image.")
  denseCaptions,

  @doc("Object detection. This is similar to tags, but focused on detecting physical objects in the image and returning their location.")
  objects,

  @doc("Extract printed or handwritten text from the image. Also known as Optical Character Recognition (OCR).")
  read,

  @doc("Find representative sub-regions of the image for thumbnail generation, at desired aspect ratios, with priority given to detected faces.")
  smartCrops,

  @doc("Detect people in the image and return their location.")
  people,
}

@doc("An object holding the publicly reachable URL of an image to analyze.")
model ImageUrl {
  @doc("Publicly reachable URL of an image to analyze.")
  url: url;
}
