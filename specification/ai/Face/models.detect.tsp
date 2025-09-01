import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models.common.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Face;

alias FaceDetectionOptions = {
  @doc("The 'detectionModel' associated with the detected faceIds. Supported 'detectionModel' values include 'detection_01', 'detection_02' and 'detection_03'. The default value is 'detection_01'. 'detection_03' is recommended since its accuracy is improved on smaller faces (64x64 pixels) and rotated face orientations.")
  @query
  detectionModel?: DetectionModel = "detection_01";

  @doc("The 'recognitionModel' associated with the detected faceIds. Supported 'recognitionModel' values include 'recognition_01', 'recognition_02', 'recognition_03' or 'recognition_04'. The default value is 'recognition_01'. 'recognition_04' is recommended since its accuracy is improved on faces wearing masks compared with 'recognition_03', and its overall accuracy is improved compared with 'recognition_01' and 'recognition_02'.")
  @query
  recognitionModel?: RecognitionModel = "recognition_01";

  @doc("Return faceIds of the detected faces or not. The default value is true.")
  @query
  returnFaceId?: boolean = true;

  @doc("Analyze and return the one or more specified face attributes in the comma-separated string like 'returnFaceAttributes=headPose,glasses'. Face attribute analysis has additional computational and time cost.")
  @query
  returnFaceAttributes?: FaceAttributeType[];

  @doc("Return face landmarks of the detected faces or not. The default value is false.")
  @query
  returnFaceLandmarks?: boolean = false;

  @doc("Return 'recognitionModel' or not. The default value is false. This is only applicable when returnFaceId = true.")
  @query
  returnRecognitionModel?: boolean = false;

  @doc("The number of seconds for the face ID being cached. Supported range from 60 seconds up to 86400 seconds. The default value is 86400 (24 hours).")
  @query
  @minValue(60)
  @maxValue(86400)
  faceIdTimeToLive?: int32 = 86400;
};

#suppress "@azure-tools/typespec-azure-core/use-extensible-enum" "Use fixed enum to represent modelAsString = false"
@doc("Available options for detect face with attribute.")
union FaceAttributeType {
  string,

  @doc("3-D roll/yaw/pitch angles for face direction.")
  "headPose",

  @doc("Glasses type. Values include 'NoGlasses', 'ReadingGlasses', 'Sunglasses', 'SwimmingGoggles'.")
  "glasses",

  @doc("Whether each facial area is occluded, including forehead, eyes and mouth.")
  "occlusion",

  @doc("Accessories around face, including 'headwear', 'glasses' and 'mask'. Empty array means no accessories detected. Note this is after a face is detected. Large mask could result in no face to be detected.")
  "accessories",

  @doc("Face is blurry or not. Level returns 'Low', 'Medium' or 'High'. Value returns a number between [0,1], the larger the blurrier.")
  "blur",

  @doc("Face exposure level. Level returns 'GoodExposure', 'OverExposure' or 'UnderExposure'.")
  "exposure",

  @doc("Noise level of face pixels. Level returns 'Low', 'Medium' and 'High'. Value returns a number between [0,1], the larger the noisier")
  "noise",

  @doc("Whether each face is wearing a mask. Mask type returns 'noMask', 'faceMask', 'otherMaskOrOcclusion', or 'uncertain'. Value returns a boolean 'noseAndMouthCovered' indicating whether nose and mouth are covered.")
  "mask",

  @doc("The overall image quality regarding whether the image being used in the detection is of sufficient quality to attempt face recognition on. The value is an informal rating of low, medium, or high. Only 'high' quality images are recommended for person enrollment and quality at or above 'medium' is recommended for identification scenarios. The attribute is only available when using recognition models recognition_03 or recognition_04.")
  "qualityForRecognition",

  @doc("Age in years.")
  "age",

  @doc("Smile intensity, a number between [0,1].")
  "smile",

  @doc("Properties describing facial hair attributes.")
  "facialHair",

