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
@sharedRoute
@action("analyze")
op analyzeFromStream is Azure.Core.RpcOperation<
  {
    ...SharedAnalyzeQuery,

    @doc("The format of the HTTP payload.")
    @header()
    contentType: "application/octet-stream";

    @doc("The image to be analyzed")
    @body
    imageContents: bytes;
  },
  ImageAnalysisResult
>;

@doc("Performs a single Image Analysis operation")
@actionSeparator("/")
@route("imageanalysis:analyze")
@post
@sharedRoute
@action("analyze")
op analyzeFromUrl is Azure.Core.RpcOperation<
  {
    ...SharedAnalyzeQuery,

    @doc("The format of the HTTP payload.")
    @header("Content-Type")
    contentType: "application/json";

    @doc("The image to be analyzed")
    @body
    imageContents: ImageUrl;
  },
  ImageAnalysisResult
>;

@doc("Segment the input image. An image stream of content type 'image/png' is returned, where the pixel values depend on the analysis mode. The returned image has the same dimensions as the input image for modes: foregroundMatting. The returned image has the same aspect ratio and same dimensions as the input image up to a limit of 16 megapixels for modes: backgroundRemoval.")
@actionSeparator("/")
@route("imageanalysis:segment")
@post
@sharedRoute
@action("segment")
op segmentFromUrl is Azure.Core.RpcOperation<
{
  @doc("The image to be analyzed")
  @body
  imageContents: ImageUrl;

  @doc("The type of segmentation to perform")
  @query("mode")
  mode: segmentationMode;

  @doc("The format of the HTTP payload.")
  @header()
  contentType: "application/octet-stream";
},
{
  @header 
  contentType: "image/png";
  @body
  bytes:bytes
} >;

#suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to segment an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
@doc("Segment the input image. An image stream of content type 'image/png' is returned, where the pixel values depend on the analysis mode. The returned image has the same dimensions as the input image for modes: foregroundMatting. The returned image has the same aspect ratio and same dimensions as the input image up to a limit of 16 megapixels for modes: backgroundRemoval.")
@actionSeparator("/")
@route("imageanalysis:segment")
@post
@sharedRoute
@action("segment")
op segmentFromStream is Azure.Core.RpcOperation<
{
  @doc("The image to be analyzed")
  @body
  imageContents: bytes;

  @doc("The format of the HTTP payload.")
  @header()
  contentType: "application/octet-stream";

  @doc("The type of segmentation to perform")
  @query("mode")
  mode: segmentationMode;
},
{
  @header 
  contentType: "image/png";
  @body
  bytes:bytes
} >;
