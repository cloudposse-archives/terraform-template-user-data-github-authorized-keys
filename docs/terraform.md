
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| flavor | Flavor depends of OS and init system | string | `debian-systemd` | no |
| github_api_token | GitHub API Token | string | - | yes |
| github_organization | GitHub Organization Containing Team | string | - | yes |
| github_team | GitHub Team for Membership to Grant SSH Access | string | - | yes |
| name | Name  (e.g. `app` or `cluster`) | string | - | yes |
| namespace | Namespace (e.g. `cp` or `cloudposse`) | string | - | yes |
| stage | Stage (e.g. `prod`, `dev`, `staging`) | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| user_data | User data script that should be executed on startup |

