import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@typespec/http";
import "./models.tsp";

using Azure.Core.Traits;

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

namespace ImageAnalysis; 

#suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to analyze an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
@doc("Performs a single Image Analysis operation")
@actionSeparator("/")
@route("imageanalysis:analyze")
@post
op analyze is Azure.Core.RpcOperation<
{
  @query({name:"features", format:"csv"})
  @doc("A string indicating what visual feature types to return. Multiple values should be comma-separated. Valid visual feature types include: Categories, Tags, Description, Faces, ImageType, Color, Adult, Brands, Objects, and Celebrities. If VisualFeatures is not specified, then Categories, Tags, and Description are included in the response by default.")
  visualFeatures?: Array<string>;

  @doc("Impl Detail")
  @query("overload")
  overload: "stream";

  @doc("Impl Detail")
  @header("Content-Type")
  contentType: "application/octet-stream";

  @doc("The image to be analyzed")
  @body
  imageContents:bytes;
},
ImageAnalysisResult
>;