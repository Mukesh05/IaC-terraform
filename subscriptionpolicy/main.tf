locals {
  policy_subs = setproduct(var.subsid, var.policyname)
  policy_params= zipmap(var.policyname, var.parameters)
}

data "azurerm_subscription" "subspolicy" {
  for_each = {
    for q in local.policy_subs : "${q[0]}-${q[1]}" => {
      subsid = q[0]
      policyname = q[1]
    }
  }
  subscription_id = each.value.subsid
}

data "azurerm_policy_definition" "policy" {
  for_each = {
    for q in local.policy_subs : "${q[0]}-${q[1]}" => {
      subsid = q[0]
      policyname = q[1]
    }
  }
  display_name = each.value.policyname
}

resource "azurerm_subscription_policy_assignment" "policyassign" {
  for_each = {
    for q in local.policy_subs : "${q[0]}-${q[1]}" => {
      sid = substr(replace(q[0],"-",""),0,10)
      pname = join("",regexall("[^%&?/<>:]",q[1]))
      param_value = lookup(local.policy_params,q[1])
    }
  }
  name                 = substr("${each.value.pname}-${each.value.sid}",0,64)
  policy_definition_id = data.azurerm_policy_definition.policy[each.key].id
  subscription_id      = data.azurerm_subscription.subspolicy[each.key].id
  parameters           = jsonencode(each.value.param_value)
}
