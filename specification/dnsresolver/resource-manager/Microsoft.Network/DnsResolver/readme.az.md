# AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
    extensions: dns-resolver
    namespace: azure.mgmt.dnsresolver
    package-name: azure-mgmt-dnsresolver
az-output-folder: $(azure-cli-extension-folder)/src/dns-resolver
python-sdk-output-folder: "$(az-output-folder)/azext_dnsresolver/vendored_sdks/dnsresolver"

# add additional configuration here specific for Azure CLI
# refer to the faq.md for more details
extension-mode: preview

cli:
  cli-directive:
# rename command groups
    - where:
        group: 'DnsForwardingRulesets'
      name: 'forwarding_rulesets'
    - where:
        group: 'VirtualNetworkLinks'
      name: 'vnet_links'
# rename commands
    - where:
        group: 'DnsResolvers'
        op: 'ListByVirtualNetwork'
      name: 'list'
    - where:
        group: 'DnsForwardingRulesets'
        op: 'ListByVirtualNetwork'
      name: 'list'
# add alias to parameters
    - where:
        group: ForwardingRules
        parameter: dnsForwardingRulesetName
      alias:
        - ruleset_name
    - where:
        group: VirtualNetworkLinks
        parameter: dnsForwardingRulesetName
      alias:
        - ruleset_name
    - where:
        group: DnsForwardingRulesets
        op: CreateOrUpdate#Create
        parameter: dnsResolverOutboundEndpoints
      alias:
        - outbound_endpoints
```