  @doc("Properties describing hair attributes.")
  "hair",
}

@doc("Response for detect API.")
model FaceDetectionResult {
  @doc("Unique faceId of the detected face, created by detection API and it will expire 24 hours after the detection call. To return this, it requires 'returnFaceId' parameter to be true.")
  faceId?: uuid;

  @doc("The 'recognitionModel' associated with this faceId. This is only returned when 'returnRecognitionModel' is explicitly set as true.")
  recognitionModel?: RecognitionModel;

  @doc("A rectangle area for the face location on image.")
  faceRectangle: FaceRectangle;

  @doc("An array of 27-point face landmarks pointing to the important positions of face components. To return this, it requires 'returnFaceLandmarks' parameter to be true.")
  faceLandmarks?: FaceLandmarks;

  @doc("Face attributes for detected face.")
  faceAttributes?: FaceAttributes;
}

@doc("A rectangle within which a face can be found.")
model FaceRectangle {
  @doc("The distance from the top edge if the image to the top edge of the rectangle, in pixels.")
  top: int32;

  @doc("The distance from the left edge if the image to the left edge of the rectangle, in pixels.")
  left: int32;

  @doc("The width of the rectangle, in pixels.")
  width: int32;

  @doc("The height of the rectangle, in pixels.")
  height: int32;
}

@doc("A collection of 27-point face landmarks pointing to the important positions of face components.")
model FaceLandmarks {
  @doc("The coordinates of the left eye pupil.")
  pupilLeft: LandmarkCoordinate;

  @doc("The coordinates of the right eye pupil.")
  pupilRight: LandmarkCoordinate;

  @doc("The coordinates of the nose tip.")
  noseTip: LandmarkCoordinate;

  @doc("The coordinates of the mouth left.")
  mouthLeft: LandmarkCoordinate;

  @doc("The coordinates of the mouth right.")
  mouthRight: LandmarkCoordinate;

  @doc("The coordinates of the left eyebrow outer.")
  eyebrowLeftOuter: LandmarkCoordinate;

  @doc("The coordinates of the left eyebrow inner.")
  eyebrowLeftInner: LandmarkCoordinate;

  @doc("The coordinates of the left eye outer.")
  eyeLeftOuter: LandmarkCoordinate;

  @doc("The coordinates of the left eye top.")
  eyeLeftTop: LandmarkCoordinate;

  @doc("The coordinates of the left eye bottom.")
  eyeLeftBottom: LandmarkCoordinate;

  @doc("The coordinates of the left eye inner.")
  eyeLeftInner: LandmarkCoordinate;

  @doc("The coordinates of the right eyebrow inner.")
  eyebrowRightInner: LandmarkCoordinate;

  @doc("The coordinates of the right eyebrow outer.")
  eyebrowRightOuter: LandmarkCoordinate;

  @doc("The coordinates of the right eye inner.")
  eyeRightInner: LandmarkCoordinate;

  @doc("The coordinates of the right eye top.")
  eyeRightTop: LandmarkCoordinate;

  @doc("The coordinates of the right eye bottom.")
  eyeRightBottom: LandmarkCoordinate;

  @doc("The coordinates of the right eye outer.")
  eyeRightOuter: LandmarkCoordinate;

  @doc("The coordinates of the nose root left.")
  noseRootLeft: LandmarkCoordinate;

  @doc("The coordinates of the nose root right.")
  noseRootRight: LandmarkCoordinate;

  @doc("The coordinates of the nose left alar top.")
  noseLeftAlarTop: LandmarkCoordinate;

  @doc("The coordinates of the nose right alar top.")
  noseRightAlarTop: LandmarkCoordinate;

  @doc("The coordinates of the nose left alar out tip.")
  noseLeftAlarOutTip: LandmarkCoordinate;

  @doc("The coordinates of the nose right alar out tip.")
  noseRightAlarOutTip: LandmarkCoordinate;

  @doc("The coordinates of the upper lip top.")
  upperLipTop: LandmarkCoordinate;

  @doc("The coordinates of the upper lip bottom.")
  upperLipBottom: LandmarkCoordinate;

  @doc("The coordinates of the under lip top.")
  underLipTop: LandmarkCoordinate;

  @doc("The coordinates of the under lip bottom.")
  underLipBottom: LandmarkCoordinate;
}

