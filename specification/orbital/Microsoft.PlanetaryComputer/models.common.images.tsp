import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;

namespace Microsoft.PlanetaryComputer;

/**
 * Return an image.
 */
model ImagePngResponse {
  /**
   * status code
   */
  @statusCode statusCode: 200;

  /**
   * content type
   */
  @header contentType: "image/png";

  /**
   * The image data in PNG format.
   */
  @body
  body: bytes;
}

/**
 * Return an image.
 */
model ImageJpegResponse {
  /**
   * status code
   */
  @statusCode statusCode: 200;

  /**
   * content type
   */
  @header contentType: "image/jpeg";

  /**
   * The image data in JPEG format.
   */
  @body
  body: bytes;
}

/**
 * Return an image.
 */
model ImageJpgResponse {
  /**
   * status code
   */
  @statusCode statusCode: 200;

  /**
   * content type
   */
  @header contentType: "image/jpg";

  /**
   * The image data in JPG format.
   */
  @body
  body: bytes;
}

/**
 * Return an image.
 */
model ImageJp2Response {
  /**
   * status code
   */
  @statusCode statusCode: 200;

  /**
   * content type
   */
  @header contentType: "image/jp2";

  /**
   * The image data in JP2 format.
   */
  @body
  body: bytes;
}

/**
 * Return an image.
 */
model ApplicationXbinaryResponse {
  /**
   * status code
   */
  @statusCode statusCode: 200;

  /**
   * content type
   */
  @header contentType: "application/x-binary";

  /**
   * The binary data.
   */
  @body
  body: bytes;
}

/**
 * Return an image.
 */
model ImageWebpResponse {
  /**
   * status code
   */
  @statusCode statusCode: 200;

  /**
   * content type
   */
  @header contentType: "image/webp";

  /**
   * The image data in WebP format.
   */
  @body
  body: bytes;
}

/**
 * Return an image.
 */
model ImageTiffResponse {
  /**
   * status code
   */
  @statusCode statusCode: 200;

  /**
   * content type
   */
  @header contentType: "image/tiff; application=geotiff";

  /**
   * The image data in TIFF format.
   */
  @body
  body: bytes;
}
