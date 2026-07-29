import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@service(#{ title: "Invoice Processor" })
@versioned(Versions)
@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.clientCredentials,
      tokenUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/token",
      scopes: ["https://invoiceprocessor.azure.com/.default"],
    }
  ]>
)
@server("https://{endpoint}", "Invoice Processor service", { endpoint: string })
namespace InvoiceProcessor;

enum Versions {
  v2026_01_01: "2026-01-01",
}

@doc("An error.")
@error
model InvoiceError {
  @doc("The error code.")
  code: string;

  @doc("The error message.")
  errorMessage: string;

  @doc("Internal diagnostic information.")
  debugInfo?: string;
}

@doc("An invoice submitted for processing.")
@resource("invoices")
model Invoice {
  @doc("The unique identifier of the invoice.")
  @key
  @visibility(Lifecycle.Read)
  invoiceId: string;

  @doc("Name of the vendor that issued the invoice.")
  vendorName: string;

  @doc("Total amount payable, in the invoice currency.")
  totalAmount: float64;

  @doc("ISO 4217 currency code of the invoice, for example USD.")
  currencyCode: string;

  @doc("Line items on the invoice.")
  lineItems: InvoiceLineItem[];
}

@doc("A single line item on an invoice.")
model InvoiceLineItem {
  @doc("Description of the goods or services.")
  description: string;

  @doc("Amount payable for this line item, in the invoice currency.")
  amount: float64;
}

@doc("""
  Submits an invoice for processing.

  On failure the service returns code `InvalidRequest` with a message such as
  "Invalid request" or, for internal faults,
  "System.InvalidOperationException at InvoiceParser.Parse (host inv-proc-03)".
  """)
@route("/invoices")
@post
op submitInvoice(@body body: Invoice): Invoice | InvoiceError;

@doc("Gets an invoice by identifier.")
@route("/invoices/{invoiceId}")
@get
op getInvoice(@path invoiceId: string): Invoice | InvoiceError;
