import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";
import "../models/uploads.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

namespace Azure.OpenAI;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
#suppress "@azure-tools/typespec-azure-core/byos" "mirrored API"
@added(ServiceApiVersions.v2024_08_01_Preview)
@post
@route("/uploads")
@doc("""
  Creates an intermediate Upload object that you can add Parts to. Currently, an Upload can accept at most 8 GB in total and expires after an hour after you create it.
  
  Once you complete the Upload, we will create a File object that contains all the parts you uploaded. This File is usable in the rest of our platform as a regular File object.
  
  For certain purposes, the correct mime_type must be specified. Please refer to documentation for the supported MIME types for your use case.
  
  For guidance on the proper filename extensions for each purpose, please follow the documentation on creating a File.
  """)
op createUpload(
  @body
  @doc("The request body for the operation options.")
  requestBody: CreateUploadRequest,
): Upload;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
#suppress "@azure-tools/typespec-azure-core/byos" "mirrored API"
@added(ServiceApiVersions.v2024_08_01_Preview)
@post
@route("/uploads/{upload_id}/parts")
@doc("""
  Adds a Part to an Upload object. A Part represents a chunk of bytes from the file you are trying to upload.
  
  Each Part can be at most 64 MB, and you can add Parts until you hit the Upload maximum of 8 GB.
  
  It is possible to add multiple Parts in parallel. You can decide the intended order of the Parts when you complete the Upload.
  """)
op addUploadPart(
  @doc("The multipart/form-data content-type header for the operation.")
  @header
  contentType: "multipart/form-data",

  #suppress "@azure-tools/typespec-azure-core/casing-style" "this represents the case-sensitive wire format"
  @doc("The ID of the upload associated with this operation.")
  @path
  upload_id: string,

  @doc("The request body data payload for the operation.")
  @body
  requestBody: AddUploadPartRequest,
): UploadPart;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
#suppress "@azure-tools/typespec-azure-core/byos" "mirrored API"
@added(ServiceApiVersions.v2024_08_01_Preview)
@post
@route("/uploads/{upload_id}/complete")
@doc("""
  Completes the Upload.
  
  Within the returned Upload object, there is a nested File object that is ready to use in the rest of the platform.
  
  You can specify the order of the Parts by passing in an ordered list of the Part IDs.
  
  The number of bytes uploaded upon completion must match the number of bytes initially specified when creating the Upload object. No Parts may be added after an Upload is completed.
  """)
op completeUpload(
  #suppress "@azure-tools/typespec-azure-core/casing-style" "this represents the case-sensitive wire format"
  @doc("The ID of the upload associated with this operation.")
  @path
  upload_id: string,

  @doc("The request body for the completion operation.")
  @body
  requestBody: CompleteUploadRequest,
): Upload;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
#suppress "@azure-tools/typespec-azure-core/byos" "mirrored API"
@added(ServiceApiVersions.v2024_08_01_Preview)
@post
@route("/uploads/{upload_id}/cancel")
@doc("""
  Cancels the Upload. No Parts may be added after an Upload is cancelled.
  """)
op cancelUpload(
  #suppress "@azure-tools/typespec-azure-core/casing-style" "this represents the case-sensitive wire format"
  @doc("The ID of the upload associated with this operation.")
  @path
  upload_id: string,
): Upload;
