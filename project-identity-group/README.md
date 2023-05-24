# Create IAM Groups

## Feature List
* Create groups on organization level from a map
* Associate iam roles to each group on project level
* Owners/Managers/Members are all treated as optional for each group

## Usage example
```
locals {
  iam_groups = {
    "group-anthos-administrator" = [
      "roles/gkehub.viewer", "roles/gkehub.gatewayAdmin", "roles/container.admin", "roles/logging.admin", "roles/monitoring.admin"
    ]

    "group-anthos-editor" = [
      "roles/gkehub.viewer", "roles/gkehub.gatewayReader", "roles/container.developer", "roles/logging.configWriter", "roles/monitoring.editor"
    ]

    "group-anthos-viewer" = [
      "roles/gkehub.viewer", "roles/gkehub.gatewayReader", "roles/container.viewer", "roles/logging.viewer", "roles/monitoring.viewer"
    ]
  }
}

module "iam_groups" {
  for_each          = local.iam_groups
  source            = "../../modules/iam/project-identity-group"
  project           = local.project_id
  group_id          = each.key
  display_name      = "${local.resource_prefix}-${each.key}"
  description       = "IAM Group for ${each.key}"
  domain            = local.domain
  project_iam_roles = each.value["roles"]
  owners            = can(each.value["owners"]) ? each.value["owners"] : []
  managers          = can(each.value["managers"]) ? each.value["managers"] : []
  members           = can(each.value["members"]) ? each.value["members"] : []
  depends_on        = [google_project_service.main]
}

```
