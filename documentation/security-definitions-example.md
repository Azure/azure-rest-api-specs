"securityDefinitions": {
    "azure_auth": {
        "type": "oauth2",
        "authorizationUrl": "https://login.microsoftonline.com/common/oauth2/authorize",
        "flow": "implicit",
        "description": "Azure Active Directory OAuth2 Flow",
        "scopes": {
        "user_impersonation": "impersonate your user account"
        }
    }
}
