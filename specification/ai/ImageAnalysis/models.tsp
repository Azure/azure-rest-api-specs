import "@typespec/http";
import "@azure-tools/typespec-client-generator-core";

namespace ImageAnalysis;
using TypeSpec.Http;
using Azure.ClientGenerator.Core;

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
  @encodedName("application/json", "w")
  width: int32;

  @doc("Height of the area, in pixels.")
  @minValue(0)
  @encodedName("application/json", "h")
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
  @clientName("list", "python")
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

@doc("Represents the coordinates of a single pixel in the image.")
model ImagePoint {
  @doc("The horizontal x-coordinate of this point, in pixels. Zero values corresponds to the left-most pixels in the image.")
  @minValue(0)
  x: int32;

  @doc("The vertical y-coordinate of this point, in pixels. Zero values corresponds to the top-most pixels in the image.")
  @minValue(0)
  y: int32;
}

@doc("A word object consisting of a contiguous sequence of characters. For non-space delimited languages,\r\nsuch as Chinese, Japanese, and Korean, each character is represented as its own word.")
model DetectedTextWord {
  @doc("Text content of the word.")
  @minLength(1)
  text: string;

  @doc("A bounding polygon around the word. At the moment only quadrilaterals are supported (represented by 4 image points).")
  @minItems(4)
  @maxItems(4)
  boundingPolygon: Array<ImagePoint>;

  @doc("The level of confidence that the word was detected. Confidence scores span the range of 0.0 to 1.0 (inclusive), with higher values indicating a higher confidence of detection.")
  @minValue(0.0)
  @maxValue(1.0)
  confidence: float32;
}

@doc("Represents a single line of text in the image.")
model DetectedTextLine {
  @doc("Text content of the detected text line.")
  @minLength(1)
  text: string;

  @doc("A bounding polygon around the text line. At the moment only quadrilaterals are supported (represented by 4 image points).")
  @minItems(4)
  @maxItems(4)
  boundingPolygon: Array<ImagePoint>;

  @doc("A list of words in this line.")
  @minItems(1)
  words: Array<DetectedTextWord>;
}

@doc("Represents a single block of detected text in the image.")
model DetectedTextBlock {
  @doc("A list of text lines in this block.")
  @minItems(1)
  lines: Array<DetectedTextLine>;
}

@doc("Represents the outcome of an Image Analysis operation.")
model ImageAnalysisResult {
  @doc("The generated phrase that describes the content of the analyzed image.")
  @encodedName("application/json", "captionResult")
  caption?: CaptionResult;

  @doc("""
  The up to 10 generated phrases, the first describing the content of the whole image,
  and the others describing the content of different regions of the image.
  """)
  @encodedName("application/json", "denseCaptionsResult")
  denseCaptions?: DenseCaptionsResult;

  @doc("Metadata associated with the analyzed image.")
  metadata: ImageMetadata;

  @doc("The cloud AI model used for the analysis")
  modelVersion: string;

  @doc("A list of detected physical objects in the analyzed image, and their location.")
  @encodedName("application/json", "objectsResult")
  objects?: ObjectsResult;

  @doc("A list of detected people in the analyzed image, and their location.")
  @encodedName("application/json", "peopleResult")
  people?: PeopleResult;

  @doc("The extracted printed and hand-written text in the analyze image. Also knows as OCR.")
  @encodedName("application/json", "readResult")
  read?: ReadResult;

  @doc("""
  A list of crop regions at the desired as aspect ratios (if provided) that can be used as image thumbnails.
  These regions preserve as much content as possible from the analyzed image, with priority given to detected faces.
  """)
  @encodedName("application/json", "smartCropsResult")
  smartCrops?: SmartCropsResult;

  @doc("A list of content tags in the analyzed image.")
  @encodedName("application/json", "tagsResult")
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
  @clientName("list", "python")
  values: Array<DetectedObject>;
}

@doc("Represents a list of people detected in an image and their location.")
model PeopleResult {
  @doc("A list of people detected in an image and their location.")
  @minItems(0)
  @clientName("list", "python")
  values: Array<DetectedPerson>;
}

@doc("The results of a Read (OCR) operation.")
model ReadResult {
  @doc("A list of text blocks in the image. At the moment only one block is returned, containing all the text detected in the image.")
  @minItems(1)
  @maxItems(1)
  blocks: Array<DetectedTextBlock>;
}

@doc("""
Smart cropping result. A list of crop regions at the desired as aspect ratios (if provided) that can be used as image thumbnails.
These regions preserve as much content as possible from the analyzed image, with priority given to detected faces.
""")
model SmartCropsResult {
  @doc("A list of crop regions.")
  @minItems(1)
  @clientName("list", "python")
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
  @clientName("list", "python")
  values: Array<DetectedTag>;
}

@doc("The visual features supported by the Image Analysis service")
union VisualFeatures {
  string,

  @doc("Extract content tags for thousands of recognizable objects, living beings, scenery, and actions that appear in the image.")
  "tags",

  @doc("Generate a human-readable caption sentence that describes the content of the image.")
  "caption",

  @doc("Generate human-readable caption sentences for up to 10 different regions in the image, including one for the whole image.")
  "denseCaptions",

  @doc("Object detection. This is similar to tags, but focused on detecting physical objects in the image and returning their location.")
  "objects",

  @doc("Extract printed or handwritten text from the image. Also known as Optical Character Recognition (OCR).")
  "read",

  @doc("Find representative sub-regions of the image for thumbnail generation, at desired aspect ratios, with priority given to detected faces.")
  "smartCrops",

  @doc("Detect people in the image and return their location.")
  "people",
}

@doc("An object holding the publicly reachable URL of an image to analyze.")
model ImageUrl {
  @doc("Publicly reachable URL of an image to analyze.")
  url: url;
}
