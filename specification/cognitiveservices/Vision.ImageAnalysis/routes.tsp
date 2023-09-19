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
@route("imageanalysis/analyze") //@convenientAPI(true)
@post
op analyze is Azure.Core.RpcOperation<
{
  text:bytes,
  ImageAnalysisOptions : ImageAnalysisOptions
},
ImageAnalysisResult
>;