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

@doc("Performs a single Image Analysis operation")
@actionSeparator("/")
@route("/computervision/imageanalysis:analyze?overload=stream")
@post
op analyze is Azure.Core.RpcOperation<
{
  @query({name:"features", format:"multi"})
  @doc("A string indicating what visual feature types to return. Multiple values should be comma-separated. Valid visual feature types include: Categories, Tags, Description, Faces, ImageType, Color, Adult, Brands, Objects, and Celebrities. If VisualFeatures is not specified, then Categories, Tags, and Description are included in the response by default.")
  visualFeatures?: Array<string>,

  @body
  imageContents:bytes,
},
ImageAnalysisResult
>;