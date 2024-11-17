module "subsbuiltpolicy" {
    for_each   = var.subspolicyname
    source     = "./subscriptionpolicy"
    subsid     = each.value.subsid
    policyname = each.value.policyname
    parameters = each.value.parameters
}

module "mgbuiltpolicy" {
    for_each   = var.mgpolicyname
    source     = "./managementgrouppolicy"
    mgname     = each.value.mgname
    policyname = each.value.policyname
    parameters = each.value.parameters
}

module "rgbuiltpolicy" {
    for_each        = var.rgpolicyname
    source          = "./resourcegrouppolicy"
    rgname          = each.value.rgname
    policyname      = each.value.policyname
    subscription_id = each.value.subscription_id
    parameters      = each.value.parameters
}
