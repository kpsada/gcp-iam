# Create IAM Groups

## Feature List
* Create groups on organization level from a map
* Associate iam roles to each group on org level
* Owners/Managers/Members are all treated as optional for each group

## Usage example
```
locals {
  iam_groups = {
    "abc-organization-admins" = {
      "roles" = [
        "roles/billing.user",
        "roles/cloudsupport.admin",
        "roles/iam.organizationRoleAdmin",
        "roles/resourcemanager.organizationAdmin"
      ],
      "members" = []
    },

    "abc-billing-admins" = {
      "roles" = [
        "roles/billing.admin"
      ],
    },
  }

}

# Create IAM Groups
module "iam_groups" {
  for_each      = local.iam_groups
  source        = "../modules/iam/org-identity-group"
  org_id        = local.org_id
  group_id      = each.key
  display_name  = "${local.resource_prefix}-${each.key}"
  description   = "IAM Group for ${each.key}"
  domain        = local.domain
  org_iam_roles = each.value["roles"]
  owners        = can(each.value["owners"]) ? each.value["owners"] : []
  managers      = can(each.value["managers"]) ? each.value["managers"] : []
  members       = can(each.value["members"]) ? each.value["members"] : []
}

```
