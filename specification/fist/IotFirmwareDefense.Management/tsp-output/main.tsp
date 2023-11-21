import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "fist",
  version: "2023-02-08-preview",
})
@server(
  "{$host}",
  "The definitions and parameters in this swagger specification will be used to manage the IoT Firmware Defense resources.",
  {
    $host: string,
  }
)
@doc("""
The definitions and parameters in this swagger specification will be used to
manage the IoT Firmware Defense resources.
""")
namespace fist;
