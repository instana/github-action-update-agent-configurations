# Github Action for triggering the configuration update of Instana host agents

This GitHub action remotely triggers the update of the configuration of Instana host agents that are configured to use the [Git-based Configuration Management](https://www.instana.com/docs/setup_and_manage/host_agent/configuration/git_ops) capability.
The selection of which agents to update is based on a combination of agent zone and tags.

## Setup

### Variables

Set the following variables as secrets for your repository:

- `INSTANA_API_ENDPOINT`: The API endpoint of your Instana backend, e.g., `https://my-awesome.instana.io`. Notice that, for self-managed Instana backends, you will likely need to set in the the port, e.g., `https://instana.acme.org:1444`.
- `INSTANA_API_KEY`: The API token to use for authentication; it _must_ have the `Configuration of agents` permission.

### Inputs

Either or both the following parameters:

- `agent_zone`: The host zone to match; refer to the [Custom Zones](https://www.instana.com/docs/setup_and_manage/host_agent/configuration#custom-zones) documentation for more info on how to set up agent zones in Instana.
- `agent_tags`: A comma-separated list of host tags to match; refer to the [Specify Host Tags](https://www.instana.com/docs/setup_and_manage/host_agent/configuration#specify-host-tags) documentation for more info on how to set up agent tags in Instana.

### Outputs

None

## Example usage

This section shows how to use this GitHub action in your `github/workflows` files.
For more information on how to setup GitHub workflows, refer to the [Configuring a workflow
](https://docs.github.com/en/actions/configuring-and-managing-workflows/configuring-a-workflow) documentation.

### Using both Host agent Tags and Zone

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: instana/github-action-instana-gitops-update-configurations@v1.0.0
      with:
        agent_zone: 'prod_emea'
        agent_tags: 'gitops_environment=prod,team=awesome'
      env:
        INSTANA_API_ENDPOINT: ${{ secrets.INSTANA_API_ENDPOINT }}
        INSTANA_API_KEY: ${{ secrets.INSTANA_API_KEY }}
```

### Using only Host agent Tags

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: instana/github-action-instana-gitops-update-configurations@v1.0.0
      with:
        agent_tags: 'gitops_environment=prod,team=awesome'
      env:
        INSTANA_API_ENDPOINT: ${{ secrets.INSTANA_API_ENDPOINT }}
        INSTANA_API_KEY: ${{ secrets.INSTANA_API_KEY }}
```

### Using only Host agent Zone

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: instana/github-action-instana-gitops-update-configurations@v1.0.0
      with:
        agent_zone: 'prod_emea'
      env:
        INSTANA_API_ENDPOINT: ${{ secrets.INSTANA_API_ENDPOINT }}
        INSTANA_API_KEY: ${{ secrets.INSTANA_API_KEY }}
```