@doc("Landmark coordinates within an image.")
model LandmarkCoordinate {
  @doc("The horizontal component, in pixels.")
  x: float32;

  @doc("The vertical component, in pixels.")
  y: float32;
}

@doc("Face attributes for the detected face.")
model FaceAttributes {
  @doc("Age in years.")
  age?: float32;

  @doc("Smile intensity, a number between [0,1].")
  @minValue(0)
  @maxValue(1)
  smile?: float32;

  @doc("Properties describing facial hair attributes.")
  facialHair?: FacialHair;

  @doc("Glasses type if any of the face.")
  glasses?: GlassesType;

  @doc("3-D roll/yaw/pitch angles for face direction.")
  headPose?: HeadPose;

  @doc("Properties describing hair attributes.")
  hair?: HairProperties;

  @doc("Properties describing occlusions on a given face.")
  occlusion?: OcclusionProperties;

  @doc("Properties describing any accessories on a given face.")
  accessories?: AccessoryItem[];

  @doc("Properties describing any presence of blur within the image.")
  blur?: BlurProperties;

  @doc("Properties describing exposure level of the image.")
  exposure?: ExposureProperties;

  @doc("Properties describing noise level of the image.")
  noise?: NoiseProperties;

  @doc("Properties describing the presence of a mask on a given face.")
  mask?: MaskProperties;

  @doc("Properties describing the overall image quality regarding whether the image being used in the detection is of sufficient quality to attempt face recognition on.")
  qualityForRecognition?: QualityForRecognition;
}

@doc("Properties describing facial hair attributes.")
model FacialHair {
  @doc("A number ranging from 0 to 1 indicating a level of confidence associated with a property.")
  @minValue(0)
  @maxValue(1)
  moustache: float32;

  @doc("A number ranging from 0 to 1 indicating a level of confidence associated with a property.")
  @minValue(0)
  @maxValue(1)
  beard: float32;

  @doc("A number ranging from 0 to 1 indicating a level of confidence associated with a property.")
  @minValue(0)
  @maxValue(1)
  sideburns: float32;
}

@doc("Glasses type of the face.")
union GlassesType {
  string,

  @doc("No glasses on the face.")
  "noGlasses",

  @doc("Normal glasses on the face.")
  "readingGlasses",

  @doc("Sunglasses on the face.")
  "sunglasses",

  @doc("Swimming goggles on the face.")
  "swimmingGoggles",
}

@doc("3-D roll/yaw/pitch angles for face direction.")
model HeadPose {
  @doc("Value of angles.")
  pitch: float32;

  @doc("Value of angles.")
  roll: float32;

  @doc("Value of angles.")
  yaw: float32;
}

@doc("Properties describing hair attributes.")
model HairProperties {
  @doc("A number describing confidence level of whether the person is bald.")
  @minValue(0)
  @maxValue(1)
  bald: float32;

  @doc("A boolean value describing whether the hair is visible in the image.")
  invisible: boolean;

  @doc("An array of candidate colors and confidence level in the presence of each.")
  hairColor: HairColor[];
}

@doc("An array of candidate colors and confidence level in the presence of each.")
model HairColor {
  @doc("Name of the hair color.")
  color: HairColorType;

  @doc("Confidence level of the color. Range between [0,1].")
  @minValue(0)
  @maxValue(1)
  confidence: float32;
}

@doc("Name of the hair color.")
union HairColorType {
  string,

  @doc("Unknown.")
  unknownHairColor: "unknown",

