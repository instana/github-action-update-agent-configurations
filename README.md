# Github Action for triggering the configuration update of Instana host agents

This GitHub action allows you to remotely trigger the configuration update of Instana host agents that are configured to use the [Git-based Configuration Management](https://www.instana.com/docs/setup_and_manage/host_agent/configuration/git_ops) capability.

## Setup

### Variables

Set the following variables as secrets for your repository:

- `INSTANA_API_ENDPOINT`: The API endpoint of your Instana backend, e.g., https://my-awesome.instana.io . Notice that, for self-managed Instana backends, you will likely need to add the port, e.g., 1444.
- `INSTANA_API_KEY`: The API token to use for authentication, it must have the `Configuration of agents` permission.

### Inputs

- `agentKey`: The host agent tag to match; refer to the [Specify Host Tags](https://www.instana.com/docs/setup_and_manage/host_agent/configuration#specify-host-tags) documentation for more info on how to set up host tags in Instana.

### Outputs

None

## Example usage

```yaml
uses: mmanciop/instana-gitops-trigger-agent-update@v1
with:
  agentTag: 'gitops_environment=prod'
env:
  INSTANA_API_ENDPOINT: ${{ secrets.INSTANA_API_ENDPOINT }}
  INSTANA_API_KEY: ${{ secrets.INSTANA_API_KEY }}
```
