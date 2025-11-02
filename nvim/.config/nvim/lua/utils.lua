local M = {}

function M.deduplicate_locations(locations)
  local unique_locations = {}
  local seen = {}

  for _, location in ipairs(locations) do
    local key = string.format("%s:%d:%d", location.uri, location.range.start.line, location.range.start.character)
    if not seen[key] then
      table.insert(unique_locations, location)
      seen[key] = true
    end
  end

  return unique_locations
end

return M