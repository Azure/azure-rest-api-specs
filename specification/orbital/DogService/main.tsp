import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-autorest";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "api-key"> | OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize",
      scopes: ["https://cognitiveservices.azure.com/.default"],
    }
  ]>
)
@server("https://westus2.dog.azure.com")
@service(#{ title: "Dog Service" })
@versioned(Versions)
namespace Microsoft.Orbital.DogService;

/** Service API versions */
enum Versions {
  /** The 2025-01-01 API version */
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2025_01_01: "2025-01-01",
}

/** Dog bark response */
model BarkResponse {
  /** The bark message */
  message: string;

  /** The level at which the dog barked */
  level: float64;

  /** Timestamp of the bark */
  timestamp: utcDateTime;
}

/** Dog run response */
model RunResponse {
  /** The run message */
  message: string;

  /** The speed at which the dog ran */
  speed: float64;

  /** Distance covered in meters */
  distance?: float32;

  /** Timestamp of the run */
  timestamp: utcDateTime;
}

/** Picture upload form */
model PictureUploadForm {
  /** JPEG image file to upload */
  image: HttpPart<bytes>;
}

/** Picture upload response */
model UploadPictureResponse {
  /** Upload confirmation message */
  message: string;

  /** Unique identifier for the uploaded picture */
  pictureId: string;

  /** File size in bytes */
  fileSize: int64;

  /** Timestamp of the upload */
  timestamp: utcDateTime;
}

/** Medical record upload form */
model MedicalRecordUploadForm {
  /** PDF medical record file to upload */
  medicalRecord?: HttpPart<bytes>;
}

/** Medical record upload response */
model UploadMedicalRecordResponse {
  /** Upload confirmation message */
  message: string;

  /** Unique identifier for the uploaded medical record */
  recordId: string;

  /** File size in bytes */
  fileSize: int64;

  /** Timestamp of the upload */
  timestamp: utcDateTime;
}

/** Error response */
@error
model ErrorResponse {
  /** Error code */
  code: string;

  /** Error message */
  message: string;
}

interface DogOperations {
  /** Make the dog bark at a specified level */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operation for demonstration purposes"
  @post
  @route("/bark/{level}")
  bark(
    /**
     * Bark volume level in dB
     */
    @path
    level: float32,

    /**
     * Pitch in Hz
     */
    @path
    pitch: float32,

    /** The API version to use for this operation */
    @query("api-version") apiVersion: string,
  ): BarkResponse | ErrorResponse;

  /** Make the dog run at a specified speed */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operation for demonstration purposes"
  @post
  @route("/run/{speed}")
  run(
    /** The speed at which the dog should run (in km/h) */
    @path speed: float64,

    /** The API version to use for this operation */
    @query("api-version") apiVersion: string,
  ): RunResponse | ErrorResponse;

  /** Upload a picture of the dog */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operation for demonstration purposes"
  #suppress "@azure-tools/typespec-azure-core/byos" "Direct file upload for demonstration purposes"
  @post
  @route("/uploadPicture")
  uploadPicture(
    /** The API version to use for this operation */
    @query("api-version") apiVersion: string,

    /** The multipart form data containing the image to upload */
    @multipartBody body: PictureUploadForm,
  ): UploadPictureResponse | ErrorResponse;

  /** Upload a medical record for the dog */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operation for demonstration purposes"
  #suppress "@azure-tools/typespec-azure-core/byos" "Direct file upload for demonstration purposes"
  @post
  @route("/uploadMedicalRecord")
  uploadMedicalRecord(
    /** The API version to use for this operation */
    @query("api-version") apiVersion: string,

    /** The multipart form data containing the medical record PDF and metadata */
    @multipartBody body: MedicalRecordUploadForm,
  ): UploadMedicalRecordResponse | ErrorResponse;
}
