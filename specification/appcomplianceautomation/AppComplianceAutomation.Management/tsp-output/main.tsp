import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "App Compliance Automation Tool for Microsoft 365",
  version: "2022-11-16-preview",
})
@server(
  "{$host}",
  "App Compliance Automation Tool for Microsoft 365 API spec",
  {
    $host: string,
  }
)
@doc("App Compliance Automation Tool for Microsoft 365 API spec")
namespace AppComplianceAutomationToolforMicrosoft365;
