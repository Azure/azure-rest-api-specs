import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models.common.tsp";
import "./models.detect.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Traits;
using Foundations;

namespace Face;

@doc("""
Detect human faces in an image, return face rectangles, and optionally with faceIds, landmarks, and attributes.
""")
@post
@sharedRoute
@route("/face/{apiVersion}/detect")
op DetectOperation<T extends TypeSpec.Reflection.Model> is Azure.Core.RpcOperation<
  FaceDetectionOptions & T,
  Body<FaceDetectionResult[]>,
  ServiceTraits
>;

interface FaceDetectionOperations {
  #suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to detect face from an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
  detect is DetectOperation<{
    @doc("The format of the HTTP payload.")
    @header
    contentType: "application/octet-stream";

    @doc("The input image binary.")
    @body
    imageContent: bytes;
  }>;
  
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Workaround for RpcOperation not handling api version in path."
  detectFromUrl is DetectOperation<{
    @doc("The format of the HTTP payload.")
    @header
    contentType: "application/json";

    @doc("URL of input image.")
    url: url;
  }>;

}
