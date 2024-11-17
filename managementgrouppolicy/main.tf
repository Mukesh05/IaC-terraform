locals {
  policy_mg = setproduct(var.mgname, var.policyname)
  policy_params= zipmap(var.policyname, var.parameters)
}

data "azurerm_management_group" "mangroup" {
  for_each = {
    for q in local.policy_mg : "${q[0]}-${q[1]}" => {
      mgname = q[0]
      policyname = q[1]
    }
  }
  name  = each.value.mgname
}

data "azurerm_policy_definition" "policy" {
  for_each = {
    for q in local.policy_mg : "${q[0]}-${q[1]}" => {
      mgname = q[0]
      policyname = q[1]
    }
  }
  display_name = each.value.policyname
}

resource "azurerm_management_group_policy_assignment" "assignment" {
  for_each = {
    for q in local.policy_mg : "${q[0]}-${q[1]}" => {
      policyname = join("",regexall("[^%&?/<>:]",q[1]))
      mgname = q[0]
      param_value = lookup(local.policy_params,q[1])
    }
  }
  name                 = substr("${each.value.mgname}-${each.value.policyname}",0,64)
  policy_definition_id = data.azurerm_policy_definition.policy[each.key].id
  management_group_id  = data.azurerm_management_group.mangroup[each.key].id
  parameters           = jsonencode(each.value.param_value)
}
