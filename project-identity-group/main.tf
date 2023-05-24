module "iam_group" {
  source       = "terraform-google-modules/group/google"
  version      = "~> 0.1"
  id           = "${var.group_id}@${var.domain}"
  display_name = var.display_name
  description  = var.description
  domain       = var.domain
  owners       = var.owners
  managers     = var.managers
  members      = var.members
}

resource "google_project_iam_member" "gcp-group-roles" {
  for_each = toset(var.project_iam_roles)
  project  = var.project
  role     = each.key
  member   = "group:${module.iam_group.id}"
}

resource "google_cloud_identity_group_membership" "parent-groups" {
  for_each = toset(var.group_memberships)
  group    = "groups/${each.key}"

  preferred_member_key {
    id = module.iam_group.id
  }

  roles {
      name = "MEMBER"
  }
}