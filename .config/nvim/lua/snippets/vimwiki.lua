local diary_template =
[[= ${vim.api.nvim_buf_get_name(0):match(".*/(.*)%.")} =

$C

== Lembretes ==
    - [ ] ]]

return {
    diary_template = diary_template
}
