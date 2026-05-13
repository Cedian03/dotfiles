-- https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

for i = 1, 5 do
    hl.workspace_rule({ workspace = tostring(i), persistent = true })
end
