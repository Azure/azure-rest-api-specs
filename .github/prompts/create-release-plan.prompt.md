---
mode: 'agent'
tools: ['CreateReleasePlan', 'GetReleasePlanForPullRequest', 'GetReleasePlan', 'LinkSdkPullRequestToReleasePlan']
---

# Release Plan Creation Process

Follow these steps in order to create or manage a release plan for an API specification pull request:

## Step 1: Validate Prerequisites
- Check if an API spec pull request is available in the current context
- If no pull request is available, prompt the user to provide the API spec pull request link
- Validate that the provided pull request link is accessible and valid

## Step 2: Check Existing Release Plan
- Use `GetReleasePlanForPullRequest` to check if a release plan already exists for the API spec pull request
- If a release plan exists:
    - Display the existing release plan details to the user
    - Skip to Step 5 (Link SDK Pull Requests)
- If no release plan exists, proceed to Step 3

## Step 3: Gather Release Plan Information
Collect the following required information from the user. If any details are missing, prompt the user accordingly:

- **API Lifecycle Stage**: Must be one of:
    - Private Preview
    - Public Preview  
    - GA (Generally Available)
- **Service Tree ID**: GUID format identifier for the service in Service Tree
- **Product Service Tree ID**: GUID format identifier for the product in Service Tree
- **Expected Release Timeline**: Format as "Month YYYY" (e.g., "March 2024")
- **API Version**: The version of the API being released
- **SDK Release Type**: 
    - "beta" for preview API versions
    - "stable" for GA API versions

## Step 4: Create Release Plan
- If the user doesn't know the required details, direct them to create a release plan using the release planner
- Provide this resource: [Release Plan Creation Guide](https://eng.ms/docs/products/azure-developer-experience/plan/release-plan-create)
- Once all information is gathered, use `CreateReleasePlan` to create the release plan
- Display the newly created release plan details to the user for confirmation

## Step 5: Link SDK Pull Requests (if applicable)
- Ask the user if they have already created SDK pull requests locally for any programming language
- If SDK pull requests exist:
    - Collect the pull request links from the user
    - Use `LinkSdkPullRequestToReleasePlan` to link each SDK pull request to the release plan
    - Confirm successful linking for each SDK pull request

## Step 6: Summary
- Display a summary of the completed actions:
    - Release plan status (created or existing)
    - Linked SDK pull requests (if any)
    - Next steps or recommendations for the user