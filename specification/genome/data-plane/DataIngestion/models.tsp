import "@typespec/rest";
import "@typespec/http";

namespace Genome;

/** Type of upload operation */
union UploadType {
  string,

  /**
   * Delta
   */
  Delta: "Delta",

  /**
   * Full
   */
  Full: "Full",
}

/** Type of data being uploaded */
union UploadDataType {
  string,

  /**
   * CustomerEntity
   */
  CustomerEntity: "CustomerEntity",

  /**
   * CustomerFlagType
   */
  CustomerFlagType: "CustomerFlagType",

  /**
   * CustomerProduct
   */
  CustomerProduct: "CustomerProduct",

  /**
   * CustomerSuppliedByRel
   */
  CustomerSuppliedByRel: "CustomerSuppliedByRel",

  /**
   * CustomerHasAddressRel
   */
  CustomerHasAddressRel: "CustomerHasAddressRel",

  /**
   * CustomerHasFlagRel
   */
  CustomerHasFlagRel: "CustomerHasFlagRel",

  /**
   * CustomerHasIdentifierRel
   */
  CustomerHasIdentifierRel: "CustomerHasIdentifierRel",

  /**
   * CustomerSuppliesProductRel
   */
  CustomerSuppliesProductRel: "CustomerSuppliesProductRel",

  /**
   * CustomerBuysProductRel
   */
  CustomerBuysProductRel: "CustomerBuysProductRel",

  /**
   * CustomerContainsComponentRel
   */
  CustomerContainsComponentRel: "CustomerContainsComponentRel",
}

/** Status of the upload operation */
union UploadStatusValue {
  string,

  /**
   * Uploaded
   */
  Uploaded: "Uploaded",

  /**
   * Verified
   */
  Verified: "Verified",

  /**
   * VerificationFailed
   */
  VerificationFailed: "VerificationFailed",

  /**
   * Ingested
   */
  Ingested: "Ingested",

  /**
   * IngestionFailed
   */
  IngestionFailed: "IngestionFailed",
}

/** Response containing upload request details and status */
model UploadResponse {
  /**
   * Gets or Sets ingestion id.
   */
  ingestionId: string;

  /** The timestamp when the upload was created */
  createdOn: utcDateTime;

  /** The timestamp when the upload was last modified */
  modifiedOn: utcDateTime;

  /** Current status of the upload */
  status: UploadStatusValue;

  /** Error message if the upload failed */
  errorMessage?: string;

  /** Type of data in the uploaded file */
  dataType?: UploadDataType;

  /** Type of upload operation performed */
  uploadType?: UploadType;

  /** Size of the uploaded file in bytes */
  fileSize?: int32;

  /** Name of the uploaded file */
  inputFileName: string;
}

/** Status response for upload request */
model UploadStatus is UploadResponse;

/** Multipart form data for file upload */
model PathsTnhejgV1DataingestionRequestsPostRequestbodyContentMultipartFormDataSchema {
  /** The file content to upload */
  formFile?: bytes;
}
