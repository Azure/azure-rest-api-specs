import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
/**
 * The Computer Vision API provides state-of-the-art algorithms to process images
 * and return information. For example, it can be used to determine if an image
 * contains mature content, or it can be used to find all the people in an image.
 * It also has other features like categorizing the content of images, and
 * describing an image with complete English sentences.
 */
@service({
  title: "Computer Vision Client",
})
@versioned(Versions)
@server(
  "{$host}",
  "The Computer Vision API provides state-of-the-art algorithms to process images and return information. For example, it can be used to determine if an image contains mature content, or it can be used to find all the people in an image.  It also has other features like categorizing the content of images, and describing an image with complete English sentences.",
  {
    $host: string,
  }
)
namespace ComputerVisionClient;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2024-05-01-preview API version.
   */
  v2024_05_01_preview: "2024-05-01-preview",
}
