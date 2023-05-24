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

resource "google_organization_iam_member" "org-group-roles" {
  for_each = var.group_id != "" ? toset(var.org_iam_roles) : []
  org_id   = var.org_id
  role     = each.key
  member   = "group:${module.iam_group.id}"
}
