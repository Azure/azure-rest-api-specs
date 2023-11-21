import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "SqlVirtualMachineManagementClient",
  version: "2022-02-01",
})
@server(
  "{$host}",
  "The SQL virtual machine management API provides a RESTful set of web APIs that interact with Azure Compute, Network & Storage services to manage your SQL Server virtual machine. The API enables users to create, delete and retrieve a SQL virtual machine, SQL virtual machine group or availability group listener.",
  {
    $host: string,
  }
)
@doc("""
The SQL virtual machine management API provides a RESTful set of web APIs that
interact with Azure Compute, Network & Storage services to manage your SQL
Server virtual machine. The API enables users to create, delete and retrieve a
SQL virtual machine, SQL virtual machine group or availability group listener.
""")
namespace SqlVirtualMachineManagementClient;
