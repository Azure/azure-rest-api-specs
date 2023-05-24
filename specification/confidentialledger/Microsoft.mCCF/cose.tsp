import "@typespec/http";

@doc("HTTP request containing a COSE signature")
model CoseSignature {
  @doc("Content-type for all auditable member actions is application/cose, containing a CoseSign1 signature.")
  @TypeSpec.Http.header("Content-type")
  contentType: "application/cose";

  @doc("A raw CoseSign1 signature. See CCF docs for required headers and body schema: https://microsoft.github.io/CCF/main/use_apps/issue_commands.html#cose-sign1")
  @TypeSpec.Http.body
  body: bytes;
}

model CoseSigned<T = {}> extends CoseSignature {}
