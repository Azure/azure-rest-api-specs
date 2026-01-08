import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;


@doc("Event Grid Event")
model EventGridEvent {
  @doc("quiet")
  @header("content-type") contentType: "eventgrid";

  @doc("id")
  id: string;
}

@doc("Cloud Event Event")
model CloudEvent {
  @doc("quiet")
  @header("content-type") contentType: "cloudevent";

  @doc("name")
  name: string;
}


alias EventType = EventGridEvent | CloudEvent;

@doc("Send Operation")
@route("/send", { shared: true})
op send is Azure.Core.RpcOperation<{ @doc("Body is a union of EventGridEvent and CloudEvent") @body _: EventType}, {}>;

@doc("Send CloudEvent Operation")
@overload(send)
@route("/send", { shared: true})
op sendCloudEvent is Azure.Core.RpcOperation<{ @doc("Body is a CloudEvent") @body _: CloudEvent }, {}>;

@doc("Send EventGridEvent Operation")
@overload(send)
@route("/send", { shared: true})
op sendEventGridEvent is Azure.Core.RpcOperation<{ @doc("Body is an EventGridEvent") @body _: EventGridEvent }, {}>;