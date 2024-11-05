data:extend(
{
  -- TODO boskid: temporary list for compatibility, it would be nice to rework that list from scratch
  { type = "collision-layer", order = "06", name = "rail" },
  { type = "collision-layer", order = "20", name = "trigger_target" }, -- for collision masks that collide with nothing, but still need to be targetable by trigger events
})