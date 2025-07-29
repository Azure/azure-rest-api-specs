---
mode: 'agent'
tools: [CheckServiceLabel', 'CreateServiceLabel'] 
---

# Goal
- Validate the service label for the corresponding API spec and create a pull request if necessary. 

## Step 1: Prompt for Service Label
- Ask user if they have a label to their service.

## Step 2: Validate Service Label
- If a label is provided by the user, use `CheckServiceLabel` to validate the service label for the corresponding API spec
    - If the service label is valid and exists, skip remaining label validation steps and allow user to proceed with the SDK release process. Service label in the common-labels.csv file MUST have "e99695" as the color code.
- If the service label is invalid or was not provided by the user:
    - If it's invalid, inform the user that the service label is invalid. Ask them to double check spelling, punctuation, and space usage. Label may exist in the common-labels.csv file but may not be associated with a service.
    - Fetch common-labels.csv file from the azure-sdk-tools repository and check if any existing label could fit under the service. If a related service label name already exists in the file, ask and confirm if the user wants to use that existing label for their service.
        - If the user confirms, use that existing label. Skip remaining label validation steps and proceed with the SDK release process
    - If user wants to create an entirely new service label instead, suggest a label name to the user and have them confirm the recommended label name
        - Service label naming guidance:
            - Fetch common-labels.csv file from the azure-sdk-tools repository and look at the service's API spec to find a suitable and relevant name
            - Label text should not include the following words: Microsoft, Azure
            - Label text should be in Title Case. Title case means capitalize the first letter of each word, except short prepositions (in, for, of) unless they are the first or last word
            - If multiple words, use spaces to separate them. Avoid using underscores or hyphens
- Make note of the corresponding service label name the user has confirmed or provided

## Step 3: Create Pull Request (only if new service label is created)
- If a new service label was created and confirmed by the user, create a pull request using `CreateServiceLabel` that adds the new service label to the common-labels.csv file in the azure-sdk-tools repository
    - Ensure that the pull request:
        - Is in a branch separate from the main branch
            - If the branch already exists, guide user to the compare link to review the changes
        - Inserts the new service label name so that the file maintains alphabetical order
        - Uses "e99695" as the color code for the new service label
- Provide the user with a link to the pull request for review and merging
- Inform the user that they can proceed with the SDK release process once the pull request is approved and merged to the main branch