  @doc("White.")
  "white",

  @doc("Gray.")
  "gray",

  @doc("Blond.")
  "blond",

  @doc("Brown.")
  "brown",

  @doc("Red.")
  "red",

  @doc("Black.")
  "black",

  @doc("Other.")
  "other",
}

@doc("Properties describing occlusions on a given face.")
model OcclusionProperties {
  @doc("A boolean value indicating whether forehead is occluded.")
  foreheadOccluded: boolean;

  @doc("A boolean value indicating whether eyes are occluded.")
  eyeOccluded: boolean;

  @doc("A boolean value indicating whether the mouth is occluded.")
  mouthOccluded: boolean;
}

@doc("Accessory item and corresponding confidence level.")
model AccessoryItem {
  @doc("Type of the accessory.")
  type: AccessoryType;

  @doc("Confidence level of the accessory type. Range between [0,1].")
  @minValue(0)
  @maxValue(1)
  confidence: float32;
}

@doc("Type of the accessory.")
union AccessoryType {
  string,

  @doc("Head wear.")
  "headwear",

  @doc("Glasses.")
  "glasses",

  @doc("Mask.")
  "mask",
}

@doc("Properties describing any presence of blur within the image.")
model BlurProperties {
  @doc("An enum value indicating level of blurriness.")
  blurLevel: BlurLevel;

  @doc("A number indicating level of blurriness ranging from 0 to 1.")
  @minValue(0)
  @maxValue(1)
  value: float32;
}

@doc("Indicates level of blurriness.")
union BlurLevel {
  string,

  @doc("Low blur level.")
  "low",

  @doc("Medium blur level.")
  "medium",

  @doc("High blur level.")
  "high",
}

@doc("Properties describing exposure level of the image.")
model ExposureProperties {
  @doc("An enum value indicating level of exposure.")
  exposureLevel: ExposureLevel;

  @doc("A number indicating level of exposure level ranging from 0 to 1. [0, 0.25) is under exposure. [0.25, 0.75) is good exposure. [0.75, 1] is over exposure.")
  @minValue(0)
  @maxValue(1)
  value: float32;
}

@doc("Indicates level of exposure.")
union ExposureLevel {
  string,

  @doc("Low exposure level.")
  "underExposure",

  @doc("Good exposure level.")
  "goodExposure",

  @doc("High exposure level.")
  "overExposure",
}

@doc("Properties describing noise level of the image.")
model NoiseProperties {
  @doc("An enum value indicating level of noise.")
  noiseLevel: NoiseLevel;

  @doc("A number indicating level of noise level ranging from 0 to 1. [0, 0.25) is under exposure. [0.25, 0.75) is good exposure. [0.75, 1] is over exposure. [0, 0.3) is low noise level. [0.3, 0.7) is medium noise level. [0.7, 1] is high noise level.")
  @minValue(0)
  @maxValue(1)
  value: float32;
}

@doc("Indicates level of noise.")
union NoiseLevel {
  string,

  @doc("Low noise level.")
  "low",

  @doc("Medium noise level.")
  "medium",

  @doc("High noise level.")
  "high",
}

@doc("Properties describing the presence of a mask on a given face.")
model MaskProperties {
  @doc("A boolean value indicating whether nose and mouth are covered.")
  noseAndMouthCovered: boolean;

  @doc("Type of the mask.")
  type: MaskType;
}

@doc("Type of the mask.")
union MaskType {
  string,

  @doc("Face mask.")
  "faceMask",

  @doc("No mask.")
  "noMask",

  @doc("Other types of mask or occlusion.")
  "otherMaskOrOcclusion",

  @doc("Uncertain.")
  "uncertain",
}

@doc("Indicates quality of image for recognition.")
union QualityForRecognition {
  string,

  @doc("Low quality.")
  "low",

  @doc("Medium quality.")
  "medium",

  @doc("High quality.")
  "high",
}
