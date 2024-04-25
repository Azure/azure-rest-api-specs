import "@typespec/http";

@doc("HTTP request containing a COSE signature")
model CoseSignature {
  @doc("The MIME content type for all auditable member actions is application/cose, containing a CoseSign1 signature.")
  @TypeSpec.Http.header("content-type")
  contentType: "application/cose";

  @doc("A raw CoseSign1 signature. See CCF docs for required headers and body schema: https://microsoft.github.io/CCF/main/use_apps/issue_commands.html#cose-schemas")
  @TypeSpec.Http.body
  body: bytes;
}

model CoseSigned<T = {}> extends CoseSignature {}
