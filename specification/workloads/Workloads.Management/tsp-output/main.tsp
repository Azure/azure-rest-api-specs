import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "Workloads Client",
  version: "2023-04-01",
})
@server(
  "{$host}",
  "Workloads client provides access to various workload operations.<br>Azure Center for SAP solutions is currently in PREVIEW. See the [Azure Center for SAP solutions - Legal Terms](https://learn.microsoft.com/legal/azure-center-for-sap-solutions/azure-center-for-sap-solutions-legal-terms) for legal notices applicable to Azure Center for SAP solutions.",
  {
    $host: string,
  }
)
@doc("""
Workloads client provides access to various workload operations.<br>Azure
Center for SAP solutions is currently in PREVIEW. See the [Azure Center for SAP
solutions - Legal
Terms](https://learn.microsoft.com/legal/azure-center-for-sap-solutions/azure-center-for-sap-solutions-legal-terms)
for legal notices applicable to Azure Center for SAP solutions.
""")
namespace WorkloadsClient;